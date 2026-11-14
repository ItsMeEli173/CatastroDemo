import 'package:drift/drift.dart';

import '../app_database.dart';
import '../query_utils.dart';
import '../tables.dart';

part 'grape_variety_dao.g.dart';

/// Consultas del catálogo de variedades de uva.
@DriftAccessor(tables: [GrapeVarieties, ParcelVarieties])
class GrapeVarietyDao extends DatabaseAccessor<AppDatabase>
    with _$GrapeVarietyDaoMixin {
  GrapeVarietyDao(super.db);

  Expression<bool>? _search(String query) {
    if (query.trim().isEmpty) return null;
    final pattern = likeContains(query);
    return grapeVarieties.name.lower().like(pattern, escapeChar: '\\') |
        grapeVarieties.category
            .cast<String>()
            .lower()
            .like(pattern, escapeChar: '\\') |
        grapeVarieties.aliases
            .cast<String>()
            .lower()
            .like(pattern, escapeChar: '\\');
  }

  SimpleSelectStatement<$GrapeVarietiesTable, GrapeVarietyRow> _select({
    String query = '',
    bool includeInactive = false,
  }) {
    final statement = select(grapeVarieties);
    final predicate = _search(query);
    if (predicate != null) {
      statement.where((_) => predicate);
    }
    if (!includeInactive) {
      statement.where((t) => t.active.equals(true));
    }
    statement.orderBy([(t) => OrderingTerm.asc(t.name)]);
    return statement;
  }

  Stream<List<GrapeVarietyRow>> watchAll({
    String query = '',
    bool includeInactive = false,
  }) =>
      _select(query: query, includeInactive: includeInactive).watch();

  Future<List<GrapeVarietyRow>> findAll({
    String query = '',
    bool includeInactive = false,
  }) =>
      _select(query: query, includeInactive: includeInactive).get();

  Future<GrapeVarietyRow?> findById(String id) =>
      (select(grapeVarieties)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<GrapeVarietyRow?> findByName(String name) => (select(grapeVarieties)
        ..where((t) => t.name.lower().equals(name.trim().toLowerCase())))
      .getSingleOrNull();

  /// Cantidad de parcelas que usan la variedad.
  Future<int> countParcelUsage(String grapeVarietyId) async {
    final countExpression = parcelVarieties.id.count();
    final query = selectOnly(parcelVarieties)
      ..addColumns([countExpression])
      ..where(parcelVarieties.grapeVarietyId.equals(grapeVarietyId));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> upsert(GrapeVarietiesCompanion companion) async {
    await into(grapeVarieties).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(grapeVarieties)..where((t) => t.id.equals(id))).go();
}
