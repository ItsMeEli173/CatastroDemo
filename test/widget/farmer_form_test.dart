import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/di/core_providers.dart';
import 'package:catastrodemo/features/farmers/presentation/farmer_form_page.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('lista el código de solo lectura y deja editar el documento',
      (tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: FarmerFormPage()),
      ),
    );
    await tester.pumpAndSettle();

    final codeField = tester.widget<TextField>(
      find.ancestor(of: find.text('Código'), matching: find.byType(TextField)),
    );
    expect(codeField.readOnly, isTrue);
    expect(codeField.controller!.text, 'AGR-001');

    final documentField = tester.widget<TextField>(
      find.ancestor(
        of: find.text('Documento'),
        matching: find.byType(TextField),
      ),
    );
    expect(documentField.readOnly, isFalse);

    await db.close();
  });
}
