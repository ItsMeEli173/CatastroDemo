import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'vertex_photo_dao.g.dart';

/// Consultas de metadatos de fotografías de vértices.
@DriftAccessor(tables: [VertexPhotos, ParcelVertices])
class VertexPhotoDao extends DatabaseAccessor<AppDatabase>
    with _$VertexPhotoDaoMixin {
  VertexPhotoDao(super.db);

  Future<List<VertexPhotoRow>> findByVertex(String vertexId) =>
      (select(vertexPhotos)
            ..where((t) => t.vertexId.equals(vertexId))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get();

  Future<List<VertexPhotoRow>> findAll() => (select(vertexPhotos)
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
      .get();

  Future<VertexPhotoRow?> findById(String id) =>
      (select(vertexPhotos)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Cantidad de fotografías registradas para un vértice.
  Future<int> countByVertex(String vertexId) async {
    final countExpression = vertexPhotos.id.count();
    final query = selectOnly(vertexPhotos)
      ..addColumns([countExpression])
      ..where(vertexPhotos.vertexId.equals(vertexId));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> insert(VertexPhotosCompanion companion) async {
    await into(vertexPhotos).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(vertexPhotos)..where((t) => t.id.equals(id))).go();

  Future<List<String>> allRelativePaths() async {
    final rows = await select(vertexPhotos).get();
    return rows.map((row) => row.relativePath).toList();
  }
}
