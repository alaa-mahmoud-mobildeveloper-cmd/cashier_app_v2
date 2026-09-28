import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domian/usecases/collect_purchase_payment.dart';
import '../../../domian/usecases/get_purchase_invoice_details.dart';
import '../../../domian/usecases/save_purchase.dart';
import '../../../domian/usecases/watch_purchase_invoices.dart';

import 'purchase_event.dart';
import 'purchase_state.dart';

@injectable
class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc(
      this._savePurchase,
      this._watchPurchaseInvoices,
      this._getPurchaseInvoiceDetails,
      this._collectPurchasePayment,
      ) : super(const PurchaseState()) {
    on<SavePurchaseEvent>(_onSave);
    on<LoadPurchaseInvoicesEvent>(_onLoadInvoices);
    on<LoadPurchaseInvoiceDetailsEvent>(_onLoadInvoiceDetails);
    on<CollectPurchasePaymentEvent>(_onCollectPurchasePayment);
    on<ResetPurchaseEvent>(_onReset);
  }

  final SavePurchase _savePurchase;
  final WatchPurchaseInvoices _watchPurchaseInvoices;
  final GetPurchaseInvoiceDetails _getPurchaseInvoiceDetails;
  final CollectPurchasePayment _collectPurchasePayment;

  Future<void> _onLoadInvoices(
      LoadPurchaseInvoicesEvent event,
      Emitter<PurchaseState> emit,
      ) async {
    await emit.forEach(
      _watchPurchaseInvoices(),
      onData: (invoices) {
        return state.copyWith(
          status: PurchaseStatus.success,
          invoices: invoices,
          clearError: true,
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          status: PurchaseStatus.failure,
          invoices: const [],
          errorMessage: error.toString(),
        );
      },
    );
  }

  Future<void> _onSave(
      SavePurchaseEvent event,
      Emitter<PurchaseState> emit,
      ) async {
    emit(
      state.copyWith(
        status: PurchaseStatus.saving,
        clearError: true,
      ),
    );

    try {
      await _savePurchase(event.params);

      emit(
        state.copyWith(
          status: PurchaseStatus.success,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PurchaseStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCollectPurchasePayment(
      CollectPurchasePaymentEvent event,
      Emitter<PurchaseState> emit,
      ) async {
    emit(
      state.copyWith(
        status: PurchaseStatus.saving,
        clearError: true,
      ),
    );

    try {
      await _collectPurchasePayment(
        purchaseId: event.invoiceId,
        amount: event.amount,
        paymentMethod: event.paymentMethod,
        note: event.note,
      );

      final invoiceDetails =
      await _getPurchaseInvoiceDetails(event.invoiceId);

      emit(
        state.copyWith(
          status: PurchaseStatus.success,
          invoiceDetails: invoiceDetails,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PurchaseStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadInvoiceDetails(
      LoadPurchaseInvoiceDetailsEvent event,
      Emitter<PurchaseState> emit,
      ) async {
    emit(
      state.copyWith(
        status: PurchaseStatus.loading,
        clearError: true,
      ),
    );

    try {
      final invoiceDetails =
      await _getPurchaseInvoiceDetails(event.invoiceId);

      emit(
        state.copyWith(
          status: PurchaseStatus.success,
          invoiceDetails: invoiceDetails,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PurchaseStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onReset(
      ResetPurchaseEvent event,
      Emitter<PurchaseState> emit,
      ) {
    emit(const PurchaseState());
  }
}