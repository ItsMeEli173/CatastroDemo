import 'package:catastrodemo/features/parcels/presentation/widgets/manual_vertex_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Abre el diálogo y deja los resultados capturados en [captured].
Future<void> _pumpHost(
  WidgetTester tester,
  List<Map<String, double>?> captured, {
  double? initialLatitude,
  double? initialLongitude,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                captured.add(
                  await showDialog<Map<String, double>>(
                    context: context,
                    builder: (_) => ManualVertexDialog(
                      initialLatitude: initialLatitude,
                      initialLongitude: initialLongitude,
                    ),
                  ),
                );
              },
              child: const Text('abrir diálogo'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('abrir diálogo'));
  await tester.pumpAndSettle();
}

String _fieldText(WidgetTester tester, String label) {
  final field = tester.widget<TextField>(
    find.ancestor(of: find.text(label), matching: find.byType(TextField)),
  );
  return field.controller!.text;
}

Finder _field(String label) =>
    find.ancestor(of: find.text(label), matching: find.byType(TextField));

void main() {
  testWidgets('S6 sin valores iniciales es un alta', (tester) async {
    await _pumpHost(tester, <Map<String, double>?>[]);

    expect(find.text('Vértice manual'), findsOneWidget);
    expect(_fieldText(tester, 'Latitud'), isEmpty);
    expect(_fieldText(tester, 'Longitud'), isEmpty);
    expect(find.widgetWithText(FilledButton, 'Agregar'), findsOneWidget);
  });

  testWidgets('S6 precarga las coordenadas y guarda los valores editados',
      (tester) async {
    final captured = <Map<String, double>?>[];
    await _pumpHost(
      tester,
      captured,
      initialLatitude: -17.7833,
      initialLongitude: -63.1821,
    );

    expect(find.text('Editar vértice manual'), findsOneWidget);
    expect(_fieldText(tester, 'Latitud'), '-17.783300');
    expect(_fieldText(tester, 'Longitud'), '-63.182100');

    await tester.enterText(_field('Latitud'), '-16.5');
    await tester.enterText(_field('Longitud'), '-68.15');
    await tester.tap(find.widgetWithText(FilledButton, 'Guardar'));
    await tester.pumpAndSettle();

    expect(captured.single, {'lat': -16.5, 'lon': -68.15});
  });

  testWidgets('S6 valida el rango y no cierra con un valor inválido',
      (tester) async {
    final captured = <Map<String, double>?>[];
    await _pumpHost(
      tester,
      captured,
      initialLatitude: -17.7833,
      initialLongitude: -63.1821,
    );

    await tester.enterText(_field('Latitud'), '200');
    await tester.tap(find.widgetWithText(FilledButton, 'Guardar'));
    await tester.pumpAndSettle();

    expect(find.text('Debe estar entre -90.0 y 90.0.'), findsOneWidget);
    expect(captured, isEmpty);
  });
}
