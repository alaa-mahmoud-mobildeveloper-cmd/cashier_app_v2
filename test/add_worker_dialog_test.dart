import 'package:cashier_app_v2/features/workers/presentation/widgets/add_worker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows login fields only for cashier workers', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => const AddWorkerDialog(),
              ),
              child: const Text('افتح نموذج العامل'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('افتح نموذج العامل'));
    await tester.pumpAndSettle();
    expect(find.text('بيانات دخول الكاشير'), findsNothing);

    final roleDropdown = find.byType(DropdownButtonFormField<String>);
    await tester.tap(roleDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('كاشير').last);
    await tester.pumpAndSettle();

    expect(find.text('بيانات دخول الكاشير'), findsOneWidget);
    expect(find.text('اسم المستخدم'), findsOneWidget);
    expect(find.text('تأكيد كلمة المرور'), findsOneWidget);

    await tester.tap(roleDropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('عامل').last);
    await tester.pumpAndSettle();

    expect(find.text('بيانات دخول الكاشير'), findsNothing);
  });
}
