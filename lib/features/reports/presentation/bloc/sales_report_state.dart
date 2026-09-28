import 'package:equatable/equatable.dart';

import '../../domain/entities/report_cashier.dart';
import '../../domain/entities/sales_report.dart';

enum SalesReportStatus {
  initial,
  loading,
  success,
  failure,
}

class SalesReportState extends Equatable {
  final SalesReportStatus status;
  final SalesReport? report;
  final List<ReportCashier> cashiers;
  final String? errorMessage;

  const SalesReportState({
    this.status = SalesReportStatus.initial,
    this.report,
    this.cashiers = const [],
    this.errorMessage,
  });

  SalesReportState copyWith({
    SalesReportStatus? status,
    SalesReport? report,
    List<ReportCashier>? cashiers,
    String? errorMessage,
  }) {
    return SalesReportState(
      status: status ?? this.status,
      report: report ?? this.report,
      cashiers: cashiers ?? this.cashiers,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    report,
    cashiers,
    errorMessage,
  ];
}