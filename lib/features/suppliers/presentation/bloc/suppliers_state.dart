import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:equatable/equatable.dart';

enum SuppliersStatus {
  initial,
  loading,
  success,
  failure,
}

class SuppliersState extends Equatable {
  final SuppliersStatus status;
  final List<Supplier> suppliers;
  final String? errorMessage;

  const SuppliersState({
    this.status = SuppliersStatus.initial,
    this.suppliers = const [],
    this.errorMessage,
  });

  SuppliersState copyWith({
    SuppliersStatus? status,
    List<Supplier>? suppliers,
    String? errorMessage,
  }) {
    return SuppliersState(
      status: status ?? this.status,
      suppliers: suppliers ?? this.suppliers,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    suppliers,
    errorMessage,
  ];
}