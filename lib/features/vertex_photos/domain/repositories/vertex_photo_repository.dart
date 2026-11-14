import '../entities/vertex_photo.dart';

/// Metadatos y ciclo de vida de las fotografías de vértices.
abstract interface class VertexPhotoRepository {
  Future<List<VertexPhoto>> findByVertex(String vertexId);

  Future<List<VertexPhoto>> findAll();

  Future<VertexPhoto?> findById(String id);

  /// Copia [sourcePath] al almacenamiento privado con un nombre único y registra
  /// sus metadatos. Si el registro falla, el archivo copiado se elimina.
  Future<VertexPhoto> addFromFile({
    required String vertexId,
    required String sourcePath,
    String? description,
  });

  /// Elimina el registro y su archivo; no falla si el archivo ya no existe.
  Future<void> delete(String id);

  /// Fotografías cuyo archivo no está disponible en el dispositivo.
  Future<List<VertexPhoto>> findWithMissingFiles();

  /// Elimina archivos del directorio privado que no tienen registro en SQLite.
  /// Devuelve cuántos archivos se eliminaron.
  Future<int> cleanOrphans();
}
