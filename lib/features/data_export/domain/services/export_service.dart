/// Resultado de una exportación generada en el almacenamiento de la aplicación.
class ExportArtifact {
  const ExportArtifact({
    required this.filePath,
    required this.fileName,
    required this.recordCount,
    required this.photoCount,
    required this.sizeBytes,
  });

  final String filePath;
  final String fileName;
  final int recordCount;
  final int photoCount;
  final int sizeBytes;

  String get sizeLabel {
    if (sizeBytes >= 1024 * 1024) {
      return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    if (sizeBytes >= 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '$sizeBytes B';
  }
}

/// Contrato de exportación de datos estructurados y respaldo completo.
abstract interface class ExportService {
  /// JSON con todas las entidades y relaciones, sin archivos binarios.
  Future<ExportArtifact> exportJson();

  /// ZIP con `manifest.json`, `data.json` y las fotografías disponibles.
  Future<ExportArtifact> exportZip();
}
