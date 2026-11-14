import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'parcel_variety_dao.g.dart';

/// Consultas de la distribución de variedades por parcela.
@DriftAccessor(tables: [ParcelVarieties, GrapeVarieties])
class ParcelVarietyDao extends DatabaseAccessor<AppDatabase>
    with _$ParcelVarietyDaoMixin {
  ParcelVarietyDao(super.db);

  Stream<List<ParcelVarietyRow>> watchByParcel(String parcelId) =>
      (select(parcelVarieties)
            ..where((t) => t.parcelId.equals(parcelId))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .watch();

  Future<List<ParcelVarietyRow>> findByParcel(String parcelId) =>
      (select(parcelVarieties)
            ..where((t) => t.parcelId.equals(parcelId))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get();

  Future<List<ParcelVarietyRow>> findAll() =>
      (select(parcelVarieties)..orderBy([(t) => OrderingTerm.asc(t.parcelId)]))
          .get();

  Future<ParcelVarietyRow?> findById(String id) =>
      (select(parcelVarieties)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<bool> exists({
    required String parcelId,
    required String grapeVarietyId,
  }) async {
    final countExpression = parcelVarieties.id.count();
    final query = selectOnly(parcelVarieties)
      ..addColumns([countExpression])
      ..where(
        parcelVarieties.parcelId.equals(parcelId) &
            parcelVarieties.grapeVarietyId.equals(grapeVarietyId),
      );
    final row = await query.getSingle();
    return (row.read(countExpression) ?? 0) > 0;
  }

  Future<void> upsert(ParcelVarietiesCompanion companion) async {
    await into(parcelVarieties).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(parcelVarieties)..where((t) => t.id.equals(id))).go();

  Future<int> deleteByParcel(String parcelId) =>
      (delete(parcelVarieties)..where((t) => t.parcelId.equals(parcelId))).go();
}
