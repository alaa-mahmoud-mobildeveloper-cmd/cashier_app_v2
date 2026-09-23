import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';

/// كيان الصنف في المخزون (Domain entity) — Dart خالص، مفيهوش أي
/// اعتماد على Flutter ولا على مصدر البيانات (Drift/API/...).
///
/// - "سعر شراء الوحدة" (unitCost) بيتحسب تلقائيًا = سعر الكرتونة ÷ عدد
///   الوحدات فيها، مش بيتخزن قيمة منفصلة ممكن تتعارض مع سعر الكرتونة.
/// - هامش الربح [profit] و [profitMarginPercent] كمان محسوبين.
/// - [cartonQuantity] و [quantity] مختلفين فى الغرض:
///   * [cartonQuantity]: عدد الكراتين اللي اتسجلت وقت التوريد/الإضافة.
///     بيانة معلوماتية بس، بتتغير لما تضيف كمية كراتين جديدة.
///   * [quantity]: الكمية الفعلية بالوحدة المتاحة للبيع. دي القيمة
///     الحقيقية اللي بتتخزن وبتنقص مع كل عملية بيع (سطر فاتورة واحد
///     بيقلل [quantity] بعدد الوحدات المباعة). أول مرة بتتحسب من
///     المعادلة: الكمية بالوحدة = الكمية بالكرتونة × عدد الوحدات فى
///     الكرتونة (استخدم [ProductItem.fromCartonQuantity])، وبعد كده
///     بتتغير بمعزل عن [cartonQuantity] لأنها مش لازم تفضل مضاعف له
///     بعد ما يتباع منها.
class ProductItem {
  final String id;
  final String name;
  final String barcode;
  final String category;
  final double sellPrice;
  final double cartonPrice;
  final int unitsPerCarton;
  final double cartonQuantity;
  final int quantity;

  const ProductItem({
    required this.id,
    required this.name,
    required this.barcode,
    required this.category,
    required this.sellPrice,
    required this.cartonPrice,
    required this.unitsPerCarton,
    required this.cartonQuantity,
    required this.quantity,
  });

  /// إنشاء صنف جديد من بيانات التوريد بالكرتونة، مع حساب الكمية
  /// بالوحدة تلقائيًا أول مرة:
  /// الكمية بالوحدة = الكمية بالكرتونة × عدد الوحدات فى الكرتونة.
  ///
  /// استخدم الـ factory ده وقت إضافة صنف جديد أو تسجيل توريد كراتين
  /// جديدة. بعد كده الكمية بالوحدة بتتغير مباشرة مع كل عملية بيع
  /// (شوف [sellUnits]) مش بيعاد حسابها من الكرتونة.
  factory ProductItem.fromCartonQuantity({
    required String id,
    required String name,
    required String barcode,
    required String category,
    required double sellPrice,
    required double cartonPrice,
    required int unitsPerCarton,
    required double cartonQuantity,
  }) {
    return ProductItem(
      id: id,
      name: name,
      barcode: barcode,
      category: category,
      sellPrice: sellPrice,
      cartonPrice: cartonPrice,
      unitsPerCarton: unitsPerCarton,
      cartonQuantity: cartonQuantity,
      quantity: (cartonQuantity * unitsPerCarton).round(),
    );
  }

  /// سعر شراء الوحدة = سعر الكرتونة ÷ عدد الوحدات في الكرتونة.
  double get unitCost => unitsPerCarton <= 0 ? 0 : cartonPrice / unitsPerCarton;

  /// هامش الربح للوحدة بالجنيه = سعر البيع - سعر شراء الوحدة.
  double get profit => sellPrice - unitCost;

  /// هامش الربح كنسبة مئوية من سعر البيع.
  double get profitMarginPercent => sellPrice <= 0 ? 0 : (profit / sellPrice) * 100;

  ProductStatus get status => ProductStatus.fromQuantity(quantity);

  /// بينقص [soldUnits] من الكمية بالوحدة عند إتمام عملية بيع، وبيرجع
  /// نسخة جديدة من الصنف. الكمية مبتنزلش تحت الصفر حتى لو حصل تعارض
  /// فى البيانات.
  ProductItem sellUnits(int soldUnits) {
    if (soldUnits <= 0) return this;
    final updatedQuantity = quantity - soldUnits;
    return copyWith(quantity: updatedQuantity < 0 ? 0 : updatedQuantity);
  }

  ProductItem copyWith({
    String? id,
    String? name,
    String? barcode,
    String? category,
    double? sellPrice,
    double? cartonPrice,
    int? unitsPerCarton,
    double? cartonQuantity,
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
      cartonQuantity: cartonQuantity ?? this.cartonQuantity,
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
              cartonQuantity == other.cartonQuantity &&
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
    cartonQuantity,
    quantity,
  );
}