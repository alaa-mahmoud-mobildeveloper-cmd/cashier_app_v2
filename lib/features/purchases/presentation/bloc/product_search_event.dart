import 'package:cashier_app_v2/features/purchases/domian/repositories/product_lookup_repository.dart';
import 'package:equatable/equatable.dart';

abstract class ProductSearchEvent extends Equatable {
  const ProductSearchEvent();
  @override
  List<Object?> get props => [];
}

// ───────────── أحداث البحث ─────────────

class ProductSearchQueryChanged extends ProductSearchEvent {
  const ProductSearchQueryChanged(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}

class ProductSearchSubmitted extends ProductSearchEvent {
  const ProductSearchSubmitted(this.query);
  final String query;
  @override
  List<Object?> get props => [query];
}

class ProductSearchCleared extends ProductSearchEvent {
  const ProductSearchCleared();
}

// ───────────── أحداث الإضافة ─────────────

/// حفظ صنف جديد من فورم الإضافة
class ProductAddSubmitted extends ProductSearchEvent {
  const ProductAddSubmitted(this.params);
  final NewProductParams params;
}