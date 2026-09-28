import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/collect_purchase_payment_use_case.dart';
import '../../../domain/usecase/watch_supplier_statement_use_case.dart';
import 'supplier_statement_event.dart';
import 'supplier_statement_state.dart';

@injectable
class SupplierStatementBloc
    extends Bloc<SupplierStatementEvent, SupplierStatementState> {
  final WatchSupplierStatementUseCase watchSupplierStatementUseCase;
  final CollectPurchasePaymentUseCase collectPurchasePaymentUseCase;

  StreamSubscription? _subscription;

  SupplierStatementBloc(
      this.watchSupplierStatementUseCase,
      this.collectPurchasePaymentUseCase,
      ) : super(const SupplierStatementState()) {
    on<WatchSupplierStatementEvent>(_onWatch);
    on<SupplierStatementUpdatedEvent>(_onUpdated);
    on<CollectPurchasePaymentEvent>(_onCollect);
    on<SupplierStatementErrorEvent>(_onError);
  }

  Future<void> _onWatch(
      WatchSupplierStatementEvent event,
      Emitter<SupplierStatementState> emit,
      ) async {
    emit(
      state.copyWith(
        status: SupplierStatementStatus.loading,
        clearError: true,
      ),
    );

    await _subscription?.cancel();

    _subscription = watchSupplierStatementUseCase(event.supplierId).listen(
          (transactions) {
        add(
          SupplierStatementUpdatedEvent(transactions),
        );
      },
      onError: (error) {
        add(
          SupplierStatementErrorEvent(
            error.toString(),
          ),
        );
      },
    );
  }

  void _onUpdated(
      SupplierStatementUpdatedEvent event,
      Emitter<SupplierStatementState> emit,
      ) {
    emit(
      state.copyWith(
        status: SupplierStatementStatus.success,
        transactions: event.transactions,
        clearError: true,
      ),
    );
  }

  Future<void> _onCollect(
      CollectPurchasePaymentEvent event,
      Emitter<SupplierStatementState> emit,
      ) async {
    emit(
      state.copyWith(
        status: SupplierStatementStatus.collecting,
        clearError: true,
      ),
    );

    try {
      await collectPurchasePaymentUseCase(
        purchaseId: event.purchaseId,
        amount: event.amount,
        paymentMethod: event.paymentMethod,
        note: event.note,
      );

      emit(
        state.copyWith(
          status: SupplierStatementStatus.success,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SupplierStatementStatus.failure,
          errorMessage: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  void _onError(
      SupplierStatementErrorEvent event,
      Emitter<SupplierStatementState> emit,
      ) {
    emit(
      state.copyWith(
        status: SupplierStatementStatus.failure,
        errorMessage: event.message,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}