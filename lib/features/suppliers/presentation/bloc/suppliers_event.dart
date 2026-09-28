import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:equatable/equatable.dart';



abstract class SuppliersEvent extends Equatable {
  const SuppliersEvent();

  @override
  List<Object?> get props => [];
}

class WatchSuppliersEvent extends SuppliersEvent {
  const WatchSuppliersEvent();
}

class AddSupplierEvent extends SuppliersEvent {
  final String name;
  final String? phone;
  final String? address;

  const AddSupplierEvent({
    required this.name,
    this.phone,
    this.address,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    address,
  ];
}

class UpdateSupplierEvent extends SuppliersEvent {
  final Supplier supplier;

  const UpdateSupplierEvent(this.supplier);

  @override
  List<Object?> get props => [supplier];
}

class DeleteSupplierEvent extends SuppliersEvent {
  final int id;

  const DeleteSupplierEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SuppliersUpdatedEvent extends SuppliersEvent {
  final List<Supplier> suppliers;

  const SuppliersUpdatedEvent(this.suppliers);

  @override
  List<Object?> get props => [suppliers];
}

class SuppliersErrorEvent extends SuppliersEvent {
  final String message;

  const SuppliersErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}