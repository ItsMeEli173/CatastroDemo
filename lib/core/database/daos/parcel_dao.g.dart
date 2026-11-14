// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_dao.dart';

// ignore_for_file: type=lint
mixin _$ParcelDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $FarmersTable get farmers => attachedDatabase.farmers;
  $ParcelOwnersTable get parcelOwners => attachedDatabase.parcelOwners;
  $ParcelVerticesTable get parcelVertices => attachedDatabase.parcelVertices;
  $VertexPhotosTable get vertexPhotos => attachedDatabase.vertexPhotos;
  ParcelDaoManager get managers => ParcelDaoManager(this);
}

class ParcelDaoManager {
  final _$ParcelDaoMixin _db;
  ParcelDaoManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db.attachedDatabase, _db.farmers);
  $$ParcelOwnersTableTableManager get parcelOwners =>
      $$ParcelOwnersTableTableManager(_db.attachedDatabase, _db.parcelOwners);
  $$ParcelVerticesTableTableManager get parcelVertices =>
      $$ParcelVerticesTableTableManager(
        _db.attachedDatabase,
        _db.parcelVertices,
      );
  $$VertexPhotosTableTableManager get vertexPhotos =>
      $$VertexPhotosTableTableManager(_db.attachedDatabase, _db.vertexPhotos);
}
