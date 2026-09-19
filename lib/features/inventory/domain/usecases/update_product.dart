
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:injectable/injectable.dart';

import '../repositories/product_repository.dart';

/// تعديل صنف موجود.
@injectable
class UpdateProduct {
  final ProductRepository _repository;

  const UpdateProduct(this._repository);

  Future<void> call(ProductItem product) => _repository.updateProduct(product);
}
