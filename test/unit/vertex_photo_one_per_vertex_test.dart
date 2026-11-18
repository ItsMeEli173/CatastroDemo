import 'dart:io';

import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/storage/photo_storage.dart';
import 'package:catastrodemo/features/vertex_photos/data/drift_vertex_photo_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/tiny_image.dart';

const String _parcelId = 'pa1';
const String _vertexId = 'v1';

/// Inserta una fotografía con SQL crudo.
///
/// El DAO usa `insertOnConflictUpdate` (INSERT OR REPLACE), que con el índice
/// único reemplazaría la fila en vez de fallar; para probar la restricción hay
/// que insertar directamente.
Future<void> _insertPhoto(
  AppDatabase db, {
  required String id,
  required String vertexId,
}) {
  return db.customStatement(
    "INSERT INTO vertex_photos (id, vertex_id, relative_path, file_name, "
    "description, created_at) VALUES ('$id','$vertexId','photos/$id.png',"
    "'$id.png',NULL,1)",
  );
}

Future<void> _seedParcelWithVertex(AppDatabase db) async {
  await db.customStatement(
    "INSERT INTO parcels (id, code, name, declared_area_m2, "
    "calculated_area_m2, status, image_path, notes, created_at, updated_at) "
    "VALUES ('$_parcelId','PAR-001',NULL,NULL,NULL,'active',NULL,NULL,1,1)",
  );
  await db.customStatement(
    "INSERT INTO parcel_vertices (id, parcel_id, sequence_number, latitude, "
    "longitude, accuracy_m, capture_method, captured_at, created_at, "
    "updated_at) VALUES ('$_vertexId','$_parcelId',0,-34.0,-58.0,NULL,'gps',"
    'NULL,1,1)',
  );
}

void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    // La primera consulta dispara la apertura (creación del esquema).
    await db.customSelect('SELECT 1').get();
    await _seedParcelWithVertex(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Una foto por vértice (esquema)', () {
    test('una base nueva rechaza una segunda foto del mismo vértice',
        () async {
      await _insertPhoto(db, id: 'f1', vertexId: _vertexId);

      await expectLater(
        _insertPhoto(db, id: 'f2', vertexId: _vertexId),
        throwsA(isA<Exception>()),
      );
      expect(await db.vertexPhotoDao.countByVertex(_vertexId), 1);
    });
  });

  group('addFromFile reemplaza la foto anterior', () {
    late Directory tempDir;
    late PhotoStorage storage;
    late DriftVertexPhotoRepository repo;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('catastro_one_photo_');
      storage = PhotoStorage(documentsDirectoryProvider: () async => tempDir);
      repo =
          DriftVertexPhotoRepository(db.vertexPhotoDao, storage, db.parcelDao);
    });

    tearDown(() {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    });

    test('la segunda foto sustituye a la primera y borra su archivo',
        () async {
      final source = writeTinyImage();

      final first = await repo.addFromFile(
        vertexId: _vertexId,
        sourcePath: source.path,
      );
      expect(await storage.exists(first.relativePath), isTrue);

      final second = await repo.addFromFile(
        vertexId: _vertexId,
        sourcePath: source.path,
      );

      expect(await db.vertexPhotoDao.countByVertex(_vertexId), 1);
      final current = await repo.findByVertex(_vertexId);
      expect(current.single.id, second.id);
      expect(await storage.exists(second.relativePath), isTrue);
      expect(await storage.exists(first.relativePath), isFalse);
    });
  });
}
