import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/home/presentation/screens/my_details_screen.dart';
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
            username: 'store_admin',
            passwordHash: 'argon2id-v1:do-not-display-this-secret',
            fullName: 'مدير المتجر',
            phone: const Value('01012345678'),
            role: const Value('admin'),
            isLoggedIn: const Value(true),
            lastLogin: Value(DateTime(2026, 10, 2, 9, 5)),
          ),
        );

    final session = InMemorySessionProvider()
      ..startSession(userId, role: 'admin', fullName: 'مدير المتجر');
    getIt.registerSingleton<AppDatabase>(database);
    getIt.registerSingleton<SessionProvider>(session);
  });

  tearDown(() async {
    await getIt.reset();
    await database.close();
  });

  testWidgets('shows the current admin profile but never the password hash', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: MyDetailsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل حساب الأدمن'), findsOneWidget);
    expect(find.text('مدير المتجر'), findsWidgets);
    expect(find.text('store_admin'), findsOneWidget);
    expect(find.text('01012345678'), findsOneWidget);
    expect(find.text('رقم المستخدم'), findsOneWidget);
    expect(find.text('حالة الجلسة'), findsOneWidget);
    expect(find.text('مسجل الدخول الآن'), findsOneWidget);
    expect(find.text('آخر تسجيل دخول'), findsOneWidget);
    expect(find.text('تاريخ إنشاء الحساب'), findsOneWidget);
    expect(find.textContaining('argon2id-v1:'), findsNothing);
    expect(find.textContaining('do-not-display-this-secret'), findsNothing);
  });
}
