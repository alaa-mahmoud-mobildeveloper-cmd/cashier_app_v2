import 'package:injectable/injectable.dart';

import '../entities/product_items_entit.dart';
import '../repositories/product_repository.dart';

/// جلب القائمة الحالية للأصناف مرة واحدة.
@injectable
class GetProducts {
  final ProductRepository _repository;

  const GetProducts(this._repository);

  Future<List<ProductItem>> call() => _repository.getProducts();
}