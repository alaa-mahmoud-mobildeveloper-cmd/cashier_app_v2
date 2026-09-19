

import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';

/// كيان الصنف في المخزون (Domain entity) — Dart خالص، مفيهوش أي
/// اعتماد على Flutter ولا على مصدر البيانات (Drift/API/...).
///
/// - "سعر شراء الوحدة" (unitCost) بيتحسب تلقائيًا = سعر الكرتونة ÷ عدد
///   الوحدات فيها، مش بيتخزن قيمة منفصلة ممكن تتعارض مع سعر الكرتونة.
/// - هامش الربح [profit] و [profitMarginPercent] كمان محسوبين.
class ProductItem {
  final String id;
  final String name;
  final String barcode;
  final String category;
  final double sellPrice;
  final double cartonPrice;
  final int unitsPerCarton;
  final int quantity;

  const ProductItem({
    required this.id,
    required this.name,
    required this.barcode,
    required this.category,
    required this.sellPrice,
    required this.cartonPrice,
    required this.unitsPerCarton,
    required this.quantity,
  });

  /// سعر شراء الوحدة = سعر الكرتونة ÷ عدد الوحدات في الكرتونة.
  double get unitCost => unitsPerCarton <= 0 ? 0 : cartonPrice / unitsPerCarton;

  /// هامش الربح للوحدة بالجنيه = سعر البيع - سعر شراء الوحدة.
  double get profit => sellPrice - unitCost;

  /// هامش الربح كنسبة مئوية من سعر البيع.
  double get profitMarginPercent => sellPrice <= 0 ? 0 : (profit / sellPrice) * 100;

  ProductStatus get status => ProductStatus.fromQuantity(quantity);

  ProductItem copyWith({
    String? id,
    String? name,
    String? barcode,
    String? category,
    double? sellPrice,
    double? cartonPrice,
    int? unitsPerCarton,
    int? quantity,
  }) {
    return ProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
      sellPrice: sellPrice ?? this.sellPrice,
      cartonPrice: cartonPrice ?? this.cartonPrice,
      unitsPerCarton: unitsPerCarton ?? this.unitsPerCarton,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductItem &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              barcode == other.barcode &&
              category == other.category &&
              sellPrice == other.sellPrice &&
              cartonPrice == other.cartonPrice &&
              unitsPerCarton == other.unitsPerCarton &&
              quantity == other.quantity;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    barcode,
    category,
    sellPrice,
    cartonPrice,
    unitsPerCarton,
    quantity,
  );
}