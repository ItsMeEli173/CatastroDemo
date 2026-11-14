import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/parcel_dao.dart';
import '../../../../core/database/daos/parcel_vertex_dao.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/geo/geo_point.dart';
import '../../../../core/storage/photo_storage.dart';
import '../../../../core/validation/validators.dart';
import '../../domain/entities/parcel.dart';
import '../../domain/repositories/parcel_repository.dart';
import '../../domain/services/polygon_validator.dart';

/// Persistencia de parcelas sobre Drift.
class DriftParcelRepository implements ParcelRepository {
  DriftParcelRepository(this._parcelDao, this._vertexDao, this._photoStorage);

  final ParcelDao _parcelDao;
  final ParcelVertexDao _vertexDao;
  final PhotoStorage _photoStorage;

  @override
  Stream<List<Parcel>> watchParcels({String query = '', ParcelStatus? status}) =>
      _parcelDao
          .watchAll(query: query, status: status)
          .map((rows) => rows.map((row) => row.toParcelEntity()).toList());

  @override
  Future<List<Parcel>> findParcels({
    String query = '',
    ParcelStatus? status,
  }) async =>
      (await _parcelDao.findAll(query: query, status: status))
          .map((row) => row.toParcelEntity())
          .toList();

  @override
  Future<Parcel?> findById(String id) async {
    final row = await _parcelDao.findById(id);
    return row?.toParcelEntity();
  }

  @override
  Future<Parcel?> findByCode(String code) async {
    final row = await _parcelDao.findByCode(code);
    return row?.toParcelEntity();
  }

  @override
  Stream<List<Parcel>> watchByFarmer(String farmerId) => _parcelDao
      .watchByFarmer(farmerId)
      .map((rows) => rows.map((row) => row.toParcelEntity()).toList());

  @override
  Future<List<Parcel>> findByFarmer(String farmerId) async =>
      (await _parcelDao.findByFarmer(farmerId))
          .map((row) => row.toParcelEntity())
          .toList();

  @override
  Future<int> count() => _parcelDao.count();

  @override
  Future<void> save(Parcel parcel) async {
    final codeError = Validators.requiredCode(
      parcel.code,
      message: 'Ingresa el código de la parcela.',
      maxLength: 40,
    );
    if (codeError != null) throw ValidationFailure(codeError);
    final declaredArea = parcel.declaredAreaM2;
    if (declaredArea != null && (!declaredArea.isFinite || declaredArea < 0)) {
      throw const ValidationFailure(
        'La superficie declarada debe ser un número mayor o igual a cero.',
      );
    }
    final duplicate = await _parcelDao.findByCode(parcel.code);
    if (duplicate != null && duplicate.id != parcel.id) {
      throw const ValidationFailure('Ya existe una parcela con ese código.');
    }
    try {
      await _parcelDao.upsert(
        ParcelsCompanion(
          id: Value(parcel.id),
          code: Value(parcel.code.trim()),
          name: Value(_clean(parcel.name)),
          declaredAreaM2: Value(parcel.declaredAreaM2),
          calculatedAreaM2: Value(parcel.calculatedAreaM2),
          status: Value(parcel.status),
          notes: Value(_clean(parcel.notes)),
          createdAt: Value(parcel.createdAt.toUtc()),
          updatedAt: Value(parcel.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar la parcela.');
    }
  }

  @override
  Future<void> updateStatus(String id, ParcelStatus status) async {
    if (status == ParcelStatus.active) {
      final rows = await _vertexDao.findByParcel(id);
      final ring = rows
          .map((row) => GeoPoint(row.latitude, row.longitude))
          .toList(growable: false);
      final validation = PolygonValidator.validate(ring);
      if (!validation.isValid) {
        throw ValidationFailure(validation.firstError!);
      }
    }
    try {
      await _parcelDao.updateStatus(
        parcelId: id,
        status: status,
        updatedAt: DateTime.now().toUtc(),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo actualizar el estado.');
    }
  }

  @override
  Future<void> delete(String id) async {
    final photoPaths = await _parcelDao.photoRelativePathsByParcel(id);
    try {
      await _parcelDao.deleteById(id);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo eliminar la parcela.');
    }
    for (final relativePath in photoPaths) {
      await _photoStorage.deleteRelative(relativePath);
    }
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return (text == null || text.isEmpty) ? null : text;
  }
}

extension ParcelRowMapper on ParcelRow {
  Parcel toParcelEntity() => Parcel(
        id: id,
        code: code,
        name: name,
        declaredAreaM2: declaredAreaM2,
        calculatedAreaM2: calculatedAreaM2,
        status: status,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
