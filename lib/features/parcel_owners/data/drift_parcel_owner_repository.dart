import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/parcel_owner_dao.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/validation/validators.dart';
import '../domain/entities/parcel_owner.dart';
import '../domain/repositories/parcel_owner_repository.dart';

/// Persistencia de la relación agricultor–parcela sobre Drift.
class DriftParcelOwnerRepository implements ParcelOwnerRepository {
  DriftParcelOwnerRepository(this._dao);

  final ParcelOwnerDao _dao;

  @override
  Stream<List<ParcelOwner>> watchByParcel(String parcelId) =>
      _dao.watchByParcel(parcelId).map(_mapRows);

  @override
  Stream<List<ParcelOwner>> watchByFarmer(String farmerId) =>
      _dao.watchByFarmer(farmerId).map(_mapRows);

  @override
  Future<List<ParcelOwner>> findByParcel(String parcelId) async =>
      _mapRows(await _dao.findByParcel(parcelId));

  @override
  Future<List<ParcelOwner>> findByFarmer(String farmerId) async =>
      _mapRows(await _dao.findByFarmer(farmerId));

  @override
  Future<ParcelOwner?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toOwnerEntity();
  }

  @override
  Future<bool> exists({
    required String parcelId,
    required String farmerId,
  }) =>
      _dao.exists(parcelId: parcelId, farmerId: farmerId);

  @override
  Future<void> save(ParcelOwner owner) async {
    if (!Validators.isValidPercentage(owner.ownershipPercentage)) {
      throw const ValidationFailure(
        'La participación debe estar entre 0 y 100.',
      );
    }
    try {
      await _dao.upsert(
        ParcelOwnersCompanion(
          id: Value(owner.id),
          parcelId: Value(owner.parcelId),
          farmerId: Value(owner.farmerId),
          ownershipPercentage: Value(owner.ownershipPercentage),
          notes: Value(_clean(owner.notes)),
          createdAt: Value(owner.createdAt.toUtc()),
          updatedAt: Value(owner.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure(
        'No se pudo guardar la relación con el agricultor.',
      );
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure(
        'No se pudo quitar la relación con el agricultor.',
      );
    }
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return (text == null || text.isEmpty) ? null : text;
  }

  static List<ParcelOwner> _mapRows(List<ParcelOwnerRow> rows) =>
      rows.map((row) => row.toOwnerEntity()).toList();
}

extension ParcelOwnerRowMapper on ParcelOwnerRow {
  ParcelOwner toOwnerEntity() => ParcelOwner(
        id: id,
        parcelId: parcelId,
        farmerId: farmerId,
        ownershipPercentage: ownershipPercentage,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
