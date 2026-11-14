// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_vertex_dao.dart';

// ignore_for_file: type=lint
mixin _$ParcelVertexDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $ParcelVerticesTable get parcelVertices => attachedDatabase.parcelVertices;
  $VertexPhotosTable get vertexPhotos => attachedDatabase.vertexPhotos;
  ParcelVertexDaoManager get managers => ParcelVertexDaoManager(this);
}

class ParcelVertexDaoManager {
  final _$ParcelVertexDaoMixin _db;
  ParcelVertexDaoManager(this._db);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db.attachedDatabase, _db.parcels);
  $$ParcelVerticesTableTableManager get parcelVertices =>
      $$ParcelVerticesTableTableManager(
        _db.attachedDatabase,
        _db.parcelVertices,
      );
  $$VertexPhotosTableTableManager get vertexPhotos =>
      $$VertexPhotosTableTableManager(_db.attachedDatabase, _db.vertexPhotos);
}
