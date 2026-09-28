import 'package:equatable/equatable.dart';

import '../../../domian/entities/save_purchase_params.dart';

abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object?> get props => [];
}

class SavePurchaseEvent extends PurchaseEvent {
  const SavePurchaseEvent(this.params);

  final SavePurchaseParams params;

  @override
  List<Object?> get props => [params];
}

class LoadPurchaseInvoicesEvent extends PurchaseEvent {
  const LoadPurchaseInvoicesEvent();
}

class LoadPurchaseInvoiceDetailsEvent extends PurchaseEvent {
  const LoadPurchaseInvoiceDetailsEvent(this.invoiceId);

  final int invoiceId;

  @override
  List<Object?> get props => [invoiceId];
}

class CollectPurchasePaymentEvent extends PurchaseEvent {
  const CollectPurchasePaymentEvent({
    required this.invoiceId,
    required this.amount,
    this.paymentMethod = 'cash',
    this.note,
  });

  final int invoiceId;
  final double amount;
  final String paymentMethod;
  final String? note;

  @override
  List<Object?> get props => [
    invoiceId,
    amount,
    paymentMethod,
    note,
  ];
}

class ResetPurchaseEvent extends PurchaseEvent {
  const ResetPurchaseEvent();
}