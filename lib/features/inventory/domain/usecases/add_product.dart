
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';

import '../repositories/product_repository.dart';
import 'package:injectable/injectable.dart';


import '../repositories/product_repository.dart';

/// إضافة صنف جديد.
@injectable
class AddProduct {
  final ProductRepository _repository;

  const AddProduct(this._repository);

  Future<void> call(ProductItem product) => _repository.addProduct(product);
}