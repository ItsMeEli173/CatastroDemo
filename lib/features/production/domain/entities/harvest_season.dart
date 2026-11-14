/// Temporada o campaña agrícola.
class HarvestSeason {
  const HarvestSeason({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.startDate,
    this.endDate,
    this.notes,
  });

  final String id;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}
