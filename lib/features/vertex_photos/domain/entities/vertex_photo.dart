/// Metadatos de una fotografía asociada a un vértice.
///
/// El archivo binario vive en el almacenamiento privado de la aplicación; en
/// SQLite solo se guarda su ruta relativa.
class VertexPhoto {
  const VertexPhoto({
    required this.id,
    required this.vertexId,
    required this.relativePath,
    required this.fileName,
    required this.createdAt,
    this.description,
  });

  final String id;
  final String vertexId;

  /// Ruta relativa al directorio privado de fotografías, por ejemplo
  /// `photos/photo_<uuid>.jpg`. Nunca es una ruta absoluta.
  final String relativePath;
  final String fileName;
  final String? description;
  final DateTime createdAt;
}
