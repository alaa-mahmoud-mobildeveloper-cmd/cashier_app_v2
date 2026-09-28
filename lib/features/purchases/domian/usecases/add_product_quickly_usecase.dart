import 'package:injectable/injectable.dart';
import '../entities/product_search_result.dart';
import '../repositories/product_lookup_repository.dart';

@lazySingleton
class AddProductQuicklyUseCase {
  AddProductQuicklyUseCase(this._repo);
  final ProductLookupRepository _repo;

  Future<ProductSearchResult> call(NewProductParams p) async {
    if (p.name.trim().isEmpty) throw ArgumentError('اسم الصنف مطلوب');
    if (p.unitsPerCarton <= 0) {
      throw ArgumentError('عدد الوحدات في الكرتونة لازم يكون أكبر من صفر');
    }
    if (p.price <= 0) throw ArgumentError('سعر البيع مطلوب');

    var barcode = p.barcode.trim();
    if (barcode.isEmpty) {
      // العمود unique وغير nullable، فنولّد كود داخلي
      barcode = 'INT${DateTime.now().millisecondsSinceEpoch}';
    } else {
      final existing = await _repo.findByBarcode(barcode);
      if (existing != null) throw DuplicateBarcodeException(existing.name);
    }

    return _repo.createProduct(
      NewProductParams(
        name: p.name.trim(),
        barcode: barcode,
        unit: p.unit,
        category: p.category,
        cartonPrice: p.cartonPrice,
        unitsPerCarton: p.unitsPerCarton,
        price: p.price,
      ),
    );
  }
}