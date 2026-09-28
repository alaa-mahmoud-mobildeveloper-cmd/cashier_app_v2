import 'package:cashier_app_v2/features/purchases/domian/entities/product_search_result.dart';
import 'package:equatable/equatable.dart';

enum ProductSearchStatus {
  initial,
  loading,
  results,
  notFound,
  exactMatch,
  addNewRequested,
  failure,
}

enum ProductAddStatus { idle, submitting, success, failure }

class ProductSearchState extends Equatable {
  const ProductSearchState({
    this.status = ProductSearchStatus.initial,
    this.query = '',
    this.results = const [],
    this.selected,
    this.errorMessage,
    this.addStatus = ProductAddStatus.idle,
    this.createdProduct,
    this.addError,
  });

  // ───────── حالة البحث ─────────
  final ProductSearchStatus status;
  final String query;
  final List<ProductSearchResult> results;
  final ProductSearchResult? selected;
  final String? errorMessage;

  // ───────── حالة الإضافة (منفصلة عشان متلخبطش حالة البحث) ─────────
  final ProductAddStatus addStatus;
  final ProductSearchResult? createdProduct;
  final String? addError;

  ProductSearchState copyWith({
    ProductSearchStatus? status,
    String? query,
    List<ProductSearchResult>? results,
    ProductSearchResult? selected,
    String? errorMessage,
    ProductAddStatus? addStatus,
    ProductSearchResult? createdProduct,
    String? addError,
  }) =>
      ProductSearchState(
        status: status ?? this.status,
        query: query ?? this.query,
        results: results ?? this.results,
        selected: selected,
        errorMessage: errorMessage,
        addStatus: addStatus ?? this.addStatus,
        createdProduct: createdProduct,
        addError: addError,
      );

  @override
  List<Object?> get props => [
    status,
    query,
    results,
    selected,
    errorMessage,
    addStatus,
    createdProduct,
    addError,
  ];
}