import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/parcel_dao.dart';
import '../../../../core/database/daos/vertex_photo_dao.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/storage/photo_storage.dart';
import '../domain/entities/vertex_photo.dart';
import '../domain/repositories/vertex_photo_repository.dart';

/// Metadatos de fotografías sobre Drift y binarios en almacenamiento privado.
class DriftVertexPhotoRepository implements VertexPhotoRepository {
  DriftVertexPhotoRepository(this._dao, this._storage, this._parcelDao);

  final VertexPhotoDao _dao;
  final PhotoStorage _storage;
  final ParcelDao _parcelDao;

  @override
  Future<List<VertexPhoto>> findByVertex(String vertexId) async =>
      (await _dao.findByVertex(vertexId))
          .map((row) => row.toPhotoEntity())
          .toList();

  @override
  Future<List<VertexPhoto>> findAll() async =>
      (await _dao.findAll()).map((row) => row.toPhotoEntity()).toList();

  @override
  Future<VertexPhoto?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toPhotoEntity();
  }

  @override
  Future<VertexPhoto> addFromFile({
    required String vertexId,
    required String sourcePath,
    String? description,
  }) async {
    final relativePath = await _storage.copyFrom(sourcePath);
    if (relativePath == null) {
      throw const ValidationFailure(
        'La imagen seleccionada ya no está disponible.',
      );
    }
    final photo = VertexPhoto(
      id: const Uuid().v4(),
      vertexId: vertexId,
      relativePath: relativePath,
      fileName: p.basename(relativePath),
      description: description,
      createdAt: DateTime.now().toUtc(),
    );
    try {
      await _dao.insert(
        VertexPhotosCompanion(
          id: Value(photo.id),
          vertexId: Value(photo.vertexId),
          relativePath: Value(photo.relativePath),
          fileName: Value(photo.fileName),
          description: Value(photo.description),
          createdAt: Value(photo.createdAt),
        ),
      );
    } on AppFailure {
      await _storage.deleteRelative(relativePath);
      rethrow;
    } catch (_) {
      // El archivo copiado no debe quedar huérfano si falla el registro.
      await _storage.deleteRelative(relativePath);
      throw const StorageFailure('No se pudo registrar la fotografía.');
    }
    return photo;
  }

  @override
  Future<void> delete(String id) async {
    final row = await _dao.findById(id);
    if (row == null) return;
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure('No se pudo eliminar la fotografía.');
    }
    await _storage.deleteRelative(row.relativePath);
  }

  @override
  Future<List<VertexPhoto>> findWithMissingFiles() async {
    final rows = await _dao.findAll();
    final missing = <VertexPhoto>[];
    for (final row in rows) {
      if (!await _storage.exists(row.relativePath)) {
        missing.add(row.toPhotoEntity());
      }
    }
    return missing;
  }

  @override
  Future<int> cleanOrphans() async {
    // Las fotos de parcela también viven en el mismo almacenamiento privado:
    // si no se declaran como conocidas, la depuración las borraría.
    final known = <String>[
      ...await _dao.allRelativePaths(),
      ...await _parcelDao.allImagePaths(),
    ];
    return _storage.cleanOrphans(known);
  }
}

extension VertexPhotoRowMapper on VertexPhotoRow {
  VertexPhoto toPhotoEntity() => VertexPhoto(
        id: id,
        vertexId: vertexId,
        relativePath: relativePath,
        fileName: fileName,
        description: description,
        createdAt: createdAt,
      );
}
