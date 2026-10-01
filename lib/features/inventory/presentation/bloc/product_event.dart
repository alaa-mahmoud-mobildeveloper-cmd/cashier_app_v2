import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';
import 'package:equatable/equatable.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsStarted extends ProductsEvent {
  const ProductsStarted();
}

class ProductsSearchChanged extends ProductsEvent {
  final String query;

  const ProductsSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ProductsSearchSubmitted extends ProductsEvent {
  final String query;

  const ProductsSearchSubmitted(this.query);

  @override
  List<Object?> get props => [query];
}

class ProductsFilterChanged extends ProductsEvent {
  final ProductFilter filter;

  const ProductsFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

class ProductsCategoryChanged extends ProductsEvent {
  final String category;

  const ProductsCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class ProductsLoadMoreRequested extends ProductsEvent {
  const ProductsLoadMoreRequested();
}

class ProductsRefreshRequested extends ProductsEvent {
  const ProductsRefreshRequested();
}

class ProductAddRequested extends ProductsEvent {
  final ProductItem product;

  const ProductAddRequested(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductUpdateRequested extends ProductsEvent {
  final ProductItem product;

  const ProductUpdateRequested(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDeleteRequested extends ProductsEvent {
  final String id;

  const ProductDeleteRequested(this.id);

  @override
  List<Object?> get props => [id];
}