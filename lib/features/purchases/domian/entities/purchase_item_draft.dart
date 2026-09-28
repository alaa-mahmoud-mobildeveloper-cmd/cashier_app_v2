import 'product_search_result.dart';

class PurchaseItemDraft {
  PurchaseItemDraft({
    required this.productId,
    required this.productName,
    required this.barcode,
    required this.category,
    required this.unit,
    required this.unitsPerCarton,
    required this.cartonPurchasePrice,
    required this.cartonQuantity,
    required double salePrice,
    required this.currentStock,
    required this.lastCartonPrice,
  })  : salePrice = salePrice,
        originalSalePrice = salePrice;

  factory PurchaseItemDraft.fromProduct(ProductSearchResult p) =>
      PurchaseItemDraft(
        productId: p.id,
        productName: p.name,
        barcode: p.barcode,
        category: p.category,
        unit: p.unit,
        unitsPerCarton: p.unitsPerCarton,
        cartonPurchasePrice: p.cartonPrice,
        cartonQuantity: 1,
        salePrice: p.salePrice,
        currentStock: p.stockQuantity,
        lastCartonPrice: p.cartonPrice,
      );

  final int productId;
  final String productName;
  final String barcode;
  final String category;
  final String unit;
  final int unitsPerCarton;
  final int currentStock;
  final double lastCartonPrice;
  final double originalSalePrice;

  // قابلة للتعديل
  double cartonPurchasePrice;
  double cartonQuantity; // يقبل كسور: 2.5 كرتونة
  double salePrice;

  double get total => cartonQuantity * cartonPurchasePrice;

  int get totalUnits => (cartonQuantity * unitsPerCarton).round();

  bool get hasFractionalUnits {
    final exact = cartonQuantity * unitsPerCarton;
    return (exact - exact.roundToDouble()).abs() > 0.0001;
  }

  int get stockAfter => currentStock + totalUnits;

  double get unitPurchasePrice =>
      unitsPerCarton > 0 ? cartonPurchasePrice / unitsPerCarton : 0;
  double get unitProfit => salePrice - unitPurchasePrice;

  bool get priceChanged =>
      (cartonPurchasePrice - lastCartonPrice).abs() > 0.001;

  /// سعر بيع مقترح بيحافظ على نفس ربح الوحدة القديم.
  double get suggestedSalePrice {
    final oldUnitCost =
    unitsPerCarton > 0 ? lastCartonPrice / unitsPerCarton : 0;
    return originalSalePrice - oldUnitCost + unitPurchasePrice;
  }

  bool get hasMissingUnitsPerCarton => unitsPerCarton <= 0;
}