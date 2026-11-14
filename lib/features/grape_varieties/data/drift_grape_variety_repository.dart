import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/grape_variety_dao.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/validation/validators.dart';
import '../domain/entities/grape_variety.dart';
import '../domain/repositories/grape_variety_repository.dart';

/// Catálogo de variedades sobre Drift.
class DriftGrapeVarietyRepository implements GrapeVarietyRepository {
  DriftGrapeVarietyRepository(this._dao);

  final GrapeVarietyDao _dao;

  @override
  Stream<List<GrapeVariety>> watchAll({
    String query = '',
    bool includeInactive = false,
  }) =>
      _dao
          .watchAll(query: query, includeInactive: includeInactive)
          .map(_mapRows);

  @override
  Future<List<GrapeVariety>> findAll({
    String query = '',
    bool includeInactive = false,
  }) async =>
      _mapRows(
        await _dao.findAll(query: query, includeInactive: includeInactive),
      );

  @override
  Future<GrapeVariety?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toVarietyEntity();
  }

  @override
  Future<void> save(GrapeVariety variety) async {
    final nameError = Validators.requiredText(
      variety.name,
      message: 'Ingresa el nombre de la variedad.',
      maxLength: 80,
    );
    if (nameError != null) throw ValidationFailure(nameError);
    final duplicate = await _dao.findByName(variety.name);
    if (duplicate != null && duplicate.id != variety.id) {
      throw const ValidationFailure('Ya existe una variedad con ese nombre.');
    }
    try {
      await _dao.upsert(
        GrapeVarietiesCompanion(
          id: Value(variety.id),
          name: Value(variety.name.trim()),
          category: Value(_clean(variety.category)),
          description: Value(_clean(variety.description)),
          aliases: Value(_clean(variety.aliases)),
          active: Value(variety.active),
          createdAt: Value(variety.createdAt.toUtc()),
          updatedAt: Value(variety.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar la variedad.');
    }
  }

  @override
  Future<void> delete(String id) async {
    final usage = await _dao.countParcelUsage(id);
    if (usage > 0) {
      throw const InUseFailure(
        'La variedad está asociada a parcelas. Desactívala para conservar el '
        'historial.',
      );
    }
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure('No se pudo eliminar la variedad.');
    }
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return (text == null || text.isEmpty) ? null : text;
  }

  static List<GrapeVariety> _mapRows(List<GrapeVarietyRow> rows) =>
      rows.map((row) => row.toVarietyEntity()).toList();
}

extension GrapeVarietyRowMapper on GrapeVarietyRow {
  GrapeVariety toVarietyEntity() => GrapeVariety(
        id: id,
        name: name,
        category: category,
        description: description,
        aliases: aliases,
        active: active,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
