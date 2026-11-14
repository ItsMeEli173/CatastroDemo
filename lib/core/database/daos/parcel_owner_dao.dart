import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'parcel_owner_dao.g.dart';

/// Consultas de la relación agricultor–parcela.
@DriftAccessor(tables: [ParcelOwners, Farmers])
class ParcelOwnerDao extends DatabaseAccessor<AppDatabase>
    with _$ParcelOwnerDaoMixin {
  ParcelOwnerDao(super.db);

  Stream<List<ParcelOwnerRow>> watchByParcel(String parcelId) => (select(parcelOwners)
        ..where((t) => t.parcelId.equals(parcelId))
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
      .watch();

  Future<List<ParcelOwnerRow>> findByParcel(String parcelId) => (select(parcelOwners)
        ..where((t) => t.parcelId.equals(parcelId))
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
      .get();

  Stream<List<ParcelOwnerRow>> watchByFarmer(String farmerId) => (select(parcelOwners)
        ..where((t) => t.farmerId.equals(farmerId))
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
      .watch();

  Future<List<ParcelOwnerRow>> findByFarmer(String farmerId) => (select(parcelOwners)
        ..where((t) => t.farmerId.equals(farmerId))
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
      .get();

  Future<ParcelOwnerRow?> findById(String id) =>
      (select(parcelOwners)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<bool> exists({
    required String parcelId,
    required String farmerId,
  }) async {
    final countExpression = parcelOwners.id.count();
    final query = selectOnly(parcelOwners)
      ..addColumns([countExpression])
      ..where(
        parcelOwners.parcelId.equals(parcelId) &
            parcelOwners.farmerId.equals(farmerId),
      );
    final row = await query.getSingle();
    return (row.read(countExpression) ?? 0) > 0;
  }

  Future<void> upsert(ParcelOwnersCompanion companion) async {
    await into(parcelOwners).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(parcelOwners)..where((t) => t.id.equals(id))).go();
}
