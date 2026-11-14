// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vertex_photo_dao.dart';

// ignore_for_file: type=lint
mixin _$VertexPhotoDaoMixin on DatabaseAccessor<AppDatabase> {
  $ParcelsTable get parcels => attachedDatabase.parcels;
  $ParcelVerticesTable get parcelVertices => attachedDatabase.parcelVertices;
  $VertexPhotosTable get vertexPhotos => attachedDatabase.vertexPhotos;
  VertexPhotoDaoManager get managers => VertexPhotoDaoManager(this);
}

class VertexPhotoDaoManager {
  final _$VertexPhotoDaoMixin _db;
  VertexPhotoDaoManager(this._db);
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
