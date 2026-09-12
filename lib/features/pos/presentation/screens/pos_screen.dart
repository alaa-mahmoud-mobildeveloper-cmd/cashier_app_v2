import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../widgets/cart_panel.dart';
import '../widgets/product_card.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  static const List<String> categories = [
    'الكل', 'مواد غذائية', 'مشروبات', 'ألبان', 'منظفات', 'مخبوزات',
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

      ],
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading || state is ProductInitial) {
                        return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                      }
                      if (state is ProductError) {
                        return Center(
                          child: Text('حصل خطأ: ${state.message}', style: const TextStyle(color: Colors.white70)),
                        );
                      }
                      final loaded = state as ProductLoaded;
                      if (loaded.filteredProducts.isEmpty) {
                        return const Center(
                          child: Text('لا توجد منتجات', style: TextStyle(color: Colors.white38)),
                        );
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.95,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: loaded.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = loaded.filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onTap: () => context.read<CartBloc>().add(AddToCart(product)),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1, color: Colors.white12),
          Expanded(
            flex: 1,
            child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CheckoutSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إتمام عملية البيع بنجاح'), backgroundColor: AppColors.success),
                  );
                }
                if (state is CheckoutError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
                  );
                }
              },
              builder: (context, state) {
                final cartState = state is CartUpdated ? state : const CartUpdated(items: []);
                return CartPanel(
                  state: cartState,
                  onQuantityChanged: (id, qty) => context.read<CartBloc>().add(UpdateQuantity(id, qty)),
                  onRemove: (id) => context.read<CartBloc>().add(RemoveFromCart(id)),
                  onDiscountChanged: (d) => context.read<CartBloc>().add(ApplyDiscount(d)),
                  onCheckout: (method) => context.read<CartBloc>().add(CheckoutCart(method)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surfaceLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.white),
            onChanged: (q) => context.read<ProductBloc>().add(SearchProducts(q)),
            decoration: const InputDecoration(
              hintText: 'بحث بالاسم أو امسح الباركود...',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final selected = state is ProductLoaded ? state.selectedCategory : 'الكل';
                return ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  children: categories.map((cat) {
                    final isSelected = cat == selected;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) =>
                            context.read<ProductBloc>().add(FilterProductsByCategory(cat)),
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white70),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
