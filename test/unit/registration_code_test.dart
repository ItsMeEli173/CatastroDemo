import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/database/registration_code.dart';
import 'package:catastrodemo/core/errors/app_failure.dart';
import 'package:catastrodemo/features/farmers/data/drift_farmer_repository.dart';
import 'package:catastrodemo/features/farmers/domain/entities/farmer.dart';
import 'package:catastrodemo/features/grape_varieties/data/drift_grape_variety_repository.dart';
import 'package:catastrodemo/features/grape_varieties/domain/entities/grape_variety.dart';
import 'package:catastrodemo/features/production/data/drift_production_repositories.dart';
import 'package:catastrodemo/features/production/domain/entities/harvest_season.dart';
import 'package:catastrodemo/features/production/domain/entities/measurement_unit.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegistrationCode', () {
    test('compone el correlativo con relleno de tres dígitos', () {
      expect(RegistrationCode.format('AGR-', 1), 'AGR-001');
      expect(RegistrationCode.format('UVA-', 42), 'UVA-042');
      expect(RegistrationCode.format('TEM-', 1000), 'TEM-1000');
    });

    test('lee el número de un código del prefijo correcto', () {
      expect(RegistrationCode.parse('AGR-', 'AGR-001'), 1);
      expect(RegistrationCode.parse('AGR-', ' AGR-015 '), 15);
    });

    test('rechaza códigos de otro prefijo o sin número', () {
      expect(RegistrationCode.parse('AGR-', 'PAR-001'), isNull);
      expect(RegistrationCode.parse('AGR-', 'AGR-'), isNull);
      expect(RegistrationCode.parse('AGR-', 'AGR-abc'), isNull);
      expect(RegistrationCode.parse('AGR-', null), isNull);
    });

    test('el primer código libre es el 1 cuando no hay ninguno usado', () {
      expect(RegistrationCode.next('AGR-', <String>{}), 'AGR-001');
    });

    test('continúa la secuencia cuando los códigos son contiguos', () {
      expect(
        RegistrationCode.next('AGR-', {'AGR-001', 'AGR-002', 'AGR-003'}),
        'AGR-004',
      );
    });

    test('rellena el primer hueco en lugar de saltarlo', () {
      expect(
        RegistrationCode.next('AGR-', {'AGR-001', 'AGR-003'}),
        'AGR-002',
      );
    });

    test('termina y encuentra un hueco aunque todo el rango esté ocupado', () {
      final used = {
        for (var n = 1; n <= 500; n++) RegistrationCode.format('AGR-', n),
      };
      expect(RegistrationCode.next('AGR-', used), 'AGR-501');
    });
  });

  group('El repositorio es la autoridad sobre el código', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    Farmer farmer(String id, {String? code}) {
      final now = DateTime.now().toUtc();
      final letters = id.replaceAll(RegExp('[^a-zA-Z]'), '');
      return Farmer(
        id: id,
        code: code,
        firstName: 'Nombre$letters',
        lastName: 'Apellido$letters',
        createdAt: now,
        updatedAt: now,
      );
    }

    test('agricultor: asigna correlativos consecutivos y únicos', () async {
      final repo = DriftFarmerRepository(db.farmerDao);

      expect(await repo.nextCode(), 'AGR-001');
      await repo.save(farmer('f1'));
      expect(await repo.nextCode(), 'AGR-002');
      await repo.save(farmer('f2'));

      final saved = await repo.findFarmers();
      expect(saved.map((f) => f.code), containsAll(['AGR-001', 'AGR-002']));
    });

    test('agricultor: reparte un código nuevo si el recibido ya está tomado',
        () async {
      final repo = DriftFarmerRepository(db.farmerDao);

      await repo.save(farmer('f1', code: 'AGR-001'));
      await repo.save(farmer('f2', code: 'AGR-001'));

      final byId = {
        for (final f in await repo.findFarmers()) f.id: f.code,
      };
      expect(byId['f1'], 'AGR-001');
      expect(byId['f2'], 'AGR-002');
    });

    test('agricultor: conserva su código al volver a guardarlo', () async {
      final repo = DriftFarmerRepository(db.farmerDao);

      await repo.save(farmer('f1', code: 'AGR-007'));
      await repo.save(farmer('f1', code: 'AGR-007'));

      final saved = await repo.findById('f1');
      expect(saved!.code, 'AGR-007');
    });

    test('agricultor: conserva el código si el registro editado no lo envía',
        () async {
      final repo = DriftFarmerRepository(db.farmerDao);

      await repo.save(farmer('f1', code: 'AGR-007'));
      await repo.save(farmer('f1'));

      final saved = await repo.findById('f1');
      expect(saved!.code, 'AGR-007');
    });

    test('variedad: asigna UVA- a partir de las semillas', () async {
      final repo = DriftGrapeVarietyRepository(db.grapeVarietyDao);

      expect(await repo.nextCode(), 'UVA-005');
      final now = DateTime.now().toUtc();
      await repo.save(
        GrapeVariety(
          id: 'v1',
          name: 'Torrontés',
          active: true,
          createdAt: now,
          updatedAt: now,
        ),
      );
      final saved = await repo.findById('v1');
      expect(saved!.code, 'UVA-005');
    });

    test('temporada: asigna TEM- y lo conserva al editar', () async {
      final repo = DriftHarvestSeasonRepository(db.harvestSeasonDao);
      final now = DateTime.now().toUtc();

      expect(await repo.nextCode(), 'TEM-001');
      await repo.save(
        HarvestSeason(
          id: 's1',
          name: '2026',
          createdAt: now,
          updatedAt: now,
        ),
      );
      expect((await repo.findById('s1'))!.code, 'TEM-001');

      await repo.save(
        HarvestSeason(
          id: 's1',
          name: '2026',
          notes: 'editada',
          createdAt: now,
          updatedAt: now,
        ),
      );
      final edited = await repo.findById('s1');
      expect(edited!.code, 'TEM-001');
      expect(edited.notes, 'editada');
    });

    test('unidad: el código es UNI- y la abreviatura la elige el usuario',
        () async {
      final repo = DriftMeasurementUnitRepository(db.measurementUnitDao);
      final now = DateTime.now().toUtc();

      expect(await repo.nextCode(), 'UNI-004');
      await repo.save(
        MeasurementUnit(
          id: 'u1',
          code: '',
          abbreviation: 'caja',
          name: 'Caja de campo',
          active: true,
          createdAt: now,
          updatedAt: now,
        ),
      );

      final saved = await repo.findById('u1');
      expect(saved!.code, 'UNI-004');
      expect(saved.abbreviation, 'caja');
    });

    test('unidad: rechaza una abreviatura repetida', () async {
      final repo = DriftMeasurementUnitRepository(db.measurementUnitDao);
      final now = DateTime.now().toUtc();

      await expectLater(
        repo.save(
          MeasurementUnit(
            id: 'u1',
            code: '',
            abbreviation: 'kg',
            name: 'Kilogramo duplicado',
            active: true,
            createdAt: now,
            updatedAt: now,
          ),
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('unidad: exige la abreviatura', () async {
      final repo = DriftMeasurementUnitRepository(db.measurementUnitDao);
      final now = DateTime.now().toUtc();

      await expectLater(
        repo.save(
          MeasurementUnit(
            id: 'u1',
            code: '',
            name: 'Sin abreviatura',
            active: true,
            createdAt: now,
            updatedAt: now,
          ),
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('una base nueva siembra unidades con código y abreviatura', () async {
      final repo = DriftMeasurementUnitRepository(db.measurementUnitDao);
      final units = await repo.findAll();

      expect(units.length, 3);
      final byAbbreviation = {
        for (final unit in units) unit.abbreviation: unit.code,
      };
      expect(byAbbreviation['kg'], 'UNI-001');
      expect(byAbbreviation['crate'], 'UNI-002');
      expect(byAbbreviation['ton'], 'UNI-003');
    });
  });
}
