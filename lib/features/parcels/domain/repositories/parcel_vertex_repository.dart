import '../entities/parcel_vertex.dart';

/// Contrato de la geometría de parcelas.
abstract interface class ParcelVertexRepository {
  Stream<List<ParcelVertex>> watchByParcel(String parcelId);

  Future<List<ParcelVertex>> findByParcel(String parcelId);

  Future<int> countByParcel(String parcelId);

  /// Reemplaza la geometría completa de la parcela en una transacción.
  ///
  /// Renumera `sequence_number` según el orden recibido, elimina los vértices
  /// ausentes con sus fotografías y recalcula `calculated_area_m2` (o lo deja
  /// nulo si el polígono no es válido). Las entidades deben traer `id` asignado.
  Future<void> replaceAll(String parcelId, List<ParcelVertex> vertices);
}
