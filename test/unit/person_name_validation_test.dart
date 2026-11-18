import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/errors/app_failure.dart';
import 'package:catastrodemo/core/validation/person_name_input_formatter.dart';
import 'package:catastrodemo/core/validation/validators.dart';
import 'package:catastrodemo/features/farmers/data/drift_farmer_repository.dart';
import 'package:catastrodemo/features/farmers/domain/entities/farmer.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators.normalizePersonName', () {
    test('recorta los extremos y colapsa los espacios internos', () {
      expect(
        Validators.normalizePersonName('  Juan   Carlos '),
        'Juan Carlos',
      );
    });

    test('devuelve cadena vacía si solo hay espacios', () {
      expect(Validators.normalizePersonName('   '), '');
    });

    test('acepta null', () {
      expect(Validators.normalizePersonName(null), '');
    });
  });

  group('Validators.requiredName', () {
    test('acepta un nombre simple', () {
      expect(
        Validators.requiredName('Juan', message: 'Ingresa el nombre.'),
        isNull,
      );
    });

    test('acepta acentos, diéresis y Ñ', () {
      for (final name in ['Núñez', 'Ñandú', 'María', 'Ürsula', 'Ángel']) {
        expect(
          Validators.requiredName(name, message: 'x'),
          isNull,
          reason: 'debería aceptar $name',
        );
      }
    });

    test('acepta nombre compuesto con espacio interno', () {
      expect(Validators.requiredName('Juan Carlos', message: 'x'), isNull);
    });

    test('normaliza espacios sobrantes en lugar de rechazarlos', () {
      expect(Validators.requiredName('  Juan   Carlos  ', message: 'x'), isNull);
    });

    test('rechaza vacío y solo espacios con el mensaje recibido', () {
      expect(
        Validators.requiredName('', message: 'Ingresa el nombre.'),
        'Ingresa el nombre.',
      );
      expect(
        Validators.requiredName('   ', message: 'Ingresa el nombre.'),
        'Ingresa el nombre.',
      );
    });

    test('rechaza dígitos', () {
      expect(Validators.requiredName('Juan3', message: 'x'), isNotNull);
    });

    test('rechaza símbolos, puntuación y guiones', () {
      for (final bad in ['Juan@x', 'Juan-Carlos', "O'Brien", 'Juan,', 'Juan.']) {
        expect(
          Validators.requiredName(bad, message: 'x'),
          isNotNull,
          reason: 'debería rechazar $bad',
        );
      }
    });

    test('rechaza emojis', () {
      expect(Validators.requiredName('Juan🙂', message: 'x'), isNotNull);
    });

    test('rechaza guion bajo', () {
      expect(Validators.requiredName('Juan_Carlos', message: 'x'), isNotNull);
    });

    test('normaliza tabulación y espacio duro en lugar de rechazarlos', () {
      expect(Validators.requiredName('Juan\tCarlos', message: 'x'), isNull);
      expect(Validators.requiredName('Juan\u00a0Carlos', message: 'x'), isNull);
      expect(
        Validators.normalizePersonName('Juan\tCarlos'),
        'Juan Carlos',
      );
      expect(
        Validators.normalizePersonName('Juan\u00a0Carlos'),
        'Juan Carlos',
      );
    });

    test('respeta el máximo de longitud', () {
      expect(Validators.requiredName('a' * 121, message: 'x'), isNotNull);
      expect(Validators.requiredName('a' * 120, message: 'x'), isNull);
    });
  });

  group('PersonNameInputFormatter', () {
    const formatter = PersonNameInputFormatter();

    TextEditingValue type(String text) => formatter.formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          ),
        );

    test('bloquea dígitos y símbolos', () {
      expect(type('Juan3').text, 'Juan');
      expect(type('Juan@x').text, 'Juanx');
    });

    test('bloquea emojis', () {
      expect(type('Juan🙂').text, 'Juan');
    });

    test('conserva acentos, diéresis y Ñ', () {
      expect(type('Núñez').text, 'Núñez');
      expect(type('Ñandú').text, 'Ñandú');
      expect(type('Ürsula').text, 'Ürsula');
    });

    test('no permite espacio al inicio', () {
      expect(type(' Juan').text, 'Juan');
    });

    test('no permite espacios dobles', () {
      expect(type('Juan  Carlos').text, 'Juan Carlos');
    });

    test('convierte tabulación y espacio duro en un espacio simple', () {
      expect(type('Juan\tCarlos').text, 'Juan Carlos');
      expect(type('Juan\u00a0Carlos').text, 'Juan Carlos');
    });

    test('permite espacio final para poder escribir la segunda palabra', () {
      expect(type('Juan ').text, 'Juan ');
    });

    test('deja el cursor al final del texto filtrado', () {
      expect(type('Juan3').selection.baseOffset, 4);
    });

    test('elimina todo cuando no queda nada permitido', () {
      expect(type('123').text, '');
      expect(type('   ').text, '');
    });
  });

  group('DriftFarmerRepository aplica la misma regla', () {
    late AppDatabase db;
    late DriftFarmerRepository repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = DriftFarmerRepository(db.farmerDao);
    });

    tearDown(() async {
      await db.close();
    });

    Farmer build(String id, String firstName, String lastName) {
      final now = DateTime.now().toUtc();
      return Farmer(
        id: id,
        firstName: firstName,
        lastName: lastName,
        createdAt: now,
        updatedAt: now,
      );
    }

    test('rechaza un nombre con dígitos', () async {
      await expectLater(
        repo.save(build('f1', 'Juan3', 'Pérez')),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('rechaza un apellido con símbolos', () async {
      await expectLater(
        repo.save(build('f2', 'Juan', 'Pérez@')),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('rechaza un nombre que queda vacío tras recortar', () async {
      await expectLater(
        repo.save(build('f3', '   ', 'Pérez')),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('guarda normalizado un nombre con espacios sobrantes', () async {
      await repo.save(build('f4', '  Juan   Carlos ', ' Núñez '));
      final saved = await repo.findById('f4');
      expect(saved, isNotNull);
      expect(saved!.firstName, 'Juan Carlos');
      expect(saved.lastName, 'Núñez');
    });

    test('acepta Ñ, acentos y diéresis', () async {
      await repo.save(build('f5', 'Ñandú', 'Ürsula Muñoz'));
      final saved = await repo.findById('f5');
      expect(saved!.firstName, 'Ñandú');
      expect(saved.lastName, 'Ürsula Muñoz');
    });
  });
}
