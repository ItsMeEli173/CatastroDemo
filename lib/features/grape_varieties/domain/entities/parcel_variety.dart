/// Presencia de una variedad en una parcela con su porcentaje de superficie.
class ParcelVariety {
  const ParcelVariety({
    required this.id,
    required this.parcelId,
    required this.grapeVarietyId,
    required this.createdAt,
    required this.updatedAt,
    this.plantedAreaPercentage,
    this.notes,
  });

  final String id;
  final String parcelId;
  final String grapeVarietyId;

  /// Porcentaje de la superficie de la parcela ocupado por la variedad.
  final double? plantedAreaPercentage;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}
