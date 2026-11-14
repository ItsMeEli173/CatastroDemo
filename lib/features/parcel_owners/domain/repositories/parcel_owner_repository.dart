import '../entities/parcel_owner.dart';

/// Contrato de la relación muchos a muchos entre agricultores y parcelas.
abstract interface class ParcelOwnerRepository {
  Stream<List<ParcelOwner>> watchByParcel(String parcelId);

  Stream<List<ParcelOwner>> watchByFarmer(String farmerId);

  Future<List<ParcelOwner>> findByParcel(String parcelId);

  Future<List<ParcelOwner>> findByFarmer(String farmerId);

  Future<ParcelOwner?> findById(String id);

  Future<bool> exists({required String parcelId, required String farmerId});

  Future<void> save(ParcelOwner owner);

  Future<void> delete(String id);
}
