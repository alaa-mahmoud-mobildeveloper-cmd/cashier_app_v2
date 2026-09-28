import 'package:equatable/equatable.dart';

class Supplier extends Equatable {
  final int id;
  final String name;
  final String? phone;
  final String? address;
  final DateTime createdAt;

  const Supplier({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    address,
    createdAt,
  ];
}