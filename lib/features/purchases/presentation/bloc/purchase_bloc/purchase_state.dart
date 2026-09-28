import 'package:cashier_app_v2/features/purchases/domian/entities/details_invoice.dart';
import 'package:equatable/equatable.dart';

import '../../../domian/entities/purchase_invoice.dart';

enum PurchaseStatus {
  initial,
  loading,
  saving,
  success,
  failure,
}

class PurchaseState extends Equatable {
  const PurchaseState({
    this.status = PurchaseStatus.initial,
    this.errorMessage,
    this.invoices = const [],
    this.invoiceDetails,
  });

  final PurchaseStatus status;
  final String? errorMessage;
  final List<PurchaseInvoice> invoices;
  final PurchaseInvoiceDetails? invoiceDetails;

  PurchaseState copyWith({
    PurchaseStatus? status,
    String? errorMessage,
    List<PurchaseInvoice>? invoices,
    PurchaseInvoiceDetails? invoiceDetails,
    bool clearError = false,
  }) {
    return PurchaseState(
      status: status ?? this.status,
      invoices: invoices ?? this.invoices,
      invoiceDetails: invoiceDetails ?? this.invoiceDetails,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    invoices,
    invoiceDetails,
  ];
}