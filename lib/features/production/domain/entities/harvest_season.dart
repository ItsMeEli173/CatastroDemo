/// Temporada o campaña agrícola.
class HarvestSeason {
  const HarvestSeason({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.code,
    this.startDate,
    this.endDate,
    this.notes,
  });

  final String id;

  /// Correlativo de registro asignado por el sistema (`TEM-###`).
  final String? code;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}
