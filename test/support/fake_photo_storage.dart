import 'dart:io';

import 'package:catastrodemo/core/storage/photo_storage.dart';

/// Doble de [PhotoStorage] sin E/S real ni compresión.
///
/// `testWidgets` corre en una zona de async falso: un `await` de E/S real nunca
/// se completaría. Este doble resuelve desde un mapa en memoria y registra los
/// borrados en [deleted].
class FakePhotoStorage extends PhotoStorage {
  FakePhotoStorage({Map<String, File>? files}) : _files = files ?? {};

  final Map<String, File> _files;

  /// Rutas relativas que se pidieron borrar, en orden.
  final List<String> deleted = <String>[];

  @override
  Future<File?> resolve(String relativePath) async => _files[relativePath];

  @override
  Future<bool> exists(String relativePath) async =>
      _files.containsKey(relativePath);

  @override
  Future<void> deleteRelative(String relativePath) async {
    deleted.add(relativePath);
    _files.remove(relativePath);
  }

  @override
  Future<List<String>> missingFiles(Iterable<String> relativePaths) async =>
      <String>[
        for (final path in relativePaths)
          if (!_files.containsKey(path)) path,
      ];

  @override
  Future<int> cleanOrphans(Iterable<String> knownRelativePaths) async => 0;
}
