import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/features/farmers/data/drift_farmer_repository.dart';
import 'package:catastrodemo/features/grape_varieties/data/drift_grape_variety_repository.dart';
import 'package:catastrodemo/features/production/data/drift_production_repositories.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Migración v2 → v4 con datos reales.
///
/// El esquema v2 se escribe a mano y se marca con `PRAGMA user_version = 2`
/// dentro del callback `setup`, que Drift ejecuta antes de leer la versión. Así
/// la apertura dispara `onUpgrade(2, 4)`: el relleno de códigos de la versión 3
/// se prueba contra filas concretas y, sobre el mismo paso, la depuración de
/// fotografías de la versión 4.
void main() {
  group('Migración v2 → v4', () {
    late AppDatabase db;

    setUp(() async {
      db = AppDatabase(
        NativeDatabase.memory(setup: (raw) {
          raw.execute('''
            CREATE TABLE farmers (
              id TEXT NOT NULL PRIMARY KEY,
              first_name TEXT NOT NULL,
              last_name TEXT NOT NULL,
              document_number TEXT,
              phone TEXT,
              email TEXT,
              locality TEXT,
              address TEXT,
              notes TEXT,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          raw.execute('''
            CREATE TABLE grape_varieties (
              id TEXT NOT NULL PRIMARY KEY,
              name TEXT NOT NULL,
              category TEXT,
              description TEXT,
              aliases TEXT,
              active INTEGER NOT NULL,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          raw.execute('''
            CREATE TABLE harvest_seasons (
              id TEXT NOT NULL PRIMARY KEY,
              name TEXT NOT NULL,
              start_date INTEGER,
              end_date INTEGER,
              notes TEXT,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          raw.execute('''
            CREATE TABLE measurement_units (
              id TEXT NOT NULL PRIMARY KEY,
              code TEXT NOT NULL,
              name TEXT NOT NULL,
              kilograms_equivalent REAL,
              active INTEGER NOT NULL,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          // La base v2 ya tenía geometría y fotografías de vértices; la
          // migración a v4 depura duplicados y crea el índice único sobre
          // `vertex_photos`.
          raw.execute('''
            CREATE TABLE parcels (
              id TEXT NOT NULL PRIMARY KEY,
              code TEXT NOT NULL,
              name TEXT,
              declared_area_m2 REAL,
              calculated_area_m2 REAL,
              status TEXT NOT NULL,
              image_path TEXT,
              notes TEXT,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          raw.execute('''
            CREATE TABLE parcel_vertices (
              id TEXT NOT NULL PRIMARY KEY,
              parcel_id TEXT NOT NULL REFERENCES parcels (id) ON DELETE CASCADE,
              sequence_number INTEGER NOT NULL,
              latitude REAL NOT NULL,
              longitude REAL NOT NULL,
              accuracy_m REAL,
              capture_method TEXT NOT NULL,
              captured_at INTEGER,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          raw.execute('''
            CREATE TABLE vertex_photos (
              id TEXT NOT NULL PRIMARY KEY,
              vertex_id TEXT NOT NULL
                REFERENCES parcel_vertices (id) ON DELETE CASCADE,
              relative_path TEXT NOT NULL,
              file_name TEXT NOT NULL,
              description TEXT,
              created_at INTEGER NOT NULL
            )
          ''');

          // Agricultores: correlativo heredado, CI real, correlativo repetido y
          // documento ausente.
          raw.execute(
            "INSERT INTO farmers VALUES ('f1','Juan','Pérez','AGR-001',NULL,NULL,"
            'NULL,NULL,NULL,1,1)',
          );
          raw.execute(
            "INSERT INTO farmers VALUES ('f2','Ana','Gómez','12345678',NULL,NULL,"
            'NULL,NULL,NULL,2,2)',
          );
          raw.execute(
            "INSERT INTO farmers VALUES ('f3','Luis','Díaz','AGR-001',NULL,NULL,"
            'NULL,NULL,NULL,3,3)',
          );
          raw.execute(
            "INSERT INTO farmers VALUES ('f4','Eva','Ruiz',NULL,NULL,NULL,"
            'NULL,NULL,NULL,4,4)',
          );

          raw.execute(
            "INSERT INTO grape_varieties VALUES ('v1','Malbec','Tinta',NULL,NULL,"
            '1,1,1)',
          );
          raw.execute(
            "INSERT INTO grape_varieties VALUES ('v2','Syrah','Tinta',NULL,NULL,"
            '1,2,2)',
          );

          raw.execute(
            "INSERT INTO harvest_seasons VALUES ('s1','2025',NULL,NULL,NULL,1,1)",
          );
          raw.execute(
            "INSERT INTO harvest_seasons VALUES ('s2','2026',NULL,NULL,NULL,2,2)",
          );

          // En v2 el código de la unidad era su abreviatura.
          raw.execute(
            "INSERT INTO measurement_units VALUES ('u1','kg','Kilogramo',1.0,1,1,1)",
          );
          raw.execute(
            "INSERT INTO measurement_units VALUES ('u2','crate','Cajón',NULL,1,2,2)",
          );
          raw.execute(
            "INSERT INTO measurement_units VALUES ('u3','ton','Tonelada',1000.0,1,3,3)",
          );

          raw.execute('PRAGMA user_version = 2');
        }),
      );
      // La primera consulta dispara la apertura y, con ella, la migración.
      await db.customSelect('SELECT 1').get();
    });

    tearDown(() async {
      await db.close();
    });

    test('sube la versión del esquema a 4', () async {
      final row = await db.customSelect('PRAGMA user_version').getSingle();
      expect(row.read<int>('user_version'), 4);
    });

    test('conserva la cantidad de filas de cada tabla', () async {
      Future<int> count(String table) async {
        final row =
            await db.customSelect('SELECT COUNT(*) AS c FROM $table').getSingle();
        return row.read<int>('c');
      }

      expect(await count('farmers'), 4);
      expect(await count('grape_varieties'), 2);
      expect(await count('harvest_seasons'), 2);
      expect(await count('measurement_units'), 3);
    });

    test('mueve el correlativo heredado del documento al código', () async {
      final farmers = await DriftFarmerRepository(db.farmerDao).findFarmers();
      final byId = {for (final f in farmers) f.id: f};

      expect(byId['f1']!.code, 'AGR-001');
      expect(byId['f1']!.documentNumber, isNull);
    });

    test('conserva el documento cuando era un CI real', () async {
      final farmers = await DriftFarmerRepository(db.farmerDao).findFarmers();
      final byId = {for (final f in farmers) f.id: f};

      expect(byId['f2']!.documentNumber, '12345678');
      expect(byId['f2']!.code, 'AGR-002');
    });

    test('reparte un código libre cuando el heredado estaba repetido', () async {
      final farmers = await DriftFarmerRepository(db.farmerDao).findFarmers();
      final byId = {for (final f in farmers) f.id: f};

      expect(byId['f3']!.code, 'AGR-003');
      expect(byId['f3']!.documentNumber, isNull);
      expect(byId['f4']!.code, 'AGR-004');
    });

    test('los códigos asignados no se repiten', () async {
      final codes = [
        for (final f in await DriftFarmerRepository(db.farmerDao).findFarmers())
          f.code,
      ];
      expect(codes.toSet().length, codes.length);
    });

    test('el siguiente correlativo continúa la secuencia migrada', () async {
      expect(await DriftFarmerRepository(db.farmerDao).nextCode(), 'AGR-005');
    });

    test('asigna códigos UVA- y TEM- a los catálogos migrados', () async {
      final varieties =
          await DriftGrapeVarietyRepository(db.grapeVarietyDao).findAll();
      expect(
        {for (final v in varieties) v.id: v.code},
        {'v1': 'UVA-001', 'v2': 'UVA-002'},
      );

      final seasons =
          await DriftHarvestSeasonRepository(db.harvestSeasonDao).findAll();
      expect(
        {for (final s in seasons) s.id: s.code},
        {'s1': 'TEM-001', 's2': 'TEM-002'},
      );
    });

    test('mueve la abreviatura de la unidad y regenera su código', () async {
      final units =
          await DriftMeasurementUnitRepository(db.measurementUnitDao).findAll();
      final byId = {for (final u in units) u.id: u};

      expect(byId['u1']!.abbreviation, 'kg');
      expect(byId['u1']!.code, 'UNI-001');
      expect(byId['u2']!.abbreviation, 'crate');
      expect(byId['u2']!.code, 'UNI-002');
      expect(byId['u3']!.abbreviation, 'ton');
      expect(byId['u3']!.code, 'UNI-003');
      expect(byId['u3']!.kilogramsEquivalent, 1000.0);
    });

    test('crea los índices únicos que faltaban en la base migrada', () async {
      final rows = await db
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'index' AND name IN "
            "('idx_farmers_code','idx_grape_varieties_code',"
            "'idx_harvest_seasons_code','idx_measurement_units_abbreviation')",
          )
          .get();
      expect(rows.length, 4);
    });

    test('el índice único rechaza un código repetido', () async {
      await expectLater(
        db.customStatement(
          "INSERT INTO farmers (id, code, first_name, last_name, created_at, "
          "updated_at) VALUES ('f9','AGR-001','Otro','Apellido',9,9)",
        ),
        throwsA(isA<Exception>()),
      );
    });
  });

  /// Migración v3 → v4 con datos reales.
  ///
  /// El esquema v3 se escribe a mano con el índice **no** único sobre
  /// `vertex_photos.vertex_id` y se marca con `PRAGMA user_version = 3`. Al
  /// abrir, Drift dispara `onUpgrade(3, 4)`: depura los duplicados históricos y
  /// recién después reemplaza el índice por uno único.
  group('Migración v3 → v4', () {
    late AppDatabase db;

    setUp(() async {
      db = AppDatabase(
        NativeDatabase.memory(setup: (raw) {
          raw.execute('''
            CREATE TABLE parcels (
              id TEXT NOT NULL PRIMARY KEY,
              code TEXT NOT NULL,
              name TEXT,
              declared_area_m2 REAL,
              calculated_area_m2 REAL,
              status TEXT NOT NULL,
              image_path TEXT,
              notes TEXT,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          raw.execute('''
            CREATE TABLE parcel_vertices (
              id TEXT NOT NULL PRIMARY KEY,
              parcel_id TEXT NOT NULL REFERENCES parcels (id) ON DELETE CASCADE,
              sequence_number INTEGER NOT NULL,
              latitude REAL NOT NULL,
              longitude REAL NOT NULL,
              accuracy_m REAL,
              capture_method TEXT NOT NULL,
              captured_at INTEGER,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            )
          ''');
          raw.execute('''
            CREATE TABLE vertex_photos (
              id TEXT NOT NULL PRIMARY KEY,
              vertex_id TEXT NOT NULL
                REFERENCES parcel_vertices (id) ON DELETE CASCADE,
              relative_path TEXT NOT NULL,
              file_name TEXT NOT NULL,
              description TEXT,
              created_at INTEGER NOT NULL
            )
          ''');
          // En v3 el índice no era único; la migración debe reemplazarlo.
          raw.execute(
            'CREATE INDEX idx_vertex_photos_vertex ON vertex_photos (vertex_id)',
          );

          raw.execute(
            "INSERT INTO parcels VALUES ('pa1','PAR-001',NULL,NULL,NULL,"
            "'active',NULL,NULL,1,1)",
          );
          raw.execute(
            "INSERT INTO parcel_vertices VALUES ('v1','pa1',0,-34.0,-58.0,NULL,"
            "'gps',NULL,1,1)",
          );
          raw.execute(
            "INSERT INTO parcel_vertices VALUES ('v2','pa1',1,-34.1,-58.1,NULL,"
            "'gps',NULL,2,2)",
          );

          // v1 acumuló tres fotos: la más antigua es la que la interfaz ya
          // mostraba (`findByVertex` ordena por `created_at` ASC).
          raw.execute(
            "INSERT INTO vertex_photos VALUES ('p1','v1','photos/a.png',"
            "'a.png',NULL,10)",
          );
          raw.execute(
            "INSERT INTO vertex_photos VALUES ('p2','v1','photos/b.png',"
            "'b.png',NULL,20)",
          );
          raw.execute(
            "INSERT INTO vertex_photos VALUES ('p3','v1','photos/c.png',"
            "'c.png',NULL,30)",
          );
          raw.execute(
            "INSERT INTO vertex_photos VALUES ('p4','v2','photos/d.png',"
            "'d.png',NULL,5)",
          );

          raw.execute('PRAGMA user_version = 3');
        }),
      );
      // La primera consulta dispara la apertura y, con ella, la migración.
      await db.customSelect('SELECT 1').get();
    });

    tearDown(() async {
      await db.close();
    });

    test('sube la versión del esquema a 4', () async {
      final row = await db.customSelect('PRAGMA user_version').getSingle();
      expect(row.read<int>('user_version'), 4);
    });

    test('deja una sola foto por vértice y conserva la más antigua', () async {
      final rows = await db
          .customSelect('SELECT id, vertex_id FROM vertex_photos')
          .get();
      expect(
        {
          for (final row in rows)
            row.read<String>('vertex_id'): row.read<String>('id'),
        },
        {'v1': 'p1', 'v2': 'p4'},
      );
    });

    test('reemplaza el índice por uno único', () async {
      final row = await db
          .customSelect(
            "SELECT sql FROM sqlite_master WHERE type = 'index' "
            "AND name = 'idx_vertex_photos_vertex'",
          )
          .getSingle();
      expect(row.read<String>('sql'), contains('UNIQUE'));
    });

    test('el índice único rechaza una segunda foto del mismo vértice',
        () async {
      await expectLater(
        db.customStatement(
          "INSERT INTO vertex_photos VALUES ('p9','v1','photos/z.png',"
          "'z.png',NULL,99)",
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
