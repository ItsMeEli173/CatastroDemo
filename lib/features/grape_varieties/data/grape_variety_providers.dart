import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../domain/entities/grape_variety.dart';
import '../domain/entities/parcel_variety.dart';
import '../domain/repositories/grape_variety_repository.dart';
import 'drift_grape_variety_repository.dart';
import 'drift_parcel_variety_repository.dart';

/// Repositorio del catálogo de variedades.
final grapeVarietyRepositoryProvider = Provider<GrapeVarietyRepository>(
  (ref) => DriftGrapeVarietyRepository(
    ref.watch(appDatabaseProvider).grapeVarietyDao,
  ),
);

/// Repositorio de la distribución de variedades por parcela.
final parcelVarietyRepositoryProvider = Provider<ParcelVarietyRepository>(
  (ref) => DriftParcelVarietyRepository(
    ref.watch(appDatabaseProvider).parcelVarietyDao,
  ),
);

/// Filtro del catálogo de variedades.
class VarietyFilter {
  const VarietyFilter({this.query = '', this.includeInactive = false});

  final String query;
  final bool includeInactive;

  @override
  bool operator ==(Object other) =>
      other is VarietyFilter &&
      other.query == query &&
      other.includeInactive == includeInactive;

  @override
  int get hashCode => Object.hash(query, includeInactive);
}

/// Variedades filtradas.
final grapeVarietiesProvider =
    StreamProvider.family<List<GrapeVariety>, VarietyFilter>(
  (ref, filter) => ref.watch(grapeVarietyRepositoryProvider).watchAll(
        query: filter.query,
        includeInactive: filter.includeInactive,
      ),
);

/// Variedades activas ordenadas por nombre.
final activeGrapeVarietiesProvider = StreamProvider<List<GrapeVariety>>(
  (ref) => ref.watch(grapeVarietyRepositoryProvider).watchAll(),
);

/// Variedades presentes en una parcela.
final parcelVarietiesProvider =
    StreamProvider.family<List<ParcelVariety>, String>(
  (ref, parcelId) =>
      ref.watch(parcelVarietyRepositoryProvider).watchByParcel(parcelId),
);
