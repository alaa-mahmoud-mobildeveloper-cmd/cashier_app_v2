import 'package:cashier_app_v2/core/database/app_database.dart';
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
      Worker(name: 'أحمد', phone: '01000000000', role: 'كاشير', salary: 5000),
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

  test(
    'barcode issue atomically decrements stock and records the item',
    () async {
      final workerId = await repository.addWorker(
        Worker(name: 'مريم', phone: '01111111111', role: 'كاشير', salary: 4200),
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
      Worker(name: 'علي', phone: '01222222222', role: 'كاشير', salary: 4000),
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
