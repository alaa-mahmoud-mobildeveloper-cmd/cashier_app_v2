import 'product_status.dart';

class ProductItem {
  final String id;
  final String name;
  final String barcode;
  final String category;
  final double sellPrice;
  final double unitCost;
  final double cartonPrice;
  final int unitsPerCarton;
  final int quantity;

  const ProductItem({
    required this.id,
    required this.name,
    required this.barcode,
    required this.category,
    required this.sellPrice,
    required this.unitCost,
    required this.cartonPrice,
    required this.unitsPerCarton,
    required this.quantity,
  });

  /// الحالة محسوبة تلقائيًا من الكمية، مش بتتخزن كقيمة منفصلة
  ProductStatus get status => ProductStatusX.fromQuantity(quantity);

  ProductItem copyWith({
    String? name,
    String? barcode,
    String? category,
    double? sellPrice,
    double? unitCost,
    double? cartonPrice,
    int? unitsPerCarton,
    int? quantity,
  }) {
    return ProductItem(
      id: id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
      sellPrice: sellPrice ?? this.sellPrice,
      unitCost: unitCost ?? this.unitCost,
      cartonPrice: cartonPrice ?? this.cartonPrice,
      unitsPerCarton: unitsPerCarton ?? this.unitsPerCarton,
      quantity: quantity ?? this.quantity,
    );
  }
}
