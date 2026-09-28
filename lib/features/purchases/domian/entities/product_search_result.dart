import 'package:equatable/equatable.dart';

class ProductSearchResult extends Equatable {
  const ProductSearchResult({
    required this.id,
    required this.name,
    required this.barcode,
    required this.category,
    required this.unit,
    required this.unitsPerCarton,
    required this.cartonPrice,
    required this.purchasePrice,
    required this.salePrice,
    required this.stockQuantity,
    required this.isActive,
  });

  final int id;
  final String name;
  final String barcode;
  final String category;
  final String unit;
  final int unitsPerCarton;
  final double cartonPrice;
  final double purchasePrice;
  final double salePrice;   // Products.price
  final int stockQuantity;  // المخزون الحالي بالوحدة
  final bool isActive;

  @override
  List<Object?> get props => [
    id, name, barcode, category, unit, unitsPerCarton,
    cartonPrice, purchasePrice, salePrice, stockQuantity, isActive,
  ];
}