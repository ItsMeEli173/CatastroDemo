import 'dart:io';

import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/storage/photo_storage.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel_vertex.dart';
import 'package:catastrodemo/features/vertex_photos/data/drift_vertex_photo_repository.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late Directory tempDir;
  late PhotoStorage storage;
  late DriftVertexPhotoRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    tempDir = Directory.systemTemp.createTempSync('catastro_orphans_');
    storage = PhotoStorage(documentsDirectoryProvider: () async => tempDir);
    repo = DriftVertexPhotoRepository(db.vertexPhotoDao, storage, db.parcelDao);
  });

  tearDown(() async {
    await db.close();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  Future<File> writePhoto(String name) async {
    final dir = Directory('${tempDir.path}${Platform.pathSeparator}photos');
    await dir.create(recursive: true);
    final file = File('${dir.path}${Platform.pathSeparator}$name');
    await file.writeAsBytes(const [1, 2, 3]);
    return file;
  }

  test('S10 cleanOrphans conserva las fotos de parcela y de vértice', () async {
    final now = DateTime.utc(2026, 1, 1);
    final parcelPhoto = await writePhoto('parcela.png');
    final vertexPhoto = await writePhoto('vertice.png');
    final orphan = await writePhoto('huerfano.png');

    await db.parcelDao.upsert(
      ParcelsCompanion(
        id: const Value('p1'),
        code: const Value('PAR-001'),
        status: const Value(ParcelStatus.draft),
        imagePath: const Value('photos/parcela.png'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    await db.parcelVertexDao.upsert(
      ParcelVerticesCompanion(
        id: const Value('v1'),
        parcelId: const Value('p1'),
        sequenceNumber: const Value(0),
        latitude: const Value(-33.0),
        longitude: const Value(-68.0),
        captureMethod: const Value(VertexCaptureMethod.manual),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    await db.vertexPhotoDao.insert(
      VertexPhotosCompanion(
        id: const Value('f1'),
        vertexId: const Value('v1'),
        relativePath: const Value('photos/vertice.png'),
        fileName: const Value('vertice.png'),
        createdAt: Value(now),
      ),
    );

    final removed = await repo.cleanOrphans();

    expect(removed, 1);
    expect(parcelPhoto.existsSync(), isTrue);
    expect(vertexPhoto.existsSync(), isTrue);
    expect(orphan.existsSync(), isFalse);
  });
}
