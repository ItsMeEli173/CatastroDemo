import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../domain/entities/harvest_season.dart';
import '../domain/entities/measurement_unit.dart';
import '../domain/entities/production_estimate.dart';
import '../domain/repositories/production_repositories.dart';
import 'drift_production_repositories.dart';

/// Repositorio de temporadas.
final harvestSeasonRepositoryProvider = Provider<HarvestSeasonRepository>(
  (ref) => DriftHarvestSeasonRepository(
    ref.watch(appDatabaseProvider).harvestSeasonDao,
  ),
);

/// Repositorio de unidades de registro.
final measurementUnitRepositoryProvider = Provider<MeasurementUnitRepository>(
  (ref) => DriftMeasurementUnitRepository(
    ref.watch(appDatabaseProvider).measurementUnitDao,
  ),
);

/// Repositorio de estimaciones de producción.
final productionEstimateRepositoryProvider =
    Provider<ProductionEstimateRepository>(
  (ref) => DriftProductionEstimateRepository(
    ref.watch(appDatabaseProvider).productionEstimateDao,
  ),
);

/// Temporadas agrícolas ordenadas.
final harvestSeasonsProvider = StreamProvider<List<HarvestSeason>>(
  (ref) => ref.watch(harvestSeasonRepositoryProvider).watchAll(),
);

/// Unidades de registro según se incluyan las inactivas.
final measurementUnitsProvider =
    StreamProvider.family<List<MeasurementUnit>, bool>(
  (ref, includeInactive) => ref
      .watch(measurementUnitRepositoryProvider)
      .watchAll(includeInactive: includeInactive),
);

/// Filtro de estimaciones de una parcela.
class EstimateFilter {
  const EstimateFilter({required this.parcelId, this.seasonId});

  final String parcelId;
  final String? seasonId;

  @override
  bool operator ==(Object other) =>
      other is EstimateFilter &&
      other.parcelId == parcelId &&
      other.seasonId == seasonId;

  @override
  int get hashCode => Object.hash(parcelId, seasonId);
}

/// Estimaciones de una parcela, opcionalmente por temporada.
final productionEstimatesProvider =
    StreamProvider.family<List<ProductionEstimate>, EstimateFilter>(
  (ref, filter) => ref
      .watch(productionEstimateRepositoryProvider)
      .watchByParcel(filter.parcelId, seasonId: filter.seasonId),
);
