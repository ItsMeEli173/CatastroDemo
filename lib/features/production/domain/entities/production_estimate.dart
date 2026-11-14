/// Estimación de producción de una parcela en una temporada.
///
/// Si [grapeVarietyId] es nulo la estimación es general de la parcela; si tiene
/// valor corresponde a una variedad concreta. Ambos modos nunca se suman entre
/// sí en un mismo reporte.
class ProductionEstimate {
  const ProductionEstimate({
    required this.id,
    required this.parcelId,
    required this.seasonId,
    required this.quantity,
    required this.unitId,
    required this.conversionFactorKg,
    required this.estimatedKg,
    required this.createdAt,
    required this.updatedAt,
    this.grapeVarietyId,
    this.notes,
  });

  final String id;
  final String parcelId;
  final String seasonId;
  final String? grapeVarietyId;
  final double quantity;
  final String unitId;

  /// Factor aplicado en el momento del registro; preserva el cálculo histórico.
  final double conversionFactorKg;
  final double estimatedKg;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isGeneral => grapeVarietyId == null;
}
