import 'package:cashier_app_v2/core/database/app_database.dart'
    hide WorkerAdvance, WorkerProductIssue;
import 'package:cashier_app_v2/features/workers/domain/entities/worker.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker_advance.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker_details_data.dart';
import 'package:cashier_app_v2/features/workers/domain/entities/worker_product_issue.dart';
import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class WorkerRepository {
  WorkerRepository(this._database);

  final AppDatabase _database;
  static const _uuid = Uuid();

  Stream<List<Worker>> watchWorkers() {
    final query = _database.select(_database.users)
      ..where((user) => user.isWorker.equals(true))
      ..orderBy([
        (user) =>
            OrderingTerm(expression: user.createdAt, mode: OrderingMode.desc),
      ]);

    return query.watch().map((rows) => rows.map(_toWorker).toList());
  }

  Future<int> addWorker(Worker worker) async {
    final token = _uuid.v4();
    // Workers do not receive login credentials from this form. The opaque marker
    // satisfies the existing Users schema without storing a usable password.
    final id = await _database
        .into(_database.users)
        .insert(
          UsersCompanion.insert(
            username: 'worker_${token.replaceAll('-', '')}',
            passwordHash: 'WORKER_LOGIN_DISABLED:$token',
            fullName: worker.name.trim(),
            phone: Value(worker.phone.trim()),
            jobTitle: Value(worker.role.trim()),
            salary: Value(worker.salary),
            isWorker: const Value(true),
            isActive: Value(worker.status == WorkerStatus.active),
          ),
        );

    final barcode = worker.barcode?.trim().isNotEmpty == true
        ? worker.barcode!.trim()
        : 'W${id.toString().padLeft(6, '0')}';
    await (_database.update(_database.users)
          ..where((user) => user.id.equals(id)))
        .write(UsersCompanion(barcode: Value(barcode)));
    return id;
  }

  Future<void> setWorkerActive(int workerId, bool isActive) async {
    await (_database.update(_database.users)..where(
          (user) => user.id.equals(workerId) & user.isWorker.equals(true),
        ))
        .write(UsersCompanion(isActive: Value(isActive)));
  }

  /// Hides the worker from this screen but keeps the user and ledger history.
  Future<void> archiveWorker(int workerId) async {
    await (_database.update(_database.users)..where(
          (user) => user.id.equals(workerId) & user.isWorker.equals(true),
        ))
        .write(
          const UsersCompanion(isWorker: Value(false), isActive: Value(false)),
        );
  }

  Stream<WorkerDetailsData> watchWorkerDetails(int workerId) {
    return Rx.combineLatest2<
      List<WorkerAdvance>,
      List<WorkerProductIssue>,
      WorkerDetailsData
    >(
      watchAdvances(workerId),
      watchProductIssues(workerId),
      (advances, products) =>
          WorkerDetailsData(advances: advances, products: products),
    );
  }

  Stream<List<WorkerAdvance>> watchAdvances(int workerId) {
    final query = _database.select(_database.workerAdvances)
      ..where((advance) => advance.workerId.equals(workerId))
      ..orderBy([
        (advance) => OrderingTerm(
          expression: advance.createdAt,
          mode: OrderingMode.desc,
        ),
      ]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => WorkerAdvance(
              id: row.id,
              workerId: row.workerId,
              amount: row.amount,
              reason: row.reason,
              createdAt: row.createdAt,
            ),
          )
          .toList(),
    );
  }

  Stream<List<WorkerProductIssue>> watchProductIssues(int workerId) {
    final query = _database.select(_database.workerProductIssues)
      ..where((issue) => issue.workerId.equals(workerId))
      ..orderBy([
        (issue) =>
            OrderingTerm(expression: issue.createdAt, mode: OrderingMode.desc),
      ]);

    return query.watch().map(
      (rows) => rows
          .map(
            (row) => WorkerProductIssue(
              id: row.id,
              workerId: row.workerId,
              productId: row.productId,
              productName: row.productName,
              barcode: row.barcode,
              quantity: row.quantity,
              unitPrice: row.unitPrice,
              createdAt: row.createdAt,
            ),
          )
          .toList(),
    );
  }

  Future<void> addAdvance({
    required int workerId,
    required double amount,
    String? reason,
  }) async {
    if (amount <= 0) {
      throw ArgumentError.value(
        amount,
        'amount',
        'يجب أن يكون المبلغ أكبر من صفر',
      );
    }

    final worker =
        await (_database.select(_database.users)..where(
              (user) => user.id.equals(workerId) & user.isWorker.equals(true),
            ))
            .getSingleOrNull();
    if (worker == null) throw StateError('العامل غير موجود');

    await _database
        .into(_database.workerAdvances)
        .insert(
          WorkerAdvancesCompanion.insert(
            workerId: workerId,
            amount: amount,
            reason: Value(
              reason?.trim().isEmpty == true ? null : reason?.trim(),
            ),
          ),
        );
  }

  /// Scanning one barcode issues one unit and decrements stock in one transaction.
  Future<String> issueProductByBarcode({
    required int workerId,
    required String barcode,
  }) async {
    final normalizedBarcode = barcode.trim();
    if (normalizedBarcode.isEmpty) throw StateError('امسح باركود المنتج أولاً');

    return _database.transaction(() async {
      final worker =
          await (_database.select(_database.users)..where(
                (user) => user.id.equals(workerId) & user.isWorker.equals(true),
              ))
              .getSingleOrNull();
      if (worker == null) throw StateError('العامل غير موجود');

      final product =
          await (_database.select(_database.products)
                ..where((item) => item.barcode.equals(normalizedBarcode)))
              .getSingleOrNull();
      if (product == null || !product.isActive) {
        throw StateError('المنتج غير موجود أو غير متاح');
      }
      if (product.stockQuantity <= 0) {
        throw StateError('المنتج غير متوفر في المخزون');
      }

      await (_database.update(
        _database.products,
      )..where((item) => item.id.equals(product.id))).write(
        ProductsCompanion(
          stockQuantity: Value(product.stockQuantity - 1),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await _database
          .into(_database.workerProductIssues)
          .insert(
            WorkerProductIssuesCompanion.insert(
              workerId: workerId,
              productId: product.id,
              productName: product.name,
              barcode: product.barcode,
              quantity: const Value(1),
              unitPrice: product.price,
            ),
          );

      return product.name;
    });
  }

  Worker _toWorker(User row) => Worker(
    id: row.id,
    name: row.fullName,
    phone: row.phone ?? '',
    role: row.jobTitle.isEmpty ? row.role : row.jobTitle,
    salary: row.salary,
    barcode: row.barcode,
    status: row.isActive ? WorkerStatus.active : WorkerStatus.inactive,
  );
}
