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

  testWidgets('offers deposit and withdrawal on every wallet account', (
    tester,
  ) async {
    await database
        .into(database.paymentAccounts)
        .insert(
          PaymentAccountsCompanion.insert(type: 'wallet', name: 'محفظة أولى'),
        );
    await database
        .into(database.paymentAccounts)
        .insert(
          PaymentAccountsCompanion.insert(type: 'wallet', name: 'محفظة ثانية'),
        );

    await tester.pumpWidget(const MaterialApp(home: PaymentAccountsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('إيداع'), findsNWidgets(2));
    expect(find.text('سحب'), findsNWidgets(2));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });

  testWidgets('adds a Fawry merchant account from the account-type dropdown', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PaymentAccountsScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('إضافة حساب'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('فوري').last);
    await tester.pumpAndSettle();

    expect(find.text('الرصيد الموجود حاليًا في المحفظة'), findsNothing);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'حساب فوري الفرع');
    await tester.enterText(fields.at(1), 'فوري');
    await tester.enterText(fields.at(2), '1234567890123');
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();

    final account = await database.select(database.paymentAccounts).getSingle();
    expect(account.type, 'fawry');
    expect(account.reference, '1234567890123');
    expect(find.textContaining('فوري'), findsWidgets);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
