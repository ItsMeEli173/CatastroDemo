import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/di/core_providers.dart';
import 'package:catastrodemo/core/widgets/photo_button.dart';
import 'package:catastrodemo/core/widgets/photo_viewer.dart';
import 'package:catastrodemo/features/parcels/data/drift_parcel_repository.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel.dart';
import 'package:catastrodemo/features/parcels/presentation/parcel_form_page.dart';
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

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    storage = FakePhotoStorage(files: {_photoPath: writeTinyImage()});
    repo = DriftParcelRepository(db.parcelDao, db.parcelVertexDao, storage);
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> seedParcel() => repo.save(
        Parcel(
          id: 'p1',
          code: 'PAR-001',
          status: ParcelStatus.draft,
          imagePath: _photoPath,
          createdAt: DateTime.utc(2026, 1, 1),
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      );

  Future<void> pumpForm(WidgetTester tester) async {
    // El formulario es largo: se agranda la superficie para que la sección de
    // fotografía quede construida (el `ListView` arma a sus hijos por demanda).
    tester.view.physicalSize = const Size(1000, 3200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          photoStorageProvider.overrideWithValue(storage),
        ],
        child: const MaterialApp(home: ParcelFormPage(parcelId: 'p1')),
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

  testWidgets('S2 la foto del formulario abre el visor', (tester) async {
    await tester.runAsync(() => seedParcel());
    await pumpForm(tester);

    expect(find.byType(PhotoButton), findsOneWidget);

    await tester.tap(find.byType(PhotoButton));
    await tester.pumpAndSettle();

    expect(find.byType(PhotoViewer), findsOneWidget);

    await unmount(tester);
  });

  testWidgets('S5 el visor del formulario no ofrece eliminar', (tester) async {
    await tester.runAsync(() => seedParcel());
    await pumpForm(tester);

    await tester.tap(find.byType(PhotoButton));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(PhotoViewer),
        matching: find.byIcon(Icons.delete_outline),
      ),
      findsNothing,
    );
    expect(storage.deleted, isEmpty);

    await unmount(tester);
  });
}
