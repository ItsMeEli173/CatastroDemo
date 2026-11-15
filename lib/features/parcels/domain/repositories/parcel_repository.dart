import '../entities/parcel.dart';

/// Contrato de persistencia de parcelas.
abstract interface class ParcelRepository {
  Stream<List<Parcel>> watchParcels({String query = '', ParcelStatus? status});

  Future<List<Parcel>> findParcels({String query = '', ParcelStatus? status});

  Future<Parcel?> findById(String id);

  Future<Parcel?> findByCode(String code);

  Stream<List<Parcel>> watchByFarmer(String farmerId);

  Future<List<Parcel>> findByFarmer(String farmerId);

  Future<int> count();

  /// Genera el siguiente código correlativo de parcela (ej. PAR-001).
  Future<String> nextCode();

  Future<void> save(Parcel parcel);

  /// Valida la geometría antes de activar una parcela.
  Future<void> updateStatus(String id, ParcelStatus status);

  /// Elimina en cascada propietarios, vértices, variedades, estimaciones y las
  /// fotografías (filas y archivos) de sus vértices.
  Future<void> delete(String id);
}
