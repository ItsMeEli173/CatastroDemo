// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_dao.dart';

// ignore_for_file: type=lint
mixin _$FarmerDaoMixin on DatabaseAccessor<AppDatabase> {
  $FarmersTable get farmers => attachedDatabase.farmers;
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $ParcelOwnersTable get parcelOwners => attachedDatabase.parcelOwners;
  FarmerDaoManager get managers => FarmerDaoManager(this);
}

class FarmerDaoManager {
  final _$FarmerDaoMixin _db;
  FarmerDaoManager(this._db);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db.attachedDatabase, _db.farmers);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$ParcelOwnersTableTableManager get parcelOwners =>
      $$ParcelOwnersTableTableManager(_db.attachedDatabase, _db.parcelOwners);
}
