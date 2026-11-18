import '../entities/grape_variety.dart';
import '../entities/parcel_variety.dart';

/// Catálogo editable de variedades de uva.
abstract interface class GrapeVarietyRepository {
  Stream<List<GrapeVariety>> watchAll({
    String query = '',
    bool includeInactive = false,
  });

  Future<List<GrapeVariety>> findAll({
    String query = '',
    bool includeInactive = false,
  });

  Future<GrapeVariety?> findById(String id);

  /// Genera el siguiente código correlativo de variedad (ej. UVA-001).
  Future<String> nextCode();

  Future<void> save(GrapeVariety variety);

  /// Falla con [InUseFailure] si la variedad está asociada a una parcela.
  Future<void> delete(String id);
}

/// Distribución de variedades por parcela.
abstract interface class ParcelVarietyRepository {
  Stream<List<ParcelVariety>> watchByParcel(String parcelId);

  Future<List<ParcelVariety>> findByParcel(String parcelId);

  Future<List<ParcelVariety>> findAll();

  Future<bool> exists({
    required String parcelId,
    required String grapeVarietyId,
  });

  Future<void> save(ParcelVariety parcelVariety);

  Future<void> delete(String id);
}
