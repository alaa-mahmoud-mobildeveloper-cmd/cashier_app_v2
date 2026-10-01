import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/payment_accounts/presentation/screens/payment_accounts_screen.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    await getIt.reset();
    database = AppDatabase.forTesting(NativeDatabase.memory());
    final userId = await database
        .into(database.users)
        .insert(
          UsersCompanion.insert(
            username: 'wallet_manager',
            passwordHash: 'test-hash',
            fullName: 'مدير المحافظ',
            role: const Value('admin'),
          ),
        );
    final session = InMemorySessionProvider()
      ..startSession(userId, role: 'admin', fullName: 'مدير المحافظ');
    getIt.registerSingleton<AppDatabase>(database);
    getIt.registerSingleton<SessionProvider>(session);
  });

  tearDown(() async {
    await getIt.reset();
    await database.close();
  });

  testWidgets(
    'creates a wallet with current balance, then deposits and withdraws',
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PaymentAccountsScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('إضافة حساب'));
      await tester.pumpAndSettle();
      expect(find.text('الرصيد الموجود حاليًا في المحفظة'), findsOneWidget);

      var fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'محفظة الفرع');
      await tester.enterText(fields.at(3), '120');
      await tester.tap(find.text('حفظ'));
      await tester.pumpAndSettle();

      expect(find.text('120.00 ج'), findsOneWidget);
      await tester.tap(find.text('إيداع'));
      await tester.pumpAndSettle();
      fields = find.byType(TextFormField);
      await tester.enterText(fields.first, '30');
      await tester.enterText(fields.last, 'تغذية الرصيد');
      await tester.tap(find.text('تأكيد الإيداع'));
      await tester.pumpAndSettle();

      expect(find.text('150.00 ج'), findsOneWidget);
      await tester.tap(find.text('سحب'));
      await tester.pumpAndSettle();
      fields = find.byType(TextFormField);
      await tester.enterText(fields.first, '50');
      await tester.enterText(fields.last, 'سحب نقدي');
      await tester.tap(find.text('تأكيد السحب'));
      await tester.pumpAndSettle();

      expect(find.text('100.00 ج'), findsOneWidget);
      expect(
        await database.select(database.paymentAccountTransactions).get(),
        hasLength(3),
      );
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 1));
    },
  );
}
