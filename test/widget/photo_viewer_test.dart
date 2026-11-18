import 'dart:io';

import 'package:catastrodemo/core/widgets/photo_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// PNG válido de 1x1 para que `Image.file` tenga algo real que abrir.
const List<int> _tinyPng = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
];

/// I/O síncrono a propósito: `testWidgets` corre en una zona de async falso y
/// un `await` de I/O real nunca se completaría.
File _writeImage() {
  final dir = Directory.systemTemp.createTempSync('photo_viewer_test_');
  addTearDown(() {
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  });
  final file = File('${dir.path}${Platform.pathSeparator}tiny.png');
  file.writeAsBytesSync(_tinyPng, flush: true);
  return file;
}

Future<void> _pumpHost(
  WidgetTester tester, {
  required File file,
  String? title,
  Future<void> Function()? onDelete,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => PhotoViewer(
                    file: file,
                    title: title,
                    onDelete: onDelete,
                  ),
                ),
              ),
              child: const Text('abrir visor'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('abrir visor'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('S1 muestra la foto a pantalla completa con zoom y título',
      (tester) async {
    final file = _writeImage();
    await _pumpHost(tester, file: file, title: 'Foto de la parcela');

    expect(find.text('Foto de la parcela'), findsOneWidget);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('S1 sin onDelete el visor es de solo lectura', (tester) async {
    final file = _writeImage();
    await _pumpHost(tester, file: file);

    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNothing);
  });

  testWidgets('S1 con onDelete muestra la acción de borrado', (tester) async {
    final file = _writeImage();
    await _pumpHost(tester, file: file, onDelete: () async {});

    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
  });

  testWidgets('S3/S4 cancelar la confirmación no borra ni cierra',
      (tester) async {
    var deleted = false;
    final file = _writeImage();
    await _pumpHost(
      tester,
      file: file,
      onDelete: () async => deleted = true,
    );

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Eliminar fotografía'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Cancelar'));
    await tester.pumpAndSettle();

    expect(deleted, isFalse);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(find.text('abrir visor'), findsNothing);
  });

  testWidgets('S3/S4 confirmar ejecuta el borrado y cierra el visor',
      (tester) async {
    var deleted = false;
    final file = _writeImage();
    await _pumpHost(
      tester,
      file: file,
      onDelete: () async => deleted = true,
    );

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();

    expect(deleted, isTrue);
    expect(find.byType(InteractiveViewer), findsNothing);
    expect(find.text('abrir visor'), findsOneWidget);
  });

  testWidgets('S3/S4 si el borrado falla el visor queda abierto',
      (tester) async {
    final file = _writeImage();
    await _pumpHost(
      tester,
      file: file,
      onDelete: () async => throw StateError('boom'),
    );

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();

    expect(find.byType(InteractiveViewer), findsOneWidget);
  });
}
