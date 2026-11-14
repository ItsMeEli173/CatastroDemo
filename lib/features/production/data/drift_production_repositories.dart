import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/production_daos.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/validation/validators.dart';
import '../domain/entities/harvest_season.dart';
import '../domain/entities/measurement_unit.dart';
import '../domain/entities/production_estimate.dart';
import '../domain/repositories/production_repositories.dart';
import '../domain/services/production_math.dart';

/// Temporadas agrícolas sobre Drift.
class DriftHarvestSeasonRepository implements HarvestSeasonRepository {
  DriftHarvestSeasonRepository(this._dao);

  final HarvestSeasonDao _dao;

  @override
  Stream<List<HarvestSeason>> watchAll() =>
      _dao.watchAll().map((rows) => rows.map((row) => row.toSeasonEntity()).toList());

  @override
  Future<List<HarvestSeason>> findAll() async =>
      (await _dao.findAll()).map((row) => row.toSeasonEntity()).toList();

  @override
  Future<HarvestSeason?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toSeasonEntity();
  }

  @override
  Future<HarvestSeason?> findByName(String name) async {
    final row = await _dao.findByName(name);
    return row?.toSeasonEntity();
  }

  @override
  Future<void> save(HarvestSeason season) async {
    final nameError = Validators.requiredText(
      season.name,
      message: 'Ingresa el nombre de la temporada.',
      maxLength: 60,
    );
    if (nameError != null) throw ValidationFailure(nameError);
    if (season.startDate != null &&
        season.endDate != null &&
        season.startDate!.isAfter(season.endDate!)) {
      throw const ValidationFailure(
        'La fecha de inicio no puede ser posterior a la de fin.',
      );
    }
    final duplicate = await _dao.findByName(season.name);
    if (duplicate != null && duplicate.id != season.id) {
      throw const ValidationFailure('Ya existe una temporada con ese nombre.');
    }
    try {
      await _dao.upsert(
        HarvestSeasonsCompanion(
          id: Value(season.id),
          name: Value(season.name.trim()),
          startDate: Value(season.startDate?.toUtc()),
          endDate: Value(season.endDate?.toUtc()),
          notes: Value(_clean(season.notes)),
          createdAt: Value(season.createdAt.toUtc()),
          updatedAt: Value(season.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar la temporada.');
    }
  }

  @override
  Future<void> delete(String id) async {
    final usage = await _dao.countEstimates(id);
    if (usage > 0) {
      throw const InUseFailure(
        'La temporada tiene estimaciones registradas y no puede eliminarse.',
      );
    }
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure('No se pudo eliminar la temporada.');
    }
  }
}

/// Unidades de registro sobre Drift.
class DriftMeasurementUnitRepository implements MeasurementUnitRepository {
  DriftMeasurementUnitRepository(this._dao);

  final MeasurementUnitDao _dao;

  @override
  Stream<List<MeasurementUnit>> watchAll({bool includeInactive = true}) => _dao
      .watchAll(includeInactive: includeInactive)
      .map((rows) => rows.map((row) => row.toUnitEntity()).toList());

  @override
  Future<List<MeasurementUnit>> findAll({bool includeInactive = true}) async =>
      (await _dao.findAll(includeInactive: includeInactive))
          .map((row) => row.toUnitEntity())
          .toList();

  @override
  Future<MeasurementUnit?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toUnitEntity();
  }

  @override
  Future<MeasurementUnit?> findByCode(String code) async {
    final row = await _dao.findByCode(code);
    return row?.toUnitEntity();
  }

  @override
  Future<void> save(MeasurementUnit unit) async {
    final codeError = Validators.requiredCode(
      unit.code,
      message: 'Ingresa el código de la unidad.',
      maxLength: 16,
    );
    if (codeError != null) throw ValidationFailure(codeError);
    final nameError = Validators.requiredText(
      unit.name,
      message: 'Ingresa el nombre de la unidad.',
      maxLength: 60,
    );
    if (nameError != null) throw ValidationFailure(nameError);
    final factor = unit.kilogramsEquivalent;
    if (factor != null && (!factor.isFinite || factor <= 0)) {
      throw const ValidationFailure(
        'La equivalencia en kilogramos debe ser mayor a cero.',
      );
    }
    final duplicate = await _dao.findByCode(unit.code);
    if (duplicate != null && duplicate.id != unit.id) {
      throw const ValidationFailure('Ya existe una unidad con ese código.');
    }
    try {
      await _dao.upsert(
        MeasurementUnitsCompanion(
          id: Value(unit.id),
          code: Value(unit.code.trim()),
          name: Value(unit.name.trim()),
          kilogramsEquivalent: Value(unit.kilogramsEquivalent),
          active: Value(unit.active),
          createdAt: Value(unit.createdAt.toUtc()),
          updatedAt: Value(unit.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar la unidad.');
    }
  }

  @override
  Future<void> delete(String id) async {
    final usage = await _dao.countEstimates(id);
    if (usage > 0) {
      throw const InUseFailure(
        'La unidad tiene estimaciones registradas y no puede eliminarse. '
        'Desactívala para conservar el historial.',
      );
    }
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure('No se pudo eliminar la unidad.');
    }
  }
}

/// Estimaciones de producción sobre Drift.
class DriftProductionEstimateRepository implements ProductionEstimateRepository {
  DriftProductionEstimateRepository(this._dao);

  final ProductionEstimateDao _dao;

  @override
  Stream<List<ProductionEstimate>> watchByParcel(
    String parcelId, {
    String? seasonId,
  }) =>
      _dao
          .watchByParcel(parcelId, seasonId: seasonId)
          .map((rows) => rows.map((row) => row.toEstimateEntity()).toList());

  @override
  Future<List<ProductionEstimate>> findByParcel(
    String parcelId, {
    String? seasonId,
  }) async =>
      (await _dao.findByParcel(parcelId, seasonId: seasonId))
          .map((row) => row.toEstimateEntity())
          .toList();

  @override
  Future<List<ProductionEstimate>> findAll() async =>
      (await _dao.findAll()).map((row) => row.toEstimateEntity()).toList();

  @override
  Future<ProductionEstimate?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toEstimateEntity();
  }

  @override
  Future<void> save(ProductionEstimate estimate) async {
    final double estimatedKg;
    try {
      estimatedKg = ProductionMath.estimatedKg(
        quantity: estimate.quantity,
        conversionFactorKg: estimate.conversionFactorKg,
      );
    } on ValidationFailure {
      rethrow;
    }
    try {
      await _dao.upsert(
        ProductionEstimatesCompanion(
          id: Value(estimate.id),
          parcelId: Value(estimate.parcelId),
          seasonId: Value(estimate.seasonId),
          grapeVarietyId: Value(estimate.grapeVarietyId),
          quantity: Value(estimate.quantity),
          unitId: Value(estimate.unitId),
          conversionFactorKg: Value(estimate.conversionFactorKg),
          estimatedKg: Value(estimatedKg),
          notes: Value(_clean(estimate.notes)),
          createdAt: Value(estimate.createdAt.toUtc()),
          updatedAt: Value(estimate.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar la estimación.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure('No se pudo eliminar la estimación.');
    }
  }
}

String? _clean(String? value) {
  final text = value?.trim();
  return (text == null || text.isEmpty) ? null : text;
}

extension HarvestSeasonRowMapper on HarvestSeasonRow {
  HarvestSeason toSeasonEntity() => HarvestSeason(
        id: id,
        name: name,
        startDate: startDate,
        endDate: endDate,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension MeasurementUnitRowMapper on MeasurementUnitRow {
  MeasurementUnit toUnitEntity() => MeasurementUnit(
        id: id,
        code: code,
        name: name,
        kilogramsEquivalent: kilogramsEquivalent,
        active: active,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension ProductionEstimateRowMapper on ProductionEstimateRow {
  ProductionEstimate toEstimateEntity() => ProductionEstimate(
        id: id,
        parcelId: parcelId,
        seasonId: seasonId,
        grapeVarietyId: grapeVarietyId,
        quantity: quantity,
        unitId: unitId,
        conversionFactorKg: conversionFactorKg,
        estimatedKg: estimatedKg,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
