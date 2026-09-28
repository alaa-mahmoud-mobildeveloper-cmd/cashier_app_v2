import 'package:cashier_app_v2/features/reports/domain/entities/sales_report.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/report_cashier.dart';

abstract class SalesReportEvent extends Equatable {
  const SalesReportEvent();

  @override
  List<Object?> get props => [];
}

class LoadSalesReport extends SalesReportEvent {
  final DateTime from;
  final DateTime to;
  final String? paymentMethod;
  final int? cashierId;
  final String? search;

  const LoadSalesReport({
    required this.from,
    required this.to,
    this.paymentMethod,
    this.cashierId,
    this.search,
  });

  @override
  List<Object?> get props => [
    from,
    to,
    paymentMethod,
    cashierId,
    search,
  ];
}

class LoadSalesCashiers extends SalesReportEvent {
  const LoadSalesCashiers();
}

class SalesReportUpdated extends SalesReportEvent {
  final SalesReport report;

  const SalesReportUpdated(this.report);

  @override
  List<Object?> get props => [report];
}

class CashiersUpdated extends SalesReportEvent {
  final List<ReportCashier> cashiers;

  const CashiersUpdated(this.cashiers);

  @override
  List<Object?> get props => [cashiers];
}

class SalesReportFailed extends SalesReportEvent {
  final String message;

  const SalesReportFailed(this.message);

  @override
  List<Object?> get props => [message];
}