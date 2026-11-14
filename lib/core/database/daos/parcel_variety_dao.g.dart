// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_variety_dao.dart';

// ignore_for_file: type=lint
mixin _$ParcelVarietyDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $GrapeVarietiesTable get grapeVarieties => attachedDatabase.grapeVarieties;
  $ParcelVarietiesTable get parcelVarieties => attachedDatabase.parcelVarieties;
  ParcelVarietyDaoManager get managers => ParcelVarietyDaoManager(this);
}

class ParcelVarietyDaoManager {
  final _$ParcelVarietyDaoMixin _db;
  ParcelVarietyDaoManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
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
}
