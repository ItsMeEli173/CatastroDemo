import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/parcel_variety_dao.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/validation/validators.dart';
import '../../domain/entities/parcel_variety.dart';
import '../../domain/repositories/grape_variety_repository.dart';

/// Distribución de variedades por parcela sobre Drift.
class DriftParcelVarietyRepository implements ParcelVarietyRepository {
  DriftParcelVarietyRepository(this._dao);

  final ParcelVarietyDao _dao;

  @override
  Stream<List<ParcelVariety>> watchByParcel(String parcelId) =>
      _dao.watchByParcel(parcelId).map(_mapRows);

  @override
  Future<List<ParcelVariety>> findByParcel(String parcelId) async =>
      _mapRows(await _dao.findByParcel(parcelId));

  @override
  Future<List<ParcelVariety>> findAll() async =>
      _mapRows(await _dao.findAll());

  @override
  Future<bool> exists({
    required String parcelId,
    required String grapeVarietyId,
  }) =>
      _dao.exists(parcelId: parcelId, grapeVarietyId: grapeVarietyId);

  @override
  Future<void> save(ParcelVariety parcelVariety) async {
    if (!Validators.isValidPercentage(parcelVariety.plantedAreaPercentage)) {
      throw const ValidationFailure(
        'El porcentaje de superficie debe estar entre 0 y 100.',
      );
    }
    if (await exists(
      parcelId: parcelVariety.parcelId,
      grapeVarietyId: parcelVariety.grapeVarietyId,
    )) {
      final rows = await _dao.findByParcel(parcelVariety.parcelId);
      final conflicting = rows.where(
        (row) =>
            row.grapeVarietyId == parcelVariety.grapeVarietyId &&
            row.id != parcelVariety.id,
      );
      if (conflicting.isNotEmpty) {
        throw const ValidationFailure(
          'La variedad ya está asociada a esta parcela.',
        );
      }
    }
    try {
      await _dao.upsert(
        ParcelVarietiesCompanion(
          id: Value(parcelVariety.id),
          parcelId: Value(parcelVariety.parcelId),
          grapeVarietyId: Value(parcelVariety.grapeVarietyId),
          plantedAreaPercentage: Value(parcelVariety.plantedAreaPercentage),
          notes: Value(_clean(parcelVariety.notes)),
          createdAt: Value(parcelVariety.createdAt.toUtc()),
          updatedAt: Value(parcelVariety.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure(
        'No se pudo guardar la variedad de la parcela.',
      );
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure(
        'No se pudo quitar la variedad de la parcela.',
      );
    }
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return (text == null || text.isEmpty) ? null : text;
  }

  static List<ParcelVariety> _mapRows(List<ParcelVarietyRow> rows) =>
      rows.map((row) => row.toParcelVarietyEntity()).toList();
}

extension ParcelVarietyRowMapper on ParcelVarietyRow {
  ParcelVariety toParcelVarietyEntity() => ParcelVariety(
        id: id,
        parcelId: parcelId,
        grapeVarietyId: grapeVarietyId,
        plantedAreaPercentage: plantedAreaPercentage,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
