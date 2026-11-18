import 'package:catastrodemo/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Invariantes que las sondas de verificación de la feature 19 probaron.
///
/// Complementan los tests de comportamiento con los dos casos que las sondas
/// ejercitaron sobre el candidato: el desempate determinista de la
/// deduplicación y que un insert rechazado no altera la fila existente.
void main() {
  test('S2: desempate por id con created_at igual es determinista', () async {
    final db = AppDatabase(
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
        // Las dos fotos de v1 comparten `created_at`; debe sobrevivir la de
        // menor `id` ('pa'), sin importar el orden de inserción.
        raw.execute(
          "INSERT INTO vertex_photos VALUES ('pb','v1','photos/b.png',"
          "'b.png',NULL,100)",
        );
        raw.execute(
          "INSERT INTO vertex_photos VALUES ('pa','v1','photos/a.png',"
          "'a.png',NULL,100)",
        );
        raw.execute(
          "INSERT INTO vertex_photos VALUES ('pz','v2','photos/z.png',"
          "'z.png',NULL,100)",
        );
        raw.execute('PRAGMA user_version = 3');
      }),
    );
    await db.customSelect('SELECT 1').get();

    final rows =
        await db.customSelect('SELECT id, vertex_id FROM vertex_photos').get();
    expect(
      {
        for (final row in rows)
          row.read<String>('vertex_id'): row.read<String>('id'),
      },
      {'v1': 'pa', 'v2': 'pz'},
    );

    await db.close();
  });

  test('S1: un insert rechazado no altera la fila existente', () async {
    final db = AppDatabase(NativeDatabase.memory());
    await db.customSelect('SELECT 1').get();
    await db.customStatement(
      "INSERT INTO parcels (id, code, status, created_at, updated_at) "
      "VALUES ('pa1','PAR-001','active',1,1)",
    );
    await db.customStatement(
      "INSERT INTO parcel_vertices (id, parcel_id, sequence_number, latitude, "
      "longitude, capture_method, created_at, updated_at) "
      "VALUES ('v1','pa1',0,-34.0,-58.0,'gps',1,1)",
    );
    await db.customStatement(
      "INSERT INTO vertex_photos VALUES ('f1','v1','photos/f1.png',"
      "'f1.png',NULL,1)",
    );

    await expectLater(
      db.customStatement(
        "INSERT INTO vertex_photos VALUES ('f2','v1','photos/f2.png',"
        "'f2.png',NULL,2)",
      ),
      throwsA(isA<Exception>()),
    );

    final row = await db
        .customSelect(
          "SELECT id, relative_path FROM vertex_photos WHERE vertex_id='v1'",
        )
        .getSingle();
    expect(row.read<String>('id'), 'f1');
    expect(row.read<String>('relative_path'), 'photos/f1.png');

    await db.close();
  });
}
