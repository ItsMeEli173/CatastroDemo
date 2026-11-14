import 'dart:math' as math;

import '../../../../core/geo/geo_point.dart';

/// Cálculo de superficie para polígonos geográficos en WGS84.
///
/// Método: excedente esférico (Chamberlain & Duquette) sobre una esfera de radio
/// medio [GeoPoint.earthRadiusMeters]. No se tratan latitud y longitud como
/// coordenadas cartesianas ni se suman distancias entre vértices.
///
/// Límites: el error típico es inferior al 0,1 % en parcelas de hasta pocos
/// kilómetros y crece en polígonos que abarcan grandes extensiones, cerca de los
/// polos o con aristas que cruzan el antimeridiano. La superficie es aproximada y
/// no constituye un levantamiento topográfico certificado.
abstract final class ParcelAreaCalculator {
  /// Superficie en metros cuadrados. Devuelve 0 si hay menos de tres vértices.
  static double areaM2(List<GeoPoint> ring) {
    if (ring.length < 3) return 0;
    var sum = 0.0;
    for (var i = 0; i < ring.length; i++) {
      final current = ring[i];
      final next = ring[(i + 1) % ring.length];
      var deltaLongitude = _radians(next.longitude - current.longitude);
      if (deltaLongitude > math.pi) deltaLongitude -= 2 * math.pi;
      if (deltaLongitude < -math.pi) deltaLongitude += 2 * math.pi;
      final latitude1 = _radians(current.latitude);
      final latitude2 = _radians(next.latitude);
      sum += deltaLongitude *
          (2 + math.sin(latitude1) + math.sin(latitude2));
    }
    final area = (sum *
            GeoPoint.earthRadiusMeters *
            GeoPoint.earthRadiusMeters /
            2)
        .abs();
    return area.isFinite ? area : 0;
  }

  /// Superficie en hectáreas (`1 ha = 10 000 m²`).
  static double hectares(double squareMeters) => squareMeters / 10000;

  static double _radians(double degrees) => degrees * math.pi / 180;
}
