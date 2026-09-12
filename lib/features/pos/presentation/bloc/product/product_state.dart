import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String selectedCategory;
  final String searchQuery;

  const ProductLoaded({
    required this.allProducts,
    required this.filteredProducts,
    this.selectedCategory = 'الكل',
    this.searchQuery = '',
  });

  ProductLoaded copyWith({
    List<Product>? filteredProducts,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return ProductLoaded(
      allProducts: allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [allProducts, filteredProducts, selectedCategory, searchQuery];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object?> get props => [message];
}
