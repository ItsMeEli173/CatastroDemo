import '../../../../core/geo/geo_point.dart';

/// Origen de un vértice.
enum VertexCaptureMethod {
  gps('GPS'),
  manual('Manual');

  const VertexCaptureMethod(this.label);

  final String label;
}

/// Vértice del límite de una parcela, ordenado por [sequenceNumber].
class ParcelVertex {
  const ParcelVertex({
    required this.id,
    required this.parcelId,
    required this.sequenceNumber,
    required this.latitude,
    required this.longitude,
    required this.captureMethod,
    required this.createdAt,
    required this.updatedAt,
    this.accuracyM,
    this.capturedAt,
  });

  final String id;
  final String parcelId;

  /// Orden consecutivo dentro del polígono, desde 0.
  final int sequenceNumber;
  final double latitude;
  final double longitude;

  /// Precisión reportada por el GPS; nula para puntos manuales.
  final double? accuracyM;
  final VertexCaptureMethod captureMethod;
  final DateTime? capturedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  GeoPoint get point => GeoPoint(latitude, longitude);

  bool get hasLowAccuracy => accuracyM != null && accuracyM! > 15;
}
