import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'parcel_vertex_dao.g.dart';

/// Consultas de la geometría de parcelas.
@DriftAccessor(tables: [ParcelVertices, VertexPhotos])
class ParcelVertexDao extends DatabaseAccessor<AppDatabase>
    with _$ParcelVertexDaoMixin {
  ParcelVertexDao(super.db);

  Stream<List<ParcelVertexRow>> watchByParcel(String parcelId) => (select(parcelVertices)
        ..where((t) => t.parcelId.equals(parcelId))
        ..orderBy([(t) => OrderingTerm.asc(t.sequenceNumber)]))
      .watch();

  Future<List<ParcelVertexRow>> findByParcel(String parcelId) => (select(parcelVertices)
        ..where((t) => t.parcelId.equals(parcelId))
        ..orderBy([(t) => OrderingTerm.asc(t.sequenceNumber)]))
      .get();

  Future<int> countByParcel(String parcelId) async {
    final countExpression = parcelVertices.id.count();
    final query = selectOnly(parcelVertices)
      ..addColumns([countExpression])
      ..where(parcelVertices.parcelId.equals(parcelId));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> upsert(ParcelVerticesCompanion companion) async {
    await into(parcelVertices).insertOnConflictUpdate(companion);
  }

  /// Elimina los vértices de la parcela que no están en [keepIds] y devuelve las
  /// rutas relativas de las fotografías asociadas, para borrar sus archivos.
  Future<List<String>> deleteVerticesExcept(
    String parcelId,
    List<String> keepIds,
  ) async {
    final parcelPredicate = parcelVertices.parcelId.equals(parcelId);
    final predicate = keepIds.isEmpty
        ? parcelPredicate
        : parcelPredicate & parcelVertices.id.isNotIn(keepIds);
    final doomed = await (select(parcelVertices)..where((_) => predicate)).get();
    if (doomed.isEmpty) return const [];
    final ids = doomed.map((vertex) => vertex.id).toList();
    final photos = await (select(vertexPhotos)..where((t) => t.vertexId.isIn(ids))).get();
    await (delete(parcelVertices)..where((t) => t.id.isIn(ids))).go();
    return photos.map((photo) => photo.relativePath).toList();
  }

  Future<List<String>> photoPathsByVertex(String vertexId) async {
    final photos =
        await (select(vertexPhotos)..where((t) => t.vertexId.equals(vertexId))).get();
    return photos.map((photo) => photo.relativePath).toList();
  }
}
