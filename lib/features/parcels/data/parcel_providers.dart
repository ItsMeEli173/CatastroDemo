import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../domain/entities/parcel.dart';
import '../domain/entities/parcel_vertex.dart';
import '../domain/repositories/parcel_repository.dart';
import '../domain/repositories/parcel_vertex_repository.dart';
import 'package:catastrodemo/features/parcels/data/drift_parcel_repository.dart';
import 'package:catastrodemo/features/parcels/data/drift_parcel_vertex_repository.dart';

/// Repositorio de parcelas.
final parcelRepositoryProvider = Provider<ParcelRepository>(
  (ref) => DriftParcelRepository(
    ref.watch(appDatabaseProvider).parcelDao,
    ref.watch(appDatabaseProvider).parcelVertexDao,
    ref.watch(photoStorageProvider),
  ),
);

/// Repositorio de la geometría de parcelas.
final parcelVertexRepositoryProvider = Provider<ParcelVertexRepository>(
  (ref) => DriftParcelVertexRepository(
    ref.watch(appDatabaseProvider).parcelVertexDao,
    ref.watch(appDatabaseProvider).parcelDao,
    ref.watch(photoStorageProvider),
  ),
);

/// Filtro de listado de parcelas.
class ParcelFilter {
  const ParcelFilter({this.query = '', this.status});

  final String query;
  final ParcelStatus? status;

  @override
  bool operator ==(Object other) =>
      other is ParcelFilter &&
      other.query == query &&
      other.status == status;

  @override
  int get hashCode => Object.hash(query, status);
}

/// Parcelas filtradas por texto y estado.
final parcelsProvider = StreamProvider.family<List<Parcel>, ParcelFilter>(
  (ref, filter) => ref
      .watch(parcelRepositoryProvider)
      .watchParcels(query: filter.query, status: filter.status),
);

/// Parcela por identificador.
final parcelProvider = FutureProvider.family<Parcel?, String>(
  (ref, id) => ref.watch(parcelRepositoryProvider).findById(id),
);

/// Parcelas asociadas a un agricultor.
final parcelsByFarmerProvider = StreamProvider.family<List<Parcel>, String>(
  (ref, farmerId) =>
      ref.watch(parcelRepositoryProvider).watchByFarmer(farmerId),
);

/// Vértices de una parcela, ordenados.
final parcelVerticesProvider =
    StreamProvider.family<List<ParcelVertex>, String>(
  (ref, parcelId) =>
      ref.watch(parcelVertexRepositoryProvider).watchByParcel(parcelId),
);

/// Cantidad total de parcelas registradas.
final parcelCountProvider = StreamProvider<int>(
  (ref) => ref.watch(parcelRepositoryProvider).watchCount(),
);
