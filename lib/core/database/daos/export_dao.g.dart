// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_dao.dart';

// ignore_for_file: type=lint
mixin _$ExportDaoMixin on DatabaseAccessor<AppDatabase> {
  $FarmersTable get farmers => attachedDatabase.farmers;
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $ParcelOwnersTable get parcelOwners => attachedDatabase.parcelOwners;
  $ParcelVerticesTable get parcelVertices => attachedDatabase.parcelVertices;
  $VertexPhotosTable get vertexPhotos => attachedDatabase.vertexPhotos;
  $GrapeVarietiesTable get grapeVarieties => attachedDatabase.grapeVarieties;
  $ParcelVarietiesTable get parcelVarieties => attachedDatabase.parcelVarieties;
  $HarvestSeasonsTable get harvestSeasons => attachedDatabase.harvestSeasons;
  $MeasurementUnitsTable get measurementUnits =>
      attachedDatabase.measurementUnits;
  $ProductionEstimatesTable get productionEstimates =>
      attachedDatabase.productionEstimates;
  ExportDaoManager get managers => ExportDaoManager(this);
}

class ExportDaoManager {
  final _$ExportDaoMixin _db;
  ExportDaoManager(this._db);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db.attachedDatabase, _db.farmers);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$ParcelOwnersTableTableManager get parcelOwners =>
      $$ParcelOwnersTableTableManager(_db.attachedDatabase, _db.parcelOwners);
  $$ParcelVerticesTableTableManager get parcelVertices =>
      $$ParcelVerticesTableTableManager(
        _db.attachedDatabase,
        _db.parcelVertices,
      );
  $$VertexPhotosTableTableManager get vertexPhotos =>
      $$VertexPhotosTableTableManager(_db.attachedDatabase, _db.vertexPhotos);
  $$GrapeVarietiesTableTableManager get grapeVarieties =>
      $$GrapeVarietiesTableTableManager(
        _db.attachedDatabase,
        _db.grapeVarieties,
      );
  $$ParcelVarietiesTableTableManager get parcelVarieties =>
      $$ParcelVarietiesTableTableManager(
        _db.attachedDatabase,
        _db.parcelVarieties,
      );
  $$HarvestSeasonsTableTableManager get harvestSeasons =>
      $$HarvestSeasonsTableTableManager(
        _db.attachedDatabase,
        _db.harvestSeasons,
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
