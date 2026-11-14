import 'dart:math' as math;

import '../../../../core/geo/geo_point.dart';
import 'parcel_area_calculator.dart';

/// Resultado de validar una geometría de parcela.
class PolygonValidation {
  const PolygonValidation(this.errors);

  final List<String> errors;

  bool get isValid => errors.isEmpty;

  String? get firstError => errors.isEmpty ? null : errors.first;
}

/// Reglas de validación de polígonos definidas en la Fase 0 (RN-13 a RN-16).
///
/// La intersección de aristas se evalúa en el plano longitud/latitud, adecuado
/// para parcelas pequeñas; no sustituye una validación geodésica exhaustiva.
abstract final class PolygonValidator {
  static const int minimumVertices = 3;
  static const double minimumAreaM2 = 1.0;

  /// Tolerancia para considerar dos vértices consecutivos como el mismo punto.
  static const double samePointToleranceMeters = 0.05;

  static const String rangeError = 'Coordenada fuera de rango.';
  static const String countError = 'Se necesitan al menos 3 vértices.';
  static const String duplicateError = 'Hay vértices consecutivos repetidos.';
  static const String selfIntersectionError =
      'El polígono se cruza consigo mismo.';
  static const String nullAreaError =
      'La superficie del polígono es nula o inválida.';

  static PolygonValidation validate(List<GeoPoint> ring) {
    final errors = <String>[];
    if (ring.any((point) => !point.isValid)) {
      errors.add(rangeError);
    }
    if (ring.length < minimumVertices) {
      errors.add(countError);
      return PolygonValidation(errors);
    }
    if (hasConsecutiveDuplicates(ring)) {
      errors.add(duplicateError);
    }
    if (hasSelfIntersection(ring)) {
      errors.add(selfIntersectionError);
    }
    if (errors.isEmpty &&
        ParcelAreaCalculator.areaM2(ring) < minimumAreaM2) {
      errors.add(nullAreaError);
    }
    return PolygonValidation(errors);
  }

  /// Compara cada vértice con el siguiente y el último con el primero.
  static bool hasConsecutiveDuplicates(List<GeoPoint> ring) {
    for (var i = 0; i < ring.length; i++) {
      final current = ring[i];
      final next = ring[(i + 1) % ring.length];
      if (current.distanceToMeters(next) <= samePointToleranceMeters) {
        return true;
      }
    }
    return false;
  }

  static bool hasSelfIntersection(List<GeoPoint> ring) {
    final count = ring.length;
    if (count < 4) return false;
    for (var i = 0; i < count; i++) {
      final a = ring[i];
      final b = ring[(i + 1) % count];
      for (var j = i + 1; j < count; j++) {
        final adjacent = j == i + 1 || (i == 0 && j == count - 1);
        if (adjacent) continue;
        final c = ring[j];
        final d = ring[(j + 1) % count];
        if (_segmentsIntersect(a, b, c, d)) return true;
      }
    }
    return false;
  }

  static bool _segmentsIntersect(GeoPoint p1, GeoPoint q1, GeoPoint p2, GeoPoint q2) {
    final o1 = _orientation(p1, q1, p2);
    final o2 = _orientation(p1, q1, q2);
    final o3 = _orientation(p2, q2, p1);
    final o4 = _orientation(p2, q2, q1);

    if (o1 != o2 && o3 != o4) return true;
    if (o1 == 0 && _onSegment(p1, p2, q1)) return true;
    if (o2 == 0 && _onSegment(p1, q2, q1)) return true;
    if (o3 == 0 && _onSegment(p2, p1, q2)) return true;
    if (o4 == 0 && _onSegment(p2, q1, q2)) return true;
    return false;
  }

  /// 0 = colineal, 1 = sentido horario, -1 = sentido antihorario.
  static int _orientation(GeoPoint a, GeoPoint b, GeoPoint c) {
    final cross = (b.longitude - a.longitude) * (c.latitude - a.latitude) -
        (b.latitude - a.latitude) * (c.longitude - a.longitude);
    if (cross.abs() < 1e-14) return 0;
    return cross > 0 ? 1 : -1;
  }

  static bool _onSegment(GeoPoint a, GeoPoint p, GeoPoint b) {
    const epsilon = 1e-12;
    return p.longitude >= math.min(a.longitude, b.longitude) - epsilon &&
        p.longitude <= math.max(a.longitude, b.longitude) + epsilon &&
        p.latitude >= math.min(a.latitude, b.latitude) - epsilon &&
        p.latitude <= math.max(a.latitude, b.latitude) + epsilon;
  }
}
