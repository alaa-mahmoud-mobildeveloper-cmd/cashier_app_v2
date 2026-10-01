import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/auth/data/repositories/auth_repository.dart';
import 'package:cashier_app_v2/features/auth/data/security/password_hasher.dart';
import 'package:cashier_app_v2/features/auth/domain/session_provider.dart';
import 'package:cashier_app_v2/features/workers/data/repositories/worker_repository.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late WorkerRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = WorkerRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('persists workers and advances and provides updated totals', () async {
    final workerId = await repository.addWorker(
      Worker(name: 'أحمد', phone: '01000000000', role: 'عامل', salary: 5000),
    );
    await repository.addAdvance(
      workerId: workerId,
      amount: 250,
      reason: 'سلفة شهرية',
    );

    final workers = await repository.watchWorkers().first;
    final advances = await repository.watchAdvances(workerId).first;
    final details = await repository.watchWorkerDetails(workerId).first;

    expect(workers, hasLength(1));
    expect(workers.single.id, workerId);
    expect(workers.single.barcode, 'W${workerId.toString().padLeft(6, '0')}');
    expect(advances.single.amount, 250);
    expect(advances.single.reason, 'سلفة شهرية');
    expect(details.advancesTotal, 250);
  });

  test('cashier worker receives a hashed login and can sign in', () async {
    const password = 'Cashier-Strong-Password-2026';
    final workerId = await repository.addWorker(
      Worker(name: 'سارة', phone: '01011111111', role: 'كاشير', salary: 4500),
      username: 'CashierTest',
      password: password,
    );

    final saved = await (database.select(
      database.users,
    )..where((row) => row.id.equals(workerId))).getSingle();
    expect(saved.username, 'cashiertest');
    expect(saved.role, 'cashier');
    expect(saved.isWorker, isTrue);
    expect(saved.passwordHash, startsWith('argon2id-v1:'));
    expect(saved.passwordHash, isNot(password));

    final session = InMemorySessionProvider();
    final auth = AuthRepository(database, session, PasswordHasher());
    final user = await auth.signIn(
      username: ' CASHIERTEST ',
      password: password,
    );
    expect(user?.id, workerId);
    expect(user?.role, 'cashier');
    expect(session.currentRole, 'cashier');
    expect((await repository.watchWorkers().first).single.id, workerId);
  });

  test('cashier worker requires valid login credentials', () async {
    await expectLater(
      repository.addWorker(
        Worker(
          name: 'محمود',
          phone: '01022222222',
          role: 'كاشير',
          salary: 4000,
        ),
      ),
      throwsArgumentError,
    );
    expect(await database.select(database.users).get(), isEmpty);
  });

  test(
    'barcode issue atomically decrements stock and records the item',
    () async {
      final workerId = await repository.addWorker(
        Worker(name: 'مريم', phone: '01111111111', role: 'عامل', salary: 4200),
      );
      final productId = await database
          .into(database.products)
          .insert(
            ProductsCompanion.insert(
              name: 'مياه',
              barcode: '622100000001',
              category: 'مشروبات',
              price: 12.5,
              stockQuantity: 2,
            ),
          );

      final name = await repository.issueProductByBarcode(
        workerId: workerId,
        barcode: ' 622100000001 ',
      );
      final product = await (database.select(
        database.products,
      )..where((row) => row.id.equals(productId))).getSingle();
      final issues = await repository.watchProductIssues(workerId).first;
      final details = await repository.watchWorkerDetails(workerId).first;

      expect(name, 'مياه');
      expect(product.stockQuantity, 1);
      expect(issues.single.productId, productId);
      expect(issues.single.quantity, 1);
      expect(details.productsTotal, 12.5);
    },
  );

  test('does not issue an out-of-stock product', () async {
    final workerId = await repository.addWorker(
      Worker(name: 'علي', phone: '01222222222', role: 'عامل', salary: 4000),
    );
    await database
        .into(database.products)
        .insert(
          ProductsCompanion.insert(
            name: 'عصير',
            barcode: '622100000002',
            category: 'مشروبات',
            price: 8,
            stockQuantity: 0,
          ),
        );

    await expectLater(
      repository.issueProductByBarcode(
        workerId: workerId,
        barcode: '622100000002',
      ),
      throwsStateError,
    );
    expect(await repository.watchProductIssues(workerId).first, isEmpty);
  });
}
