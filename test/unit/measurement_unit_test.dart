import 'package:catastrodemo/features/production/domain/entities/measurement_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MeasurementUnit.displayAbbreviation', () {
    final now = DateTime.now().toUtc();

    MeasurementUnit unit({String code = 'UNI-001', String? abbreviation}) =>
        MeasurementUnit(
          id: 'u1',
          code: code,
          abbreviation: abbreviation,
          name: 'Kilogramo',
          active: true,
          createdAt: now,
          updatedAt: now,
        );

    test('usa la abreviatura cuando está presente', () {
      expect(unit(abbreviation: 'kg').displayAbbreviation, 'kg');
    });

    test('cae al código cuando la abreviatura falta', () {
      expect(unit(abbreviation: null).displayAbbreviation, 'UNI-001');
    });

    test('cae al código cuando la abreviatura está vacía', () {
      expect(unit(abbreviation: '  ').displayAbbreviation, 'UNI-001');
    });
  });
}
