
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';

import '../repositories/product_repository.dart';
import 'package:injectable/injectable.dart';


import '../repositories/product_repository.dart';

/// الاشتراك في تحديثات قائمة الأصناف أول بأول.
@injectable
class WatchProducts {
  final ProductRepository _repository;

  const WatchProducts(this._repository);

  Stream<List<ProductItem>> call() => _repository.watchProducts();
}