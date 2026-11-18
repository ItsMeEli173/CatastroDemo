import 'package:drift/drift.dart';

import '../../../features/parcels/domain/entities/parcel.dart';
import '../app_database.dart';
import '../query_utils.dart';
import '../tables.dart';

part 'parcel_dao.g.dart';

/// Consultas de parcelas.
@DriftAccessor(tables: [Parcels, ParcelOwners, ParcelVertices, VertexPhotos])
class ParcelDao extends DatabaseAccessor<AppDatabase> with _$ParcelDaoMixin {
  ParcelDao(super.db);

  Expression<bool>? _search(String query) {
    if (query.trim().isEmpty) return null;
    final pattern = likeContains(query);
    return parcels.code.lower().like(pattern, escapeChar: '\\') |
        parcels.name
            .cast<String>()
            .lower()
            .like(pattern, escapeChar: '\\');
  }

  SimpleSelectStatement<$ParcelsTable, ParcelRow> _select({
    String query = '',
    ParcelStatus? status,
  }) {
    final statement = select(parcels);
    final predicate = _search(query);
    if (predicate != null) {
      statement.where((_) => predicate);
    }
    if (status != null) {
      statement.where((t) => t.status.equalsValue(status));
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.code)]);
    return statement;
  }

  Stream<List<ParcelRow>> watchAll({
    String query = '',
    ParcelStatus? status,
  }) =>
      _select(query: query, status: status).watch();

  Future<List<ParcelRow>> findAll({
    String query = '',
    ParcelStatus? status,
  }) =>
      _select(query: query, status: status).get();

  Future<ParcelRow?> findById(String id) =>
      (select(parcels)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<ParcelRow?> watchById(String id) =>
      (select(parcels)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<ParcelRow?> findByCode(String code) =>
      (select(parcels)..where((t) => t.code.lower().equals(code.trim().toLowerCase())))
          .getSingleOrNull();

  Stream<List<ParcelRow>> watchByFarmer(String farmerId) {
    final query = select(parcels).join([
      innerJoin(parcelOwners, parcelOwners.parcelId.equalsExp(parcels.id)),
    ])
      ..where(parcelOwners.farmerId.equals(farmerId))
      ..orderBy([OrderingTerm.asc(parcels.code)]);
    return query
        .watch()
        .map((rows) => rows.map((row) => row.readTable(parcels)).toList());
  }

  Future<List<ParcelRow>> findByFarmer(String farmerId) async {
    final query = select(parcels).join([
      innerJoin(parcelOwners, parcelOwners.parcelId.equalsExp(parcels.id)),
    ])
      ..where(parcelOwners.farmerId.equals(farmerId))
      ..orderBy([OrderingTerm.asc(parcels.code)]);
    final rows = await query.get();
    return rows.map((row) => row.readTable(parcels)).toList();
  }

  Stream<int> watchCount() {
    final countExpression = parcels.id.count();
    final query = selectOnly(parcels)..addColumns([countExpression]);
    return query.map((row) => row.read(countExpression) ?? 0).watchSingle();
  }

  Future<int> count() async {
    final countExpression = parcels.id.count();
    final query = selectOnly(parcels)..addColumns([countExpression]);
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> upsert(ParcelsCompanion companion) async {
    await into(parcels).insertOnConflictUpdate(companion);
  }

  Future<void> updateCalculatedArea({
    required String parcelId,
    required double? areaM2,
    required DateTime updatedAt,
  }) async {
    await (update(parcels)..where((t) => t.id.equals(parcelId))).write(
      ParcelsCompanion(
        calculatedAreaM2: Value(areaM2),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  Future<void> updateStatus({
    required String parcelId,
    required ParcelStatus status,
    required DateTime updatedAt,
  }) async {
    await (update(parcels)..where((t) => t.id.equals(parcelId))).write(
      ParcelsCompanion(
        status: Value(status),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  Future<int> deleteById(String id) =>
      (delete(parcels)..where((t) => t.id.equals(id))).go();

  /// Rutas relativas de las fotografías de todos los vértices de la parcela.
  Future<List<String>> photoRelativePathsByParcel(String parcelId) async {
    final query = select(vertexPhotos).join([
      innerJoin(
        parcelVertices,
        parcelVertices.id.equalsExp(vertexPhotos.vertexId),
      ),
    ])
      ..where(parcelVertices.parcelId.equals(parcelId));
    final rows = await query.get();
    return rows.map((row) => row.readTable(vertexPhotos).relativePath).toList();
  }
}
