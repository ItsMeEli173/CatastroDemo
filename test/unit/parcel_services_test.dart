import 'package:flutter_test/flutter_test.dart';
import 'package:catastrodemo/core/geo/geo_point.dart';
import 'package:catastrodemo/features/parcels/domain/services/parcel_area_calculator.dart';
import 'package:catastrodemo/features/parcels/domain/services/polygon_validator.dart';

void main() {
  group('ParcelAreaCalculator', () {
    test('devuelve 0 para anillos con menos de 3 vértices', () {
      expect(ParcelAreaCalculator.areaM2([]), 0.0);
      expect(
        ParcelAreaCalculator.areaM2([
          const GeoPoint(-21.53, -64.73),
          const GeoPoint(-21.54, -64.73),
        ]),
        0.0,
      );
    });

    test('calcula superficie y conversion a hectáreas correctamente', () {
      // Triángulo aproximado
      final triangle = [
        const GeoPoint(0.0, 0.0),
        const GeoPoint(0.01, 0.0),
        const GeoPoint(0.0, 0.01),
      ];

      final area = ParcelAreaCalculator.areaM2(triangle);
      expect(area, greaterThan(500000.0));
      expect(ParcelAreaCalculator.hectares(area), closeTo(area / 10000, 0.0001));
    });
  });

  group('PolygonValidator', () {
    test('valida un polígono simple sin errores', () {
      final ring = [
        const GeoPoint(-21.53, -64.73),
        const GeoPoint(-21.53, -64.72),
        const GeoPoint(-21.54, -64.72),
        const GeoPoint(-21.54, -64.73),
      ];

      final validation = PolygonValidator.validate(ring);
      expect(validation.isValid, isTrue);
      expect(validation.errors, isEmpty);
    });

    test('detecta error cuando hay menos de 3 vértices', () {
      final ring = [
        const GeoPoint(-21.53, -64.73),
        const GeoPoint(-21.54, -64.73),
      ];

      final validation = PolygonValidator.validate(ring);
      expect(validation.isValid, isFalse);
      expect(validation.errors, contains(PolygonValidator.countError));
    });

    test('detecta auto-intersección en forma de reloj de arena', () {
      final selfIntersecting = [
        const GeoPoint(0.0, 0.0),
        const GeoPoint(1.0, 1.0),
        const GeoPoint(1.0, 0.0),
        const GeoPoint(0.0, 1.0),
      ];

      final validation = PolygonValidator.validate(selfIntersecting);
      expect(validation.isValid, isFalse);
      expect(validation.errors, contains(PolygonValidator.selfIntersectionError));
    });
  });
}
