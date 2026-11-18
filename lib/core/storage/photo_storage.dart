import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../errors/app_failure.dart';
import '../media/photo_compressor.dart';

/// Almacenamiento privado de fotografías.
///
/// Los binarios viven bajo `<documentos>/photos`; en SQLite solo se guarda la
/// ruta relativa (`photos/<archivo>`), nunca una ruta absoluta.
class PhotoStorage {
  PhotoStorage({
    Future<Directory> Function()? documentsDirectoryProvider,
    PhotoCompressor? compressor,
  })  : _documentsDirectoryProvider =
            documentsDirectoryProvider ?? getApplicationDocumentsDirectory,
        _compressor = compressor ?? const PhotoCompressor();

  final Future<Directory> Function() _documentsDirectoryProvider;
  final PhotoCompressor _compressor;
  Directory? _cachedDirectory;

  static const String folderName = 'photos';

  /// Directorio privado de fotografías, creado si no existe.
  Future<Directory> photosDirectory() async {
    final cached = _cachedDirectory;
    if (cached != null && await cached.exists()) return cached;
    try {
      final documents = await _documentsDirectoryProvider();
      final directory = Directory(p.join(documents.path, folderName));
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      _cachedDirectory = directory;
      return directory;
    } catch (_) {
      throw const StorageFailure(
        'No se pudo acceder al almacenamiento de fotografías.',
      );
    }
  }

  /// Comprime el archivo y lo copia al almacenamiento privado, devolviendo su
  /// ruta relativa. Devuelve `null` si el origen no existe.
  ///
  /// Es el único punto por el que entran fotografías al sandbox, así que la
  /// compresión vale para todos los flujos (parcelas y vértices).
  ///
  /// Nunca se descarta la foto original: si no se puede decodificar, o si el
  /// resultado comprimido no es más liviano, se guarda el archivo tal cual.
  Future<String?> copyFrom(String sourcePath) async {
    final source = File(sourcePath);
    if (!await source.exists()) return null;
    try {
      final directory = await photosDirectory();
      final originalBytes = await source.readAsBytes();
      final compressed = await _compressor.compress(originalBytes);
      final keepCompressed =
          compressed != null && compressed.length < originalBytes.length;

      final rawExtension = p.extension(sourcePath).toLowerCase();
      final fallbackExtension = rawExtension.isEmpty ? '.jpg' : rawExtension;
      final extension = keepCompressed ? '.jpg' : fallbackExtension;
      final fileName = 'photo_${const Uuid().v4()}$extension';
      await File(p.join(directory.path, fileName)).writeAsBytes(
        keepCompressed ? compressed : originalBytes,
        flush: true,
      );
      return '$folderName/$fileName';
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar la fotografía.');
    }
  }

  /// Archivo correspondiente a una ruta relativa registrada, si existe.
  Future<File?> resolve(String relativePath) async {
    final file = await _fileFor(relativePath);
    return await file.exists() ? file : null;
  }

  Future<bool> exists(String relativePath) async {
    final file = await _fileFor(relativePath);
    return file.exists();
  }

  /// Elimina el archivo si existe; no falla cuando ya no está.
  Future<void> deleteRelative(String relativePath) async {
    try {
      final file = await _fileFor(relativePath);
      if (await file.exists()) await file.delete();
    } catch (_) {
      // La ausencia del archivo nunca debe impedir borrar el registro.
    }
  }

  /// Rutas relativas registradas cuyos archivos ya no existen.
  Future<List<String>> missingFiles(Iterable<String> relativePaths) async {
    final missing = <String>[];
    for (final relativePath in relativePaths) {
      if (!await exists(relativePath)) missing.add(relativePath);
    }
    return missing;
  }

  /// Elimina archivos del directorio privado sin registro en la base.
  Future<int> cleanOrphans(Iterable<String> knownRelativePaths) async {
    final knownFileNames = knownRelativePaths
        .map((relativePath) => p.basename(relativePath))
        .toSet();
    try {
      final directory = await photosDirectory();
      var removed = 0;
      await for (final entity in directory.list()) {
        if (entity is! File) continue;
        if (knownFileNames.contains(p.basename(entity.path))) continue;
        await entity.delete();
        removed++;
      }
      return removed;
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudieron depurar las fotografías.');
    }
  }

  Future<File> _fileFor(String relativePath) async {
    final directory = await photosDirectory();
    final fileName = p.basename(relativePath);
    return File(p.join(directory.path, fileName));
  }
}
