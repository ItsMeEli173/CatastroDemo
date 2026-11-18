import '../entities/harvest_season.dart';
import '../entities/measurement_unit.dart';
import '../entities/production_estimate.dart';

/// Temporadas agrícolas.
abstract interface class HarvestSeasonRepository {
  Stream<List<HarvestSeason>> watchAll();

  Future<List<HarvestSeason>> findAll();

  Future<HarvestSeason?> findById(String id);

  Future<HarvestSeason?> findByName(String name);

  /// Genera el siguiente código correlativo de temporada (ej. TEM-001).
  Future<String> nextCode();

  Future<void> save(HarvestSeason season);

  /// Falla con [InUseFailure] si la temporada tiene estimaciones.
  Future<void> delete(String id);
}

/// Unidades de registro y su equivalencia en kilogramos.
abstract interface class MeasurementUnitRepository {
  Stream<List<MeasurementUnit>> watchAll({bool includeInactive = true});

  Future<List<MeasurementUnit>> findAll({bool includeInactive = true});

  Future<MeasurementUnit?> findById(String id);

  Future<MeasurementUnit?> findByCode(String code);

  /// Genera el siguiente código correlativo de unidad (ej. UNI-001).
  Future<String> nextCode();

  Future<void> save(MeasurementUnit unit);

  /// Falla con [InUseFailure] si la unidad tiene estimaciones.
  Future<void> delete(String id);
}

/// Estimaciones de producción.
abstract interface class ProductionEstimateRepository {
  Stream<List<ProductionEstimate>> watchByParcel(
    String parcelId, {
    String? seasonId,
  });

  Future<List<ProductionEstimate>> findByParcel(
    String parcelId, {
    String? seasonId,
  });

  Future<List<ProductionEstimate>> findAll();

  Future<ProductionEstimate?> findById(String id);

  Future<void> save(ProductionEstimate estimate);

  Future<void> delete(String id);
}
