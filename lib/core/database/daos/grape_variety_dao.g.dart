// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grape_variety_dao.dart';

// ignore_for_file: type=lint
mixin _$GrapeVarietyDaoMixin on DatabaseAccessor<AppDatabase> {
  $GrapeVarietiesTable get grapeVarieties => attachedDatabase.grapeVarieties;
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $ParcelVarietiesTable get parcelVarieties => attachedDatabase.parcelVarieties;
  GrapeVarietyDaoManager get managers => GrapeVarietyDaoManager(this);
}

class GrapeVarietyDaoManager {
  final _$GrapeVarietyDaoMixin _db;
  GrapeVarietyDaoManager(this._db);
  $$GrapeVarietiesTableTableManager get grapeVarieties =>
      $$GrapeVarietiesTableTableManager(
        _db.attachedDatabase,
        _db.grapeVarieties,
      );
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$ParcelVarietiesTableTableManager get parcelVarieties =>
      $$ParcelVarietiesTableTableManager(
        _db.attachedDatabase,
        _db.parcelVarieties,
      );
}
