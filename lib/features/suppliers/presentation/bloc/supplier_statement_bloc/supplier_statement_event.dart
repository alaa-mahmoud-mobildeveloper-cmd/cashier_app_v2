import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction.dart';
import 'package:equatable/equatable.dart';


import '../../../domain/entities/supplier_transaction_ui.dart';

abstract class SupplierStatementEvent extends Equatable {
  const SupplierStatementEvent();

  @override
  List<Object?> get props => [];
}

class WatchSupplierStatementEvent extends SupplierStatementEvent {
  final int supplierId;

  const WatchSupplierStatementEvent(this.supplierId);

  @override
  List<Object?> get props => [supplierId];
}

class SupplierStatementUpdatedEvent extends SupplierStatementEvent {
  final List<SupplierTransaction> transactions;

  const SupplierStatementUpdatedEvent(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class CollectPurchasePaymentEvent extends SupplierStatementEvent {
  final int purchaseId;
  final double amount;
  final String paymentMethod;
  final String? note;

  const CollectPurchasePaymentEvent({
    required this.purchaseId,
    required this.amount,
    required this.paymentMethod,
    this.note,
  });

  @override
  List<Object?> get props => [
    purchaseId,
    amount,
    paymentMethod,
    note,
  ];
}

class SupplierStatementErrorEvent extends SupplierStatementEvent {
  final String message;

  const SupplierStatementErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}