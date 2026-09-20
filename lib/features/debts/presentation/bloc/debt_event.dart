import 'package:equatable/equatable.dart';

abstract class DebtEvent extends Equatable {
  const DebtEvent();

  @override
  List<Object?> get props => [];
}

class LoadDebts extends DebtEvent {
  const LoadDebts();
}

class SearchDebts extends DebtEvent {
  final String query;

  const SearchDebts(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterPaymentMethod extends DebtEvent {
  final String filter;

  const FilterPaymentMethod(this.filter);

  @override
  List<Object?> get props => [filter];
}

class FilterDebtStatus extends DebtEvent {
  final String filter;

  const FilterDebtStatus(this.filter);

  @override
  List<Object?> get props => [filter];
}

class PayDebtEvent extends DebtEvent {
  final int invoiceId;
  final double amount;

  const PayDebtEvent({
    required this.invoiceId,
    required this.amount,
  });

  @override
  List<Object?> get props => [
    invoiceId,
    amount,
  ];
}