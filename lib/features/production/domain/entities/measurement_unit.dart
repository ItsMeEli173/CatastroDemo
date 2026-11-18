/// Unidad de registro con equivalencia fija en kilogramos cuando existe.
class MeasurementUnit {
  const MeasurementUnit({
    required this.id,
    required this.code,
    required this.name,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.abbreviation,
    this.kilogramsEquivalent,
  });

  final String id;

  /// Correlativo de registro asignado por el sistema (`UNI-###`).
  final String code;

  /// Abreviatura visible y editable por el usuario (`kg`, `crate`, `ton`).
  final String? abbreviation;
  final String name;

  /// Equivalencia en kg por unidad; nula cuando el factor se define en cada
  /// estimación (por ejemplo, cajones de peso variable).
  final double? kilogramsEquivalent;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get hasFixedFactor => kilogramsEquivalent != null;
}
