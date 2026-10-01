import 'package:cashier_app_v2/features/inventory/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProduct {
  final ProductRepository _repository;

  const DeleteProduct(this._repository);

  Future<void> call(String id) {
    return _repository.deleteProduct(id);
  }
}