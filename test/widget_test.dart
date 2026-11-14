import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:catastrodemo/app.dart';
import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/di/core_providers.dart';

void main() {
  testWidgets('Carga inicial de CatastroDemoApp', (WidgetTester tester) async {
    final memoryDb = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(memoryDb),
        ],
        child: const CatastroDemoApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(CatastroDemoApp), findsOneWidget);

    await memoryDb.close();
  });
}
