import 'package:injectable/injectable.dart';

import '../../domain/entities/report_cashier.dart';
import '../../domain/entities/sales_report.dart';
import '../../domain/repositories/sales_report_repository.dart';
import '../datasources/sales_report_local_data_source.dart';

@LazySingleton(as: SalesReportRepository)
class SalesReportRepositoryImpl implements SalesReportRepository {
  final SalesReportLocalDataSource localDataSource;

  SalesReportRepositoryImpl(this.localDataSource);

  @override
  Stream<SalesReport> watchSalesReport({
    required DateTime from,
    required DateTime to,
    String? paymentMethod,
    int? cashierId,
    String? search,
  }) {
    return localDataSource.watchSalesReport(
      from: from,
      to: to,
      paymentMethod: paymentMethod,
      cashierId: cashierId,
      search: search,
    );
  }

  @override
  Stream<List<ReportCashier>> watchCashiers() {
    return localDataSource.watchCashiers();
  }
}