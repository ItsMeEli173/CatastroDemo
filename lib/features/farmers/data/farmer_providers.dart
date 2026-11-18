import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../domain/entities/farmer.dart';
import '../domain/repositories/farmer_repository.dart';
import 'drift_farmer_repository.dart';

/// Repositorio de agricultores.
final farmerRepositoryProvider = Provider<FarmerRepository>(
  (ref) => DriftFarmerRepository(ref.watch(appDatabaseProvider).farmerDao),
);

/// Agricultores filtrados por [query] (vacía para todos).
final farmersProvider = StreamProvider.family<List<Farmer>, String>(
  (ref, query) =>
      ref.watch(farmerRepositoryProvider).watchFarmers(query: query),
);

/// Agricultor por identificador.
final farmerProvider = FutureProvider.family<Farmer?, String>(
  (ref, id) => ref.watch(farmerRepositoryProvider).findById(id),
);

/// Cantidad total de agricultores registrados.
final farmerCountProvider = StreamProvider<int>(
  (ref) => ref.watch(farmerRepositoryProvider).watchCount(),
);
