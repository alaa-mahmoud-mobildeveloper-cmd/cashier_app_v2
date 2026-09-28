import 'package:cashier_app_v2/features/suppliers/domain/entities/supplier_transaction.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/supplier_transaction_ui.dart';


enum SupplierStatementStatus {
  initial,
  loading,
  success,
  collecting,
  failure,
}

class SupplierStatementState extends Equatable {
  final SupplierStatementStatus status;
  final List<SupplierTransaction> transactions;
  final String? errorMessage;

  const SupplierStatementState({
    this.status = SupplierStatementStatus.initial,
    this.transactions = const [],
    this.errorMessage,
  });

  double get totalAmount {
    return transactions.fold(
      0,
          (sum, transaction) => sum + transaction.totalAmount,
    );
  }

  double get totalCollected {
    return transactions.fold(
      0,
          (sum, transaction) => sum + transaction.collectedAmount,
    );
  }

  double get totalDue {
    final value = totalAmount - totalCollected;
    return value < 0 ? 0 : value;
  }

  SupplierStatementState copyWith({
    SupplierStatementStatus? status,
    List<SupplierTransaction>? transactions,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SupplierStatementState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    transactions,
    errorMessage,
  ];
}