import 'package:injectable/injectable.dart';
import '../entities/product_search_result.dart';
import '../repositories/product_lookup_repository.dart';

@lazySingleton
class SearchProductsUseCase {
  SearchProductsUseCase(this._repo);
  final ProductLookupRepository _repo;

  Future<List<ProductSearchResult>> call(String query) {
    final q = query.trim();
    if (q.isEmpty) return Future.value(const []);
    return _repo.search(q);
  }
}