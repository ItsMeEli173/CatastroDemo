import 'dart:convert';
import 'dart:io';

import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/storage/photo_storage.dart';
import 'package:catastrodemo/features/data_export/data/local_export_service.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late Directory tempDir;
  late LocalExportService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    tempDir = Directory.systemTemp.createTempSync('catastro_export_test');
    Future<Directory> directory() async => tempDir;
    service = LocalExportService(
      db.exportDao,
      PhotoStorage(documentsDirectoryProvider: directory),
      documentsDirectoryProvider: directory,
    );
  });

  tearDown(() async {
    await db.close();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  test('el respaldo incluye el código de registro y la abreviatura', () async {
    final now = DateTime.utc(2026, 1, 1);
    await db.into(db.farmers).insert(
          FarmersCompanion.insert(
            id: 'f1',
            firstName: 'Ana',
            lastName: 'Pérez',
            createdAt: now,
            updatedAt: now,
            code: const Value('AGR-007'),
          ),
        );
    await db.into(db.harvestSeasons).insert(
          HarvestSeasonsCompanion.insert(
            id: 's1',
            name: '2026',
            createdAt: now,
            updatedAt: now,
            code: const Value('TEM-001'),
          ),
        );

    final artifact = await service.exportJson();
    final payload = jsonDecode(File(artifact.filePath).readAsStringSync())
        as Map<String, dynamic>;

    expect(payload['schemaVersion'], 2);

    final data = payload['data'] as Map<String, dynamic>;
    expect((data['farmers'] as List).first['code'], 'AGR-007');
    expect((data['harvestSeasons'] as List).first['code'], 'TEM-001');

    final variety = (data['grapeVarieties'] as List).first
        as Map<String, dynamic>;
    expect(variety['code'], isNotNull);

    final unit = (data['measurementUnits'] as List).first
        as Map<String, dynamic>;
    expect(unit['abbreviation'], isNotNull);
  });
}
