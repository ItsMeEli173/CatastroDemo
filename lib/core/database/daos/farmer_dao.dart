import 'package:drift/drift.dart';

import '../app_database.dart';
import '../query_utils.dart';
import '../tables.dart';

part 'farmer_dao.g.dart';

/// Consultas de agricultores.
@DriftAccessor(tables: [Farmers, ParcelOwners])
class FarmerDao extends DatabaseAccessor<AppDatabase> with _$FarmerDaoMixin {
  FarmerDao(super.db);

  Expression<bool>? _search(String query) {
    if (query.trim().isEmpty) return null;
    final pattern = likeContains(query);
    return farmers.firstName.lower().like(pattern, escapeChar: '\\') |
        farmers.lastName.lower().like(pattern, escapeChar: '\\') |
        farmers.documentNumber
            .cast<String>()
            .lower()
            .like(pattern, escapeChar: '\\') |
        farmers.locality
            .cast<String>()
            .lower()
            .like(pattern, escapeChar: '\\');
  }

  SimpleSelectStatement<$FarmersTable, FarmerRow> _select(String query) {
    final statement = select(farmers);
    final predicate = _search(query);
    if (predicate != null) {
      statement.where((_) => predicate);
    }
    statement.orderBy([
      (t) => OrderingTerm.asc(t.lastName),
      (t) => OrderingTerm.asc(t.firstName),
    ]);
    return statement;
  }

  Stream<List<FarmerRow>> watchAll({String query = ''}) =>
      _select(query).watch();

  Future<List<FarmerRow>> findAll({String query = ''}) => _select(query).get();

  Future<FarmerRow?> findById(String id) =>
      (select(farmers)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<int> watchCount() {
    final countExpression = farmers.id.count();
    final query = selectOnly(farmers)..addColumns([countExpression]);
    return query.map((row) => row.read(countExpression) ?? 0).watchSingle();
  }

  Future<int> count() async {
    final countExpression = farmers.id.count();
    final query = selectOnly(farmers)..addColumns([countExpression]);
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<int> countParcelLinks(String farmerId) async {
    final countExpression = parcelOwners.id.count();
    final query = selectOnly(parcelOwners)
      ..addColumns([countExpression])
      ..where(parcelOwners.farmerId.equals(farmerId));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> upsert(FarmersCompanion companion) async {
    await into(farmers).insertOnConflictUpdate(companion);
  }

  Future<int> deleteById(String id) =>
      (delete(farmers)..where((t) => t.id.equals(id))).go();
}
