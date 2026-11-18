import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/di/core_providers.dart';
import 'package:catastrodemo/core/widgets/photo_button.dart';
import 'package:catastrodemo/core/widgets/photo_viewer.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel_vertex.dart';
import 'package:catastrodemo/features/vertex_photos/presentation/vertex_photo_dialog.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_photo_storage.dart';
import '../support/tiny_image.dart';

const String _photoPath = 'photos/foto.png';

void main() {
  late AppDatabase db;
  late FakePhotoStorage storage;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    storage = FakePhotoStorage(files: {_photoPath: writeTinyImage()});
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> seedPhoto() async {
    final now = DateTime.utc(2026, 1, 1);
    await db.parcelDao.upsert(
      ParcelsCompanion(
        id: const Value('p1'),
        code: const Value('PAR-001'),
        status: const Value(ParcelStatus.draft),
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
        relativePath: const Value(_photoPath),
        fileName: const Value('foto.png'),
        createdAt: Value(now),
      ),
    );
  }

  Future<void> pumpDialog(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          photoStorageProvider.overrideWithValue(storage),
        ],
        child: const MaterialApp(home: VertexPhotoDialog(vertexId: 'v1')),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Desmonta el árbol y deja correr el temporizador que drift programa al
  /// cerrar sus consultas en vivo.
  Future<void> unmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  }

  testWidgets('S2 la miniatura de la foto del vértice abre el visor',
      (tester) async {
    await tester.runAsync(() => seedPhoto());
    await pumpDialog(tester);

    expect(find.byType(PhotoButton), findsOneWidget);

    await tester.tap(find.byType(PhotoButton));
    await tester.pumpAndSettle();

    expect(find.byType(PhotoViewer), findsOneWidget);

    await unmount(tester);
  });

  testWidgets('S4 eliminar desde el visor borra el archivo y recarga la lista',
      (tester) async {
    await tester.runAsync(() => seedPhoto());
    await pumpDialog(tester);

    await tester.tap(find.byType(PhotoButton));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(PhotoViewer),
        matching: find.byIcon(Icons.delete_outline),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();

    expect(find.byType(PhotoViewer), findsNothing);
    expect(storage.deleted, contains(_photoPath));
    expect(find.text('foto.png'), findsNothing);

    await unmount(tester);
  });

  testWidgets('la papelera de la lista sigue eliminando con su confirmación',
      (tester) async {
    await tester.runAsync(() => seedPhoto());
    await pumpDialog(tester);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();

    expect(storage.deleted, contains(_photoPath));
    expect(find.text('foto.png'), findsNothing);

    await unmount(tester);
  });
}
