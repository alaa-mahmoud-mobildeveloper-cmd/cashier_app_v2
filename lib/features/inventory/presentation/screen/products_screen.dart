import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_bloc.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_event.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// عدّل الاستيراد ده على مسار ملف تسجيل injectable عندك لو اسمه مختلف
// (غالبًا injection.dart، واللي بيصدّر `getIt`).

import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/update_product.dart';
import '../../domain/usecases/watch_products.dart';

import '../widgets/add_product_dialog.dart';
import '../widgets/products_filter_bar.dart';
import '../widgets/products_header.dart';
import '../widgets/products_table.dart';

/// نقطة الدخول للشاشة. بتجيب الـ UseCases من getIt، فبقت متصلة فعليًا
/// بـ DriftProductRepository (والـ AppDatabase الحقيقية) بدل
/// InMemoryProductRepository اللي كانت بتفقد البيانات كل مرة.
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static const _categories = ['مواد غذائية', 'مشروبات', 'منظفات', 'ألبان'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(
        getProducts: getIt<GetProducts>(),
        watchProducts: getIt<WatchProducts>(),
        addProduct: getIt<AddProduct>(),
        updateProduct: getIt<UpdateProduct>(),
        categories: _categories,
      )..add(const ProductsStarted()),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  Future<void> _openAddDialog(BuildContext context, {ProductItem? editing}) async {
    final bloc = context.read<ProductsBloc>();
    final categories = bloc.state.categories;

    final result = await showDialog<ProductItem>(
      context: context,
      builder: (_) => AddProductDialog(categories: categories, initial: editing),
    );

    if (result == null) return;

    if (editing != null) {
      bloc.add(ProductUpdateRequested(result));
    } else {
      bloc.add(ProductAddRequested(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProductsHeader(
                      itemsCount: state.products.length,
                      onAddPressed: () => _openAddDialog(context),
                    ),
                    const SizedBox(height: 20),
                    ProductsFilterBar(
                      selectedFilter: state.selectedFilter,
                      onFilterChanged: (f) =>
                          context.read<ProductsBloc>().add(ProductsFilterChanged(f)),
                      selectedCategory: state.selectedCategory,
                      categories: [ProductsState.allCategoriesLabel, ...state.categories],
                      onCategoryChanged: (c) =>
                          context.read<ProductsBloc>().add(ProductsCategoryChanged(c)),
                      onSearchChanged: (q) =>
                          context.read<ProductsBloc>().add(ProductsSearchChanged(q)),
                    ),
                    const SizedBox(height: 20),
                    if (state.status == ProductsStatus.loading && state.products.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (state.status == ProductsStatus.failure)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Center(
                          child: Text(state.errorMessage ?? 'حصل خطأ غير متوقع'),
                        ),
                      )
                    else
                      ProductsTable(
                        items: state.filteredProducts,
                        onEdit: (item) => _openAddDialog(context, editing: item),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}