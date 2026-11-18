import '../entities/farmer.dart';

/// Contrato de persistencia de agricultores.
abstract interface class FarmerRepository {
  Stream<List<Farmer>> watchFarmers({String query = ''});

  Future<List<Farmer>> findFarmers({String query = ''});

  Future<Farmer?> findById(String id);

  Future<int> count();

  Stream<int> watchCount();

  /// Genera el siguiente código correlativo de agricultor (ej. AGR-001).
  Future<String> nextCode();

  Future<void> save(Farmer farmer);

  /// Falla con [InUseFailure] si el agricultor tiene parcelas asociadas.
  Future<void> delete(String id);
}
