import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/domain/repositories/product_repository.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_bloc.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_event.dart';
import 'package:cashier_app_v2/features/inventory/presentation/bloc/product_state.dart';
import 'package:cashier_app_v2/features/inventory/presentation/widgets/inventory_stats.dart';
import 'package:cashier_app_v2/features/inventory/presentation/widgets/product_table_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product_stats.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/update_product.dart';

import '../widgets/add_product_dialog.dart';
import '../widgets/products_filter_bar.dart';
import '../widgets/products_header.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static const _categories = [
    ' عام ',
    'مواد غذائية',
    'مشروبات',
    'مياه وعصائر',
    'ألبان',
    'جبن',
    'زبادي',
    'بسكوت',
    'حلويات',
    'شوكولاتة',
    'سناكس',
    'معلبات',
    'أرز ومكرونة',
    'بقوليات',
    'زيوت وسمن',
    'سكر وملح',
    'توابل',
    'صلصات',
    'شاي وقهوة',
    'منظفات',
    'مجمدات',
    'أخرى',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(
        getProducts: getIt<GetProducts>(),
        getProductStats: getIt<GetProductStats>(),
        addProduct: getIt<AddProduct>(),
        updateProduct: getIt<UpdateProduct>(),
        deleteProduct: getIt<DeleteProduct>(),
        categories: _categories,
      )..add(const ProductsStarted()),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  Future<void> _openAddDialog(
      BuildContext context, {
        ProductItem? editing,
      }) async {
    final bloc = context.read<ProductsBloc>();
    final categories = bloc.state.categories;

    final result = await showDialog<ProductItem>(
      context: context,
      builder: (_) => AddProductDialog(
        categories: categories,
        initial: editing,
      ),
    );

    if (result == null || !context.mounted) {
      return;
    }

    if (editing != null) {
      bloc.add(ProductUpdateRequested(result));
    } else {
      bloc.add(ProductAddRequested(result));
    }
  }

  Future<void> _confirmDelete(
      BuildContext context,
      ProductItem item,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('حذف الصنف'),
          content: Text(
            'هل أنت متأكد من حذف "${item.name}"؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      context.read<ProductsBloc>().add(
        ProductDeleteRequested(item.id),
      );
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
              final stats = state.stats;

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.axis != Axis.vertical) {
                    return false;
                  }

                  final metrics = notification.metrics;

                  if (metrics.pixels >=
                      metrics.maxScrollExtent - 500) {
                    context.read<ProductsBloc>().add(
                      const ProductsLoadMoreRequested(),
                    );
                  }

                  return false;
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        20,
                        20,
                        0,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: ProductsHeader(
                          itemsCount: state.totalCount,
                          onAddPressed: () =>
                              _openAddDialog(context),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: InventoryStats(
                          productsCount:
                          stats?.productsCount ?? 0,
                          stockValue:
                          stats?.stockValue ?? 0,
                          expectedProfit:
                          stats?.expectedProfit ?? 0,
                          outOfStockCount:
                          stats?.outOfStockCount ?? 0,
                          lowStockCount:
                          stats?.lowStockCount ?? 0,
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: ProductsFilterBar(
                          selectedFilter:
                          state.selectedFilter,
                          onFilterChanged: (filter) {
                            context.read<ProductsBloc>().add(
                              ProductsFilterChanged(filter),
                            );
                          },
                          selectedCategory:
                          state.selectedCategory,
                          categories: [
                            ProductsState.allCategoriesLabel,
                            ...state.categories,
                          ],
                          onCategoryChanged: (category) {
                            context.read<ProductsBloc>().add(
                              ProductsCategoryChanged(
                                category,
                              ),
                            );
                          },
                          onSearchChanged: (query) {
                            context.read<ProductsBloc>().add(
                              ProductsSearchChanged(query),
                            );
                          },
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),

                    if (state.status == ProductsStatus.loading &&
                        state.products.isEmpty)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (state.status == ProductsStatus.failure &&
                        state.products.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              state.errorMessage ??
                                  'حصل خطأ غير متوقع',
                            ),
                          ),
                        ),
                      )
                    else if (state.products.isEmpty)
                        const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Text(
                                'لا توجد أصناف مطابقة',
                              ),
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                final item =
                                state.products[index];

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 14,
                                  ),
                                  child: ProductCard(
                                    item: item,
                                    onEdit: () {
                                      _openAddDialog(
                                        context,
                                        editing: item,
                                      );
                                    },
                                    onDelete: () {
                                      _confirmDelete(
                                        context,
                                        item,
                                      );
                                    },
                                  ),
                                );
                              },
                              childCount: state.products.length,
                            ),
                          ),
                        ),

                    if (state.isLoadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 24,
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child:
                              CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                    if (!state.hasMore &&
                        state.products.isNotEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: 30,
                          ),
                          child: Center(
                            child: Text(
                              'تم تحميل جميع الأصناف',
                            ),
                          ),
                        ),
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