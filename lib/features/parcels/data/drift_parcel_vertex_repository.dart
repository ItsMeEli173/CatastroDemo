import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/parcel_dao.dart';
import '../../../../core/database/daos/parcel_vertex_dao.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/storage/photo_storage.dart';
import '../../domain/entities/parcel_vertex.dart';
import '../../domain/repositories/parcel_vertex_repository.dart';
import '../../domain/services/parcel_area_calculator.dart';
import '../../domain/services/polygon_validator.dart';

/// Persistencia de la geometría de parcelas sobre Drift.
class DriftParcelVertexRepository implements ParcelVertexRepository {
  DriftParcelVertexRepository(
    this._vertexDao,
    this._parcelDao,
    this._photoStorage,
  );

  final ParcelVertexDao _vertexDao;
  final ParcelDao _parcelDao;
  final PhotoStorage _photoStorage;

  @override
  Stream<List<ParcelVertex>> watchByParcel(String parcelId) => _vertexDao
      .watchByParcel(parcelId)
      .map((rows) => rows.map((row) => row.toVertexEntity()).toList());

  @override
  Future<List<ParcelVertex>> findByParcel(String parcelId) async =>
      (await _vertexDao.findByParcel(parcelId))
          .map((row) => row.toVertexEntity())
          .toList();

  @override
  Future<int> countByParcel(String parcelId) =>
      _vertexDao.countByParcel(parcelId);

  @override
  Future<void> replaceAll(String parcelId, List<ParcelVertex> vertices) async {
    final now = DateTime.now().toUtc();
    final removedPhotos = <String>[];
    try {
      await _vertexDao.transaction(() async {
        removedPhotos.addAll(
          await _vertexDao.deleteVerticesExcept(
            parcelId,
            vertices.map((vertex) => vertex.id).toList(),
          ),
        );
        for (var index = 0; index < vertices.length; index++) {
          final vertex = vertices[index];
          await _vertexDao.upsert(
            ParcelVerticesCompanion(
              id: Value(vertex.id),
              parcelId: Value(parcelId),
              sequenceNumber: Value(index),
              latitude: Value(vertex.latitude),
              longitude: Value(vertex.longitude),
              accuracyM: Value(vertex.accuracyM),
              captureMethod: Value(vertex.captureMethod),
              capturedAt: Value(vertex.capturedAt?.toUtc()),
              createdAt: Value(vertex.createdAt.toUtc()),
              updatedAt: Value(now),
            ),
          );
        }
        final ring = vertices.map((vertex) => vertex.point).toList();
        final validation = PolygonValidator.validate(ring);
        await _parcelDao.updateCalculatedArea(
          parcelId: parcelId,
          areaM2: validation.isValid ? ParcelAreaCalculator.areaM2(ring) : null,
          updatedAt: now,
        );
      });
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar la geometría.');
    }
    for (final relativePath in removedPhotos) {
      await _photoStorage.deleteRelative(relativePath);
    }
  }
}

extension ParcelVertexRowMapper on ParcelVertexRow {
  ParcelVertex toVertexEntity() => ParcelVertex(
        id: id,
        parcelId: parcelId,
        sequenceNumber: sequenceNumber,
        latitude: latitude,
        longitude: longitude,
        accuracyM: accuracyM,
        captureMethod: captureMethod,
        capturedAt: capturedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
