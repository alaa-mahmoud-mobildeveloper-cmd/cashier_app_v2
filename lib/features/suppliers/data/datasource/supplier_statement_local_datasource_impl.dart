import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction_ui.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';

import '../../domain/entities/supplier_transaction.dart';
import 'supplier_statement_local_datasource.dart';

@LazySingleton(as: SupplierStatementLocalDataSource)
class SupplierStatementLocalDataSourceImpl
    implements SupplierStatementLocalDataSource {
  final AppDatabase database;

  SupplierStatementLocalDataSourceImpl(this.database);

  @override
  Stream<List<SupplierTransaction>> watchSupplierStatement(
      int supplierId,
      ) {
    final query = database.select(database.purchases)
      ..where((purchase) => purchase.supplierId.equals(supplierId))
      ..orderBy([
            (purchase) => OrderingTerm(
          expression: purchase.createdAt,
          mode: OrderingMode.desc,
        ),
      ]);

    return query.watch().asyncMap((purchases) async {
      final result = <SupplierTransaction>[];

      for (final purchase in purchases) {
        final payments = await (database.select(database.purchasePayments)
          ..where(
                (payment) => payment.purchaseId.equals(purchase.id),
          ))
            .get();

        final collectedAmount = payments.fold<double>(
          0,
              (sum, payment) => sum + payment.amount,
        );

        result.add(
          SupplierTransaction(
            purchaseId: purchase.id,
            invoiceNumber: purchase.invoiceNumber,
            date: purchase.createdAt,
            totalAmount: purchase.netTotal,
            collectedAmount: collectedAmount,
            paymentMethod: purchase.paymentMethod,
            dueDate: purchase.dueDate,
          ),
        );
      }

      return result;
    });
  }

  @override
  Future<void> collectPayment({
    required int purchaseId,
    required double amount,
    required String paymentMethod,
    String? note,
  }) async {
    if (amount <= 0) {
      throw Exception('قيمة التحصيل يجب أن تكون أكبر من صفر');
    }

    final purchase = await (database.select(database.purchases)
      ..where((purchase) => purchase.id.equals(purchaseId)))
        .getSingleOrNull();

    if (purchase == null) {
      throw Exception('الفاتورة غير موجودة');
    }

    final payments = await (database.select(database.purchasePayments)
      ..where((payment) => payment.purchaseId.equals(purchaseId)))
        .get();

    final collectedAmount = payments.fold<double>(
      0,
          (sum, payment) => sum + payment.amount,
    );

    final remaining = purchase.netTotal - collectedAmount;

    if (remaining <= 0.01) {
      throw Exception('الفاتورة مدفوعة بالكامل');
    }

    if (amount > remaining + 0.01) {
      throw Exception(
        'قيمة التحصيل أكبر من المتبقي: ${remaining.toStringAsFixed(2)}',
      );
    }

    await database.into(database.purchasePayments).insert(
      PurchasePaymentsCompanion.insert(
        purchaseId: purchaseId,
        amount: amount,
        paymentMethod: Value(paymentMethod),
        note: Value(note?.trim().isEmpty == true ? null : note?.trim()),
      ),
    );
  }
}