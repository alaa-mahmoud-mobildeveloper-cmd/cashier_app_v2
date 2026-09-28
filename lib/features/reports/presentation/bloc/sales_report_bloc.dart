import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/report_cashier.dart';
import '../../domain/entities/sales_report.dart';
import '../../domain/repositories/sales_report_repository.dart';
import 'sales_report_event.dart';
import 'sales_report_state.dart';

@injectable
class SalesReportBloc extends Bloc<SalesReportEvent, SalesReportState> {
  final SalesReportRepository repository;

  StreamSubscription<SalesReport>? _reportSubscription;
  StreamSubscription<List<ReportCashier>>? _cashiersSubscription;

  SalesReportBloc(this.repository) : super(const SalesReportState()) {
    on<LoadSalesReport>(_onLoadSalesReport);
    on<LoadSalesCashiers>(_onLoadSalesCashiers);
    on<SalesReportUpdated>(_onSalesReportUpdated);
    on<CashiersUpdated>(_onCashiersUpdated);
    on<SalesReportFailed>(_onSalesReportFailed);
  }

  Future<void> _onLoadSalesReport(
      LoadSalesReport event,
      Emitter<SalesReportState> emit,
      ) async {
    await _reportSubscription?.cancel();

    emit(state.copyWith(status: SalesReportStatus.loading));

    _reportSubscription = repository
        .watchSalesReport(
      from: event.from,
      to: event.to,
      paymentMethod: event.paymentMethod,
      cashierId: event.cashierId,
      search: event.search,
    )
        .listen(
          (report) => add(SalesReportUpdated(report)),
      onError: (error) => add(SalesReportFailed(error.toString())),
    );
  }

  Future<void> _onLoadSalesCashiers(
      LoadSalesCashiers event,
      Emitter<SalesReportState> emit,
      ) async {
    await _cashiersSubscription?.cancel();

    _cashiersSubscription = repository.watchCashiers().listen(
          (cashiers) => add(CashiersUpdated(cashiers)),
      onError: (error) => add(SalesReportFailed(error.toString())),
    );
  }

  void _onSalesReportUpdated(
      SalesReportUpdated event,
      Emitter<SalesReportState> emit,
      ) {
    emit(
      state.copyWith(
        status: SalesReportStatus.success,
        report: event.report,
      ),
    );
  }

  void _onCashiersUpdated(
      CashiersUpdated event,
      Emitter<SalesReportState> emit,
      ) {
    emit(
      state.copyWith(
        cashiers: event.cashiers,
      ),
    );
  }

  void _onSalesReportFailed(
      SalesReportFailed event,
      Emitter<SalesReportState> emit,
      ) {
    emit(
      state.copyWith(
        status: SalesReportStatus.failure,
        errorMessage: event.message,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _reportSubscription?.cancel();
    await _cashiersSubscription?.cancel();
    return super.close();
  }
}

