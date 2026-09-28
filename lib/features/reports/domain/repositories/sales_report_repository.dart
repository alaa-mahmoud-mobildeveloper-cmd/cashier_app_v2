import '../entities/report_cashier.dart';
import '../entities/sales_report.dart';

abstract class SalesReportRepository {
  Stream<SalesReport> watchSalesReport({
    required DateTime from,
    required DateTime to,
    String? paymentMethod,
    int? cashierId,
    String? search,
  });

  Stream<List<ReportCashier>> watchCashiers();
}