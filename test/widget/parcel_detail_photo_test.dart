import 'dart:io';

import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/di/core_providers.dart';
import 'package:catastrodemo/core/widgets/photo_button.dart';
import 'package:catastrodemo/core/widgets/photo_viewer.dart';
import 'package:catastrodemo/features/parcels/data/drift_parcel_repository.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel.dart';
import 'package:catastrodemo/features/parcels/presentation/parcel_detail_page.dart';
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
  late DriftParcelRepository repo;
  late File photo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    photo = writeTinyImage();
    storage = FakePhotoStorage(files: {_photoPath: photo});
    repo = DriftParcelRepository(db.parcelDao, db.parcelVertexDao, storage);
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> seed({String? imagePath}) => repo.save(
        Parcel(
          id: 'p1',
          code: 'PAR-001',
          status: ParcelStatus.draft,
          imagePath: imagePath,
          createdAt: DateTime.utc(2026, 1, 1),
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      );

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          photoStorageProvider.overrideWithValue(storage),
        ],
        child: const MaterialApp(home: ParcelDetailPage(parcelId: 'p1')),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Desmonta el árbol y deja correr el temporizador que drift programa al
  /// cerrar sus consultas en vivo. Sin esto, flutter_test falla por
  /// «A Timer is still pending even after the widget tree was disposed».
  Future<void> unmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  }

  testWidgets('S2 una parcela sin foto no muestra el botón', (tester) async {
    await tester.runAsync(() => seed());
    await pumpPage(tester);

    expect(find.byType(PhotoButton), findsNothing);

    await unmount(tester);
  });

  testWidgets('S2 la foto de la parcela abre el visor', (tester) async {
    await tester.runAsync(() => seed(imagePath: _photoPath));
    await pumpPage(tester);

    expect(find.byType(PhotoButton), findsOneWidget);

    await tester.tap(find.byType(PhotoButton));
    await tester.pumpAndSettle();

    expect(find.byType(PhotoViewer), findsOneWidget);

    await unmount(tester);
  });

  testWidgets('S3 eliminar desde el visor borra el archivo y limpia imagePath',
      (tester) async {
    await tester.runAsync(() => seed(imagePath: _photoPath));
    await pumpPage(tester);

    await tester.tap(find.byType(PhotoButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();

    expect(find.byType(PhotoViewer), findsNothing);
    expect(storage.deleted, contains(_photoPath));
    expect(find.byType(PhotoButton), findsNothing);

    final reloaded = await tester.runAsync(() => repo.findById('p1'));
    expect(reloaded!.imagePath, isNull);

    await unmount(tester);
  });
}
