/// Variedad de uva del catálogo local editable.
class GrapeVariety {
  const GrapeVariety({
    required this.id,
    required this.name,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.category,
    this.description,
    this.aliases,
  });

  final String id;
  final String name;

  /// Clasificación libre, por ejemplo `Blanca` o `Tinta`.
  final String? category;
  final String? description;

  /// Nombres alternativos separados por comas.
  final String? aliases;

  /// Si es falso no se ofrece en nuevos registros, pero conserva su historial.
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
}
