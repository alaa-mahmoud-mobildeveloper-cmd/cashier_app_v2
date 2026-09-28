import '../entities/product_search_result.dart';

class NewProductParams {
  const NewProductParams({
    required this.name,
    required this.barcode,
    required this.unit,
    required this.category,
    required this.cartonPrice,
    required this.unitsPerCarton,
    required this.price,
  });

  final String name;
  final String barcode;
  final String unit;
  final String category;
  final double cartonPrice;
  final int unitsPerCarton;
  final double price;
}

class DuplicateBarcodeException implements Exception {
  DuplicateBarcodeException(this.existingProductName);
  final String existingProductName;
}

abstract class ProductLookupRepository {
  Future<List<ProductSearchResult>> search(String query);
  Future<ProductSearchResult?> findByBarcode(String barcode);
  Future<ProductSearchResult> createProduct(NewProductParams params);
}