import 'package:cashier_app_v2/core/database/app_database.dart' as db;
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/payment_form.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late db.AppDatabase database;
  late int customerId;

  setUp(() async {
    await getIt.reset();
    database = db.AppDatabase.forTesting(NativeDatabase.memory());
    getIt.registerSingleton<db.AppDatabase>(database);
    customerId = await database
        .into(database.customers)
        .insert(
          db.CustomersCompanion.insert(
            name: 'عميل قديم',
            phone: const Value('01012345678'),
            totalDebt: const Value(40),
          ),
        );
  });

  tearDown(() async {
    await getIt.reset();
    await database.close();
  });

  Widget harness({required DeferredPaymentConfirm onConfirm}) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () => PaymentForm.show(
              context,
              methodLabel: 'آجل',
              onConfirm: onConfirm,
            ),
            child: const Text('فتح نموذج الآجل'),
          ),
        ),
      ),
    );
  }

  testWidgets('selects an existing customer and returns its ID', (
    tester,
  ) async {
    int? confirmedId;
    String? confirmedName;
    double? confirmedAmount;

    await tester.pumpWidget(
      harness(
        onConfirm: (id, name, _, amount) {
          confirmedId = id;
          confirmedName = name;
          confirmedAmount = amount;
        },
      ),
    );
    await tester.tap(find.text('فتح نموذج الآجل'));
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<ChoiceChip>(find.widgetWithText(ChoiceChip, 'حساب عميل سابق'))
          .selected,
      isTrue,
    );
    expect(find.textContaining('الرصيد المستحق حاليًا: 40.00'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).last, '7');
    await tester.tap(find.text('تأكيد البيع الآجل'));
    await tester.pumpAndSettle();

    expect(confirmedId, customerId);
    expect(confirmedName, 'عميل قديم');
    expect(confirmedAmount, 7);
  });

  testWidgets('switches to new customer creation and returns its details', (
    tester,
  ) async {
    int? confirmedId = 99;
    String? confirmedName;
    String? confirmedPhone;
    double? confirmedAmount;

    await tester.pumpWidget(
      harness(
        onConfirm: (id, name, phone, amount) {
          confirmedId = id;
          confirmedName = name;
          confirmedPhone = phone;
          confirmedAmount = amount;
        },
      ),
    );
    await tester.tap(find.text('فتح نموذج الآجل'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('إضافة حساب آجل جديد'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    expect(fields, findsNWidgets(3));
    await tester.enterText(fields.at(0), 'عميل جديد');
    await tester.enterText(fields.at(1), '01099887766');
    await tester.enterText(fields.at(2), '12');
    await tester.tap(find.text('تأكيد البيع الآجل'));
    await tester.pumpAndSettle();

    expect(confirmedId, isNull);
    expect(confirmedName, 'عميل جديد');
    expect(confirmedPhone, '01099887766');
    expect(confirmedAmount, 12);
  });
}
