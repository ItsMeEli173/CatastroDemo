import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../domain/entities/parcel_owner.dart';
import '../domain/repositories/parcel_owner_repository.dart';
import 'drift_parcel_owner_repository.dart';

/// Repositorio de propietarios de parcelas.
final parcelOwnerRepositoryProvider = Provider<ParcelOwnerRepository>(
  (ref) => DriftParcelOwnerRepository(
    ref.watch(appDatabaseProvider).parcelOwnerDao,
  ),
);

/// Propietarios de una parcela.
final parcelOwnersProvider =
    StreamProvider.family<List<ParcelOwner>, String>(
  (ref, parcelId) =>
      ref.watch(parcelOwnerRepositoryProvider).watchByParcel(parcelId),
);

/// Parcelas donde participa un agricultor.
final farmerParcelLinksProvider =
    StreamProvider.family<List<ParcelOwner>, String>(
  (ref, farmerId) =>
      ref.watch(parcelOwnerRepositoryProvider).watchByFarmer(farmerId),
);
