import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';
import 'package:cashier_app_v2/features/inventory/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductStats {
  final ProductRepository _repository;

  const GetProductStats(this._repository);

  Future<ProductStats> call({
    String searchQuery = '',
    ProductFilter filter = ProductFilter.all,
    String? category,
  }) {
    return _repository.getProductStats(
      searchQuery: searchQuery,
      filter: filter,
      category: category,
    );
  }
}