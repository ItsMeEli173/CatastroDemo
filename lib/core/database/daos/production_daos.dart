import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'production_daos.g.dart';

/// Consultas de temporadas agrícolas.
@DriftAccessor(tables: [HarvestSeasons, ProductionEstimates])
class HarvestSeasonDao extends DatabaseAccessor<AppDatabase>
    with _$HarvestSeasonDaoMixin {
  HarvestSeasonDao(super.db);

  Stream<List<HarvestSeasonRow>> watchAll() => (select(harvestSeasons)
        ..orderBy([(t) => OrderingTerm.desc(t.name)]))
      .watch();

  Future<List<HarvestSeasonRow>> findAll() => (select(harvestSeasons)
        ..orderBy([(t) => OrderingTerm.desc(t.name)]))
      .get();

  Future<HarvestSeasonRow?> findById(String id) =>
      (select(harvestSeasons)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<HarvestSeasonRow?> findByName(String name) =>
      (select(harvestSeasons)
            ..where((t) => t.name.lower().equals(name.trim().toLowerCase())))
          .getSingleOrNull();

  Future<int> countEstimates(String seasonId) async {
    final countExpression = productionEstimates.id.count();
    final query = selectOnly(productionEstimates)
      ..addColumns([countExpression])
      ..where(productionEstimates.seasonId.equals(seasonId));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> upsert(HarvestSeasonsCompanion companion) async {
    await into(harvestSeasons).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(harvestSeasons)..where((t) => t.id.equals(id))).go();
}

/// Consultas de unidades de registro.
@DriftAccessor(tables: [MeasurementUnits, ProductionEstimates])
class MeasurementUnitDao extends DatabaseAccessor<AppDatabase>
    with _$MeasurementUnitDaoMixin {
  MeasurementUnitDao(super.db);

  SimpleSelectStatement<$MeasurementUnitsTable, MeasurementUnitRow> _select(
    bool includeInactive,
  ) {
    final statement = select(measurementUnits);
    if (!includeInactive) {
      statement.where((t) => t.active.equals(true));
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.name)]);
    return statement;
  }

  Stream<List<MeasurementUnitRow>> watchAll({bool includeInactive = true}) =>
      _select(includeInactive).watch();

  Future<List<MeasurementUnitRow>> findAll({bool includeInactive = true}) =>
      _select(includeInactive).get();

  Future<MeasurementUnitRow?> findById(String id) =>
      (select(measurementUnits)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<MeasurementUnitRow?> findByCode(String code) =>
      (select(measurementUnits)
            ..where((t) => t.code.lower().equals(code.trim().toLowerCase())))
          .getSingleOrNull();

  Future<int> countEstimates(String unitId) async {
    final countExpression = productionEstimates.id.count();
    final query = selectOnly(productionEstimates)
      ..addColumns([countExpression])
      ..where(productionEstimates.unitId.equals(unitId));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> upsert(MeasurementUnitsCompanion companion) async {
    await into(measurementUnits).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(measurementUnits)..where((t) => t.id.equals(id))).go();
}

/// Consultas de estimaciones de producción.
@DriftAccessor(tables: [ProductionEstimates])
class ProductionEstimateDao extends DatabaseAccessor<AppDatabase>
    with _$ProductionEstimateDaoMixin {
  ProductionEstimateDao(super.db);

  SimpleSelectStatement<$ProductionEstimatesTable, ProductionEstimateRow>
      _select(String parcelId, String? seasonId) {
    final statement = select(productionEstimates);
    var predicate = productionEstimates.parcelId.equals(parcelId);
    if (seasonId != null) {
      predicate = predicate & productionEstimates.seasonId.equals(seasonId);
    }
    statement.where((_) => predicate);
    statement.orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return statement;
  }

  Stream<List<ProductionEstimateRow>> watchByParcel(
    String parcelId, {
    String? seasonId,
  }) =>
      _select(parcelId, seasonId).watch();

  Future<List<ProductionEstimateRow>> findByParcel(
    String parcelId, {
    String? seasonId,
  }) =>
      _select(parcelId, seasonId).get();

  Future<List<ProductionEstimateRow>> findAll() =>
      (select(productionEstimates)
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get();

  Future<ProductionEstimateRow?> findById(String id) =>
      (select(productionEstimates)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<void> upsert(ProductionEstimatesCompanion companion) async {
    await into(productionEstimates).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(productionEstimates)..where((t) => t.id.equals(id))).go();

  Future<int> deleteByParcel(String parcelId) => (delete(productionEstimates)
        ..where((t) => t.parcelId.equals(parcelId)))
      .go();
}
