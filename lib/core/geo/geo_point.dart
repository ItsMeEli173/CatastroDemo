import 'dart:math' as math;

/// Punto geográfico en WGS84 (EPSG:4326), independiente de Flutter y plugins.
///
/// Se conserva como valor crudo y se valida con [isValid] o con el validador de
/// polígonos, para poder representar y corregir datos incompletos.
class GeoPoint {
  const GeoPoint(this.latitude, this.longitude);

  /// Radio medio terrestre usado por el cálculo de superficies.
  static const double earthRadiusMeters = 6371008.8;

  final double latitude;
  final double longitude;

  bool get isValid =>
      latitude.isFinite &&
      longitude.isFinite &&
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;

  /// Distancia aproximada en metros usando la fórmula del semiverseno.
  double distanceToMeters(GeoPoint other) {
    const toRad = math.pi / 180.0;
    final dLat = (other.latitude - latitude) * toRad;
    final dLon = (other.longitude - longitude) * toRad;
    final lat1 = latitude * toRad;
    final lat2 = other.latitude * toRad;
    final h = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dLon / 2), 2);
    return 2 * earthRadiusMeters * math.asin(math.min(1.0, math.sqrt(h)));
  }

  @override
  bool operator ==(Object other) =>
      other is GeoPoint &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => Object.hash(latitude, longitude);

  @override
  String toString() =>
      'GeoPoint(${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)})';
}
