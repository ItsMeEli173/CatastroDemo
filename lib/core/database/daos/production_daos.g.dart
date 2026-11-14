// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_daos.dart';

// ignore_for_file: type=lint
mixin _$HarvestSeasonDaoMixin on DatabaseAccessor<AppDatabase> {
  $HarvestSeasonsTable get harvestSeasons => attachedDatabase.harvestSeasons;
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $GrapeVarietiesTable get grapeVarieties => attachedDatabase.grapeVarieties;
  $MeasurementUnitsTable get measurementUnits =>
      attachedDatabase.measurementUnits;
  $ProductionEstimatesTable get productionEstimates =>
      attachedDatabase.productionEstimates;
  HarvestSeasonDaoManager get managers => HarvestSeasonDaoManager(this);
}

class HarvestSeasonDaoManager {
  final _$HarvestSeasonDaoMixin _db;
  HarvestSeasonDaoManager(this._db);
  $$HarvestSeasonsTableTableManager get harvestSeasons =>
      $$HarvestSeasonsTableTableManager(
        _db.attachedDatabase,
        _db.harvestSeasons,
      );
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$GrapeVarietiesTableTableManager get grapeVarieties =>
      $$GrapeVarietiesTableTableManager(
        _db.attachedDatabase,
        _db.grapeVarieties,
      );
  $$MeasurementUnitsTableTableManager get measurementUnits =>
      $$MeasurementUnitsTableTableManager(
        _db.attachedDatabase,
        _db.measurementUnits,
      );
  $$ProductionEstimatesTableTableManager get productionEstimates =>
      $$ProductionEstimatesTableTableManager(
        _db.attachedDatabase,
        _db.productionEstimates,
      );
}

mixin _$MeasurementUnitDaoMixin on DatabaseAccessor<AppDatabase> {
  $MeasurementUnitsTable get measurementUnits =>
      attachedDatabase.measurementUnits;
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $HarvestSeasonsTable get harvestSeasons => attachedDatabase.harvestSeasons;
  $GrapeVarietiesTable get grapeVarieties => attachedDatabase.grapeVarieties;
  $ProductionEstimatesTable get productionEstimates =>
      attachedDatabase.productionEstimates;
  MeasurementUnitDaoManager get managers => MeasurementUnitDaoManager(this);
}

class MeasurementUnitDaoManager {
  final _$MeasurementUnitDaoMixin _db;
  MeasurementUnitDaoManager(this._db);
  $$MeasurementUnitsTableTableManager get measurementUnits =>
      $$MeasurementUnitsTableTableManager(
        _db.attachedDatabase,
        _db.measurementUnits,
      );
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$HarvestSeasonsTableTableManager get harvestSeasons =>
      $$HarvestSeasonsTableTableManager(
        _db.attachedDatabase,
        _db.harvestSeasons,
      );
  $$GrapeVarietiesTableTableManager get grapeVarieties =>
      $$GrapeVarietiesTableTableManager(
        _db.attachedDatabase,
        _db.grapeVarieties,
      );
  $$ProductionEstimatesTableTableManager get productionEstimates =>
      $$ProductionEstimatesTableTableManager(
        _db.attachedDatabase,
        _db.productionEstimates,
      );
}

mixin _$ProductionEstimateDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $HarvestSeasonsTable get harvestSeasons => attachedDatabase.harvestSeasons;
  $GrapeVarietiesTable get grapeVarieties => attachedDatabase.grapeVarieties;
  $MeasurementUnitsTable get measurementUnits =>
      attachedDatabase.measurementUnits;
  $ProductionEstimatesTable get productionEstimates =>
      attachedDatabase.productionEstimates;
  ProductionEstimateDaoManager get managers =>
      ProductionEstimateDaoManager(this);
}

class ProductionEstimateDaoManager {
  final _$ProductionEstimateDaoMixin _db;
  ProductionEstimateDaoManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$HarvestSeasonsTableTableManager get harvestSeasons =>
      $$HarvestSeasonsTableTableManager(
        _db.attachedDatabase,
        _db.harvestSeasons,
      );
  $$GrapeVarietiesTableTableManager get grapeVarieties =>
      $$GrapeVarietiesTableTableManager(
        _db.attachedDatabase,
        _db.grapeVarieties,
      );
  $$MeasurementUnitsTableTableManager get measurementUnits =>
      $$MeasurementUnitsTableTableManager(
        _db.attachedDatabase,
        _db.measurementUnits,
      );
  $$ProductionEstimatesTableTableManager get productionEstimates =>
      $$ProductionEstimatesTableTableManager(
        _db.attachedDatabase,
        _db.productionEstimates,
      );
}
