import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/di/core_providers.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel_vertex.dart';
import 'package:catastrodemo/features/parcels/presentation/parcel_vertices_page.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> seed() async {
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
    // sequenceNumber 0: vértice manual; sequenceNumber 1: vértice GPS.
    await db.parcelVertexDao.upsert(
      ParcelVerticesCompanion(
        id: const Value('v-manual'),
        parcelId: const Value('p1'),
        sequenceNumber: const Value(0),
        latitude: const Value(-33.0),
        longitude: const Value(-68.0),
        captureMethod: const Value(VertexCaptureMethod.manual),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    await db.parcelVertexDao.upsert(
      ParcelVerticesCompanion(
        id: const Value('v-gps'),
        parcelId: const Value('p1'),
        sequenceNumber: const Value(1),
        latitude: const Value(-33.1),
        longitude: const Value(-68.1),
        accuracyM: const Value(4.0),
        captureMethod: const Value(VertexCaptureMethod.gps),
        capturedAt: Value(now),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: ParcelVerticesPage(parcelId: 'p1')),
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

  Finder field(String label) =>
      find.ancestor(of: find.text(label), matching: find.byType(TextField));

  String fieldText(WidgetTester tester, String label) {
    final widget = tester.widget<TextField>(field(label));
    return widget.controller!.text;
  }

  /// Abre el menú de acciones del vértice [index] (orden de la lista).
  Future<void> openMenu(WidgetTester tester, int index) async {
    await tester.tap(find.byType(PopupMenuButton<String>).at(index));
    await tester.pumpAndSettle();
  }

  testWidgets('S6 un vértice manual ofrece editar sus coordenadas',
      (tester) async {
    await tester.runAsync(() => seed());
    await pumpPage(tester);

    await openMenu(tester, 0);
    expect(find.text('Editar coordenadas'), findsOneWidget);

    await tester.tap(find.text('Editar coordenadas'));
    await tester.pumpAndSettle();

    expect(find.text('Editar vértice manual'), findsOneWidget);
    expect(fieldText(tester, 'Latitud'), '-33.000000');
    expect(fieldText(tester, 'Longitud'), '-68.000000');

    await tester.enterText(field('Latitud'), '-16.5');
    await tester.enterText(field('Longitud'), '-68.15');
    await tester.tap(find.widgetWithText(FilledButton, 'Guardar'));
    await tester.pumpAndSettle();

    expect(find.text('-16.500000, -68.150000'), findsOneWidget);
    expect(find.text('Guardar geometría'), findsOneWidget);

    await unmount(tester);
  });

  testWidgets('S7 un vértice GPS no ofrece editar coordenadas', (tester) async {
    await tester.runAsync(() => seed());
    await pumpPage(tester);

    await openMenu(tester, 1);
    expect(find.text('Editar coordenadas'), findsNothing);
    expect(find.text('Mover arriba'), findsOneWidget);

    await unmount(tester);
  });

  testWidgets('S6 cancelar la edición deja el punto sin cambios',
      (tester) async {
    await tester.runAsync(() => seed());
    await pumpPage(tester);

    await openMenu(tester, 0);
    await tester.tap(find.text('Editar coordenadas'));
    await tester.pumpAndSettle();

    await tester.enterText(field('Latitud'), '10.0');
    await tester.tap(find.widgetWithText(TextButton, 'Cancelar'));
    await tester.pumpAndSettle();

    expect(find.text('-33.000000, -68.000000'), findsOneWidget);
    expect(find.text('Guardar geometría'), findsNothing);

    await unmount(tester);
  });
}
