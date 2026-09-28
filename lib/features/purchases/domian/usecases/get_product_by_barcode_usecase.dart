import 'package:injectable/injectable.dart';
import '../entities/product_search_result.dart';
import '../repositories/product_lookup_repository.dart';

@lazySingleton
class GetProductByBarcodeUseCase {
  GetProductByBarcodeUseCase(this._repo);
  final ProductLookupRepository _repo;

  Future<ProductSearchResult?> call(String barcode) =>
      _repo.findByBarcode(barcode.trim());
}