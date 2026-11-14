/// Asociación entre un agricultor y una parcela con participación opcional.
class ParcelOwner {
  const ParcelOwner({
    required this.id,
    required this.parcelId,
    required this.farmerId,
    required this.createdAt,
    required this.updatedAt,
    this.ownershipPercentage,
    this.notes,
  });

  final String id;
  final String parcelId;
  final String farmerId;

  /// Participación en la titularidad, en porcentaje (0–100). No confundir con la
  /// distribución de variedades.
  final double? ownershipPercentage;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get hasPercentage => ownershipPercentage != null;
}
