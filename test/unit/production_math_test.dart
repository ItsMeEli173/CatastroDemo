import 'package:flutter_test/flutter_test.dart';
import 'package:catastrodemo/core/errors/app_failure.dart';
import 'package:catastrodemo/features/production/domain/services/production_math.dart';

void main() {
  group('ProductionMath', () {
    test('calcula kilogramos estimados multiplicando cantidad por factor', () {
      final kg = ProductionMath.estimatedKg(
        quantity: 50,
        conversionFactorKg: 18.5,
      );
      expect(kg, 925.0);
    });

    test('falla si la cantidad es menor o igual a cero', () {
      expect(
        () => ProductionMath.estimatedKg(quantity: 0, conversionFactorKg: 20),
        throwsA(isA<ValidationFailure>()),
      );
      expect(
        () => ProductionMath.estimatedKg(quantity: -5, conversionFactorKg: 20),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('falla si el factor de conversion es menor o igual a cero', () {
      expect(
        () => ProductionMath.estimatedKg(quantity: 10, conversionFactorKg: 0),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('redondea a dos decimales', () {
      expect(ProductionMath.roundedKg(123.456), 123.46);
      expect(ProductionMath.roundedKg(123.454), 123.45);
    });
  });
}
