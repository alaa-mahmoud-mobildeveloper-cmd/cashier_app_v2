import 'dart:async';

import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';
import 'package:cashier_app_v2/features/debts/domain/usecases/pay_debt.dart';
import 'package:cashier_app_v2/features/debts/domain/usecases/watch_debts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'debt_event.dart';
import 'debt_state.dart';

@injectable
class DebtBloc extends Bloc<DebtEvent, DebtState> {
  final WatchDebts _watchDebts;
  final PayDebt _payDebt;

  StreamSubscription<List<DebtInvoice>>? _debtsSubscription;

  List<DebtInvoice> _allInvoices = [];

  String _searchQuery = '';

  String _selectedPaymentFilter = 'الكل';

  String _selectedStatusFilter = 'الكل';

  DebtBloc(
      this._watchDebts,
      this._payDebt,
      ) : super(const DebtInitial()) {
    on<LoadDebts>(_onLoadDebts);
    on<SearchDebts>(_onSearchDebts);
    on<FilterPaymentMethod>(_onFilterPaymentMethod);
    on<FilterDebtStatus>(_onFilterDebtStatus);
    on<PayDebtEvent>(_onPayDebt);

    on<_DebtsUpdated>(_onDebtsUpdated);
    on<_DebtsStreamError>(_onDebtsStreamError);
  }

  Future<void> _onLoadDebts(
      LoadDebts event,
      Emitter<DebtState> emit,
      ) async {
    emit(const DebtLoading());

    await _debtsSubscription?.cancel();

    _debtsSubscription = _watchDebts().listen(
          (invoices) {
        add(_DebtsUpdated(invoices));
      },
      onError: (error) {
        add(
          _DebtsStreamError(
            error.toString(),
          ),
        );
      },
    );
  }

  void _onDebtsUpdated(
      _DebtsUpdated event,
      Emitter<DebtState> emit,
      ) {
    _allInvoices = event.invoices;

    _emitLoaded(emit);
  }

  void _onSearchDebts(
      SearchDebts event,
      Emitter<DebtState> emit,
      ) {
    _searchQuery = event.query;

    _emitLoaded(emit);
  }

  void _onFilterPaymentMethod(
      FilterPaymentMethod event,
      Emitter<DebtState> emit,
      ) {
    _selectedPaymentFilter = event.filter;

    _emitLoaded(emit);
  }

  void _onFilterDebtStatus(
      FilterDebtStatus event,
      Emitter<DebtState> emit,
      ) {
    _selectedStatusFilter = event.filter;

    _emitLoaded(emit);
  }

  void _emitLoaded(
      Emitter<DebtState> emit,
      ) {
    emit(
      DebtLoaded(
        invoices: _allInvoices,
        searchQuery: _searchQuery,
        selectedPaymentFilter: _selectedPaymentFilter,
        selectedStatusFilter: _selectedStatusFilter,
      ),
    );
  }

  Future<void> _onPayDebt(
      PayDebtEvent event,
      Emitter<DebtState> emit,
      ) async {
    final currentState = state;

    try {
      await _payDebt(
        invoiceId: event.invoiceId,
        amount: event.amount,
      );

      // Drift Stream سيحدث القائمة تلقائياً.
    } catch (e) {
      final message = _cleanErrorMessage(e);

      if (currentState is DebtLoaded) {
        emit(DebtError(message));
        emit(currentState);
      } else {
        emit(DebtError(message));
      }
    }
  }

  void _onDebtsStreamError(
      _DebtsStreamError event,
      Emitter<DebtState> emit,
      ) {
    emit(
      DebtError(event.message),
    );
  }

  String _cleanErrorMessage(Object error) {
    final message = error.toString();

    if (message.startsWith('Exception: ')) {
      return message.substring(11);
    }

    return message;
  }

  @override
  Future<void> close() async {
    await _debtsSubscription?.cancel();
    return super.close();
  }
}

class _DebtsUpdated extends DebtEvent {
  final List<DebtInvoice> invoices;

  const _DebtsUpdated(this.invoices);

  @override
  List<Object?> get props => [invoices];
}

class _DebtsStreamError extends DebtEvent {
  final String message;

  const _DebtsStreamError(this.message);

  @override
  List<Object?> get props => [message];
}