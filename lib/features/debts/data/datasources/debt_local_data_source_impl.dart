import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'debt_local_data_source.dart';

@Injectable(as: DebtLocalDataSource)
class DebtLocalDataSourceImpl implements DebtLocalDataSource {
  final AppDatabase _db;

  DebtLocalDataSourceImpl(this._db);

  @override
  Stream<List<DebtInvoice>> watchDebts() {
    final query = _db.select(_db.invoices).join([
      leftOuterJoin(
        _db.customers,
        _db.customers.id.equalsExp(
          _db.invoices.customerId,
        ),
      ),
    ]);

    query.orderBy([
      OrderingTerm(
        expression: _db.invoices.createdAt,
        mode: OrderingMode.desc,
      ),
    ]);

    return query.watch().map<List<DebtInvoice>>(
          (List<TypedResult> rows) {
        return rows.map<DebtInvoice>(_mapRow).toList();
      },
    );
  }

  @override
  Future<List<DebtInvoice>> getDebts() async {
    final query = _db.select(_db.invoices).join([
      leftOuterJoin(
        _db.customers,
        _db.customers.id.equalsExp(
          _db.invoices.customerId,
        ),
      ),
    ]);

    query.orderBy([
      OrderingTerm(
        expression: _db.invoices.createdAt,
        mode: OrderingMode.desc,
      ),
    ]);

    final List<TypedResult> rows = await query.get();

    return rows.map<DebtInvoice>(_mapRow).toList();
  }

  DebtInvoice _mapRow(TypedResult row) {
    final invoice = row.readTable(_db.invoices);
    final customer = row.readTableOrNull(_db.customers);

    final total = invoice.netAmount;
    final paid = invoice.paidAmount;

    final calculatedRemaining = total - paid;

    final remaining = calculatedRemaining <= 0.01
        ? 0.0
        : calculatedRemaining;

    return DebtInvoice(
      id: invoice.id,
      invoiceNumber: invoice.invoiceNumber,
      customerName: customer?.name ?? 'بيع سريع',
      phone: customer?.phone ?? '',
      date: invoice.createdAt,
      total: total,
      paid: paid,
      paymentMethod: invoice.paymentMethod,
      status: _resolveStatus(
        paymentMethod: invoice.paymentMethod,
        paid: paid,
        remaining: remaining,
      ),
    );
  }

  DebtStatus _resolveStatus({
    required String paymentMethod,
    required double paid,
    required double remaining,
  }) {
    if (paymentMethod == 'cash') {
      return DebtStatus.paid;
    }

    if (remaining <= 0.01) {
      return DebtStatus.paid;
    }

    if (paid > 0.01) {
      return DebtStatus.partial;
    }

    return DebtStatus.unpaid;
  }

  @override
  Future<void> payDebt({
    required int invoiceId,
    required double amount,
  }) async {
    if (amount <= 0) {
      throw ArgumentError(
        'مبلغ التحصيل يجب أن يكون أكبر من صفر',
      );
    }

    await _db.transaction(() async {
      final invoice = await (
          _db.select(_db.invoices)
            ..where(
                  (tbl) => tbl.id.equals(invoiceId),
            )
      ).getSingleOrNull();

      if (invoice == null) {
        throw Exception('الفاتورة غير موجودة');
      }

      if (invoice.paymentMethod != 'credit') {
        throw Exception('هذه الفاتورة ليست آجل');
      }

      final total = invoice.netAmount;
      final currentPaid = invoice.paidAmount;

      final currentRemainingValue =
          total - currentPaid;

      final currentRemaining =
      currentRemainingValue <= 0.01
          ? 0.0
          : currentRemainingValue;

      if (currentRemaining <= 0.01) {
        throw Exception('الفاتورة محصلة بالكامل');
      }

      if (amount > currentRemaining + 0.01) {
        throw Exception(
          'مبلغ التحصيل أكبر من المبلغ المتبقي',
        );
      }

      final newPaid = currentPaid + amount;

      final newRemainingValue =
          total - newPaid;

      final newRemaining =
      newRemainingValue.abs() <= 0.01
          ? 0.0
          : newRemainingValue;

      final String newStatus;

      if (newRemaining <= 0.01) {
        newStatus = 'paid';
      } else if (newPaid > 0.01) {
        newStatus = 'partial';
      } else {
        newStatus = 'unpaid';
      }

      await (
          _db.update(_db.invoices)
            ..where(
                  (tbl) => tbl.id.equals(invoiceId),
            )
      ).write(
        InvoicesCompanion(
          paidAmount: Value(newPaid),
          remainingAmount: Value(newRemaining),
          status: Value(newStatus),
        ),
      );

      if (invoice.customerId != null) {
        final customer = await (
            _db.select(_db.customers)
              ..where(
                    (tbl) => tbl.id.equals(invoice.customerId!),
              )
        ).getSingleOrNull();

        if (customer != null) {
          final newCustomerDebt =
          (customer.totalDebt - amount)
              .clamp(0.0, double.infinity)
              .toDouble();

          await (
              _db.update(_db.customers)
                ..where(
                      (tbl) => tbl.id.equals(customer.id),
                )
          ).write(
            CustomersCompanion(
              totalDebt: Value(newCustomerDebt),
            ),
          );
        }
      }
    });
  }
}