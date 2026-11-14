// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_owner_dao.dart';

// ignore_for_file: type=lint
mixin _$ParcelOwnerDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $FarmersTable get farmers => attachedDatabase.farmers;
  $ParcelOwnersTable get parcelOwners => attachedDatabase.parcelOwners;
  ParcelOwnerDaoManager get managers => ParcelOwnerDaoManager(this);
}

class ParcelOwnerDaoManager {
  final _$ParcelOwnerDaoMixin _db;
  ParcelOwnerDaoManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db.attachedDatabase, _db.farmers);
  $$ParcelOwnersTableTableManager get parcelOwners =>
      $$ParcelOwnersTableTableManager(_db.attachedDatabase, _db.parcelOwners);
}
