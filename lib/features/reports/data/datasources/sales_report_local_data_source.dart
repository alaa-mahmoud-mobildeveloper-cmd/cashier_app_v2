import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/report_cashier.dart';
import '../../domain/entities/sales_invoice.dart';
import '../../domain/entities/sales_report.dart';
import '../../domain/entities/top_product.dart';

abstract class SalesReportLocalDataSource {
  Stream<SalesReport> watchSalesReport({
    required DateTime from,
    required DateTime to,
    String? paymentMethod,
    int? cashierId,
    String? search,
  });

  Stream<List<ReportCashier>> watchCashiers();
}

@LazySingleton(as: SalesReportLocalDataSource)
class SalesReportLocalDataSourceImpl implements SalesReportLocalDataSource {
  final AppDatabase database;

  SalesReportLocalDataSourceImpl(this.database);

  @override
  Stream<SalesReport> watchSalesReport({
    required DateTime from,
    required DateTime to,
    String? paymentMethod,
    int? cashierId,
    String? search,
  }) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day, 23, 59, 59, 999);

    final query = database.select(database.invoices).join([
      leftOuterJoin(
        database.users,
        database.users.id.equalsExp(database.invoices.userId),
      ),
    ]);

    query.where(database.invoices.createdAt.isBiggerOrEqualValue(fromDate));
    query.where(database.invoices.createdAt.isSmallerOrEqualValue(toDate));

    if (paymentMethod != null &&
        paymentMethod.isNotEmpty &&
        paymentMethod != 'الكل') {
      query.where(database.invoices.paymentMethod.equals(paymentMethod));
    }

    if (cashierId != null) {
      query.where(database.invoices.userId.equals(cashierId));
    }

    if (search != null && search.trim().isNotEmpty) {
      final value = search.trim();
      query.where(
        database.invoices.invoiceNumber.like('%$value%') |
        database.users.fullName.like('%$value%'),
      );
    }

    query.orderBy([
      OrderingTerm(
        expression: database.invoices.createdAt,
        mode: OrderingMode.desc,
      ),
    ]);

    return query.watch().asyncMap((rows) async {
      final invoices = <SalesInvoice>[];

      for (final row in rows) {
        final invoice = row.readTable(database.invoices);
        final user = row.readTableOrNull(database.users);
        final itemsCount = await _getInvoiceItemsCount(invoice.id);

        invoices.add(
          SalesInvoice(
            id: invoice.id,
            invoiceNumber: invoice.invoiceNumber,
            cashierId: invoice.userId,
            cashierName: user?.fullName ?? 'غير معروف',
            paymentMethod: invoice.paymentMethod,
            createdAt: invoice.createdAt,
            itemsCount: itemsCount,
            totalAmount: invoice.totalAmount,
            discount: invoice.discount,
            tax: invoice.tax,
            netAmount: invoice.netAmount,
            profit: invoice.profit,
            paidAmount: invoice.paidAmount,
            remainingAmount: invoice.remainingAmount,
            status: invoice.status,
          ),
        );
      }

      final invoiceIds = invoices.map((invoice) => invoice.id).toList();

      final topProducts = invoiceIds.isEmpty
          ? <TopProduct>[]
          : await _getTopProducts(invoiceIds);

      final totalSales = invoices.fold<double>(
        0,
            (sum, invoice) => sum + invoice.netAmount,
      );

      final totalProfit = invoices.fold<double>(
        0,
            (sum, invoice) => sum + invoice.profit,
      );

      return SalesReport(
        invoices: invoices,
        topProducts: topProducts,
        totalSales: totalSales,
        totalProfit: totalProfit,
        invoiceCount: invoices.length,
      );
    });
  }

  Future<int> _getInvoiceItemsCount(int invoiceId) async {
    final query = database.selectOnly(database.invoiceItems)
      ..addColumns([database.invoiceItems.id.count()])
      ..where(database.invoiceItems.invoiceId.equals(invoiceId));

    final row = await query.getSingle();
    return row.read(database.invoiceItems.id.count()) ?? 0;
  }

  Future<List<TopProduct>> _getTopProducts(List<int> invoiceIds) async {
    final query = database.select(database.invoiceItems)
      ..where((item) => item.invoiceId.isIn(invoiceIds));

    final items = await query.get();
    final grouped = <int, _ProductAccumulator>{};

    for (final item in items) {
      final current = grouped[item.productId];

      if (current == null) {
        grouped[item.productId] = _ProductAccumulator(
          productId: item.productId,
          productName: item.productName,
          category: item.category,
          quantity: item.quantity,
          totalSales: item.totalPrice,
          profit: item.profit,
        );
      } else {
        current.quantity += item.quantity;
        current.totalSales += item.totalPrice;
        current.profit += item.profit;
      }
    }

    final result = grouped.values
        .map(
          (item) => TopProduct(
        productId: item.productId,
        productName: item.productName,
        category: item.category,
        quantity: item.quantity,
        totalSales: item.totalSales,
        profit: item.profit,
      ),
    )
        .toList();

    result.sort((a, b) => b.quantity.compareTo(a.quantity));

    return result.take(10).toList();
  }

  @override
  Stream<List<ReportCashier>> watchCashiers() {
    final query = database.select(database.users)
      ..where((user) => user.isActive.equals(true))
      ..orderBy([
            (user) => OrderingTerm(
          expression: user.fullName,
          mode: OrderingMode.asc,
        ),
      ]);

    return query.watch().map((users) {
      return users
          .map(
            (user) => ReportCashier(
          id: user.id,
          name: user.fullName,
        ),
      )
          .toList();
    });
  }
}

class _ProductAccumulator {
  final int productId;
  final String productName;
  final String category;

  int quantity;
  double totalSales;
  double profit;

  _ProductAccumulator({
    required this.productId,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.totalSales,
    required this.profit,
  });
}