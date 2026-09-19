import 'package:cashier_app_v2/di.dart';
import 'package:cashier_app_v2/features/pos/domain/entities/product.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_bloc.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_event.dart';
import 'package:cashier_app_v2/features/pos/presentation/bloc/pos_state.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/cart_item_tile.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/empty_cart_state.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/category_tabs.dart';
import '../widgets/pos_header.dart';
import '../widgets/products_grid.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartBloc>()..add(const LoadProducts()),
      child: const _PosView(),
    );
  }
}

class _PosView extends StatefulWidget {
  const _PosView();

  @override
  State<_PosView> createState() => _PosViewState();
}

class _PosViewState extends State<_PosView> {
  final searchController = TextEditingController();
  final discountController = TextEditingController(text: '0');
  final receivedController = TextEditingController(text: '0');

  PaymentMethod paymentMethod = PaymentMethod.cash;
  String category = 'الكل';

  double? deferredPaidAmount;

  static const categories = ['الكل', 'مواد غذائية', 'مشروبات', 'منظفات', 'ألبان', 'مخبوزات'];

  @override
  void dispose() {
    searchController.dispose();
    discountController.dispose();
    receivedController.dispose();
    super.dispose();
  }

  double _change(double total) {
    final received = double.tryParse(receivedController.text) ?? 0;
    return (received - total).clamp(0, double.infinity).toDouble();
  }

  void _checkout(CartState state) {
    if (state.cartItems.isEmpty) return;
    context.read<CartBloc>().add(
      CheckoutCart(
        paymentMethod: paymentMethod.name, // cash / visa / fawry / credit
        paidAmount: paymentMethod == PaymentMethod.credit ? deferredPaidAmount : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<CartBloc, CartState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == CartStatus.checkoutSuccess) {
                discountController.text = '0';
                receivedController.text = '0';
                setState(() {
                  paymentMethod = PaymentMethod.cash;
                  deferredPaidAmount = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم حفظ الفاتورة بنجاح (رقم: ${state.lastInvoiceId ?? '-'})'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
              if (state.status == CartStatus.failure && state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!), backgroundColor: AppColors.danger),
                );
              }
            },
            builder: (context, state) {
              final filteredProducts = state.products
                  .where((p) => category == 'الكل' || p.category == category)
                  .where((p) => searchController.text.isEmpty || p.name.contains(searchController.text))
                  .toList();

              final productsPanel = Column(
                children: [
                  PosHeader(controller: searchController, onSearch: (_) => setState(() {})),
                  CategoryTabs(
                    categories: categories,
                    selected: category,
                    onSelected: (value) => setState(() => category = value),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: state.status == CartStatus.loading && state.products.isEmpty
                        ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
                        : ProductsGrid(
                      products: filteredProducts,
                      onProductTap: (product) =>
                          context.read<CartBloc>().add(AddProductToCart(product)),
                    ),
                  ),
                ],
              );

              final cartPanel = _cartPanel(state);

              return LayoutBuilder(
                builder: (_, constraints) {
                  if (constraints.maxWidth < 900) {
                    return Column(
                      children: [
                        Expanded(flex: 6, child: productsPanel),
                        Expanded(flex: 5, child: cartPanel),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      SizedBox(width: 390, child: cartPanel),
                      const VerticalDivider(width: 1, color: AppColors.divider),
                      Expanded(child: productsPanel),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _cartPanel(CartState state) {
    final subtotal = state.totalAmount;
    final total = state.netAmount;

    return Container(
      height: double.infinity,
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 850;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isDesktop ? 450 : double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.shopping_cart_outlined, color: AppColors.gold),
                          SizedBox(width: 8),
                          Text('السلة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      if (state.cartItems.isNotEmpty)
                        TextButton(
                          onPressed: () => context.read<CartBloc>().add(const ClearCart()),
                          child: const Text('تفريغ السلة', style: TextStyle(color: AppColors.danger)),
                        ),
                    ],
                  ),
                  const Divider(height: 24),
                  Expanded(
                    child: state.cartItems.isEmpty
                        ? const EmptyCartState()
                        : ListView.separated(
                      itemCount: state.cartItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final item = state.cartItems[i];
                        return CartItemTile(
                          item: item,
                          onQuantityChanged: (delta) => context.read<CartBloc>().add(
                            UpdateQuantity(item.product.id, item.quantity + delta),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('الإجمالي قبل الخصم', style: TextStyle(color: AppColors.textSecondary)),
                      Text('${subtotal.toStringAsFixed(2)} ج'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: discountController,
                    onChanged: (v) => context.read<CartBloc>().add(ApplyDiscount(double.tryParse(v) ?? 0)),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'خصم (ج)', isDense: true),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.goldSurface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.goldDark),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('الإجمالي', style: TextStyle(color: AppColors.goldLight, fontWeight: FontWeight.bold)),
                        Text('${total.toStringAsFixed(2)} ج',
                            style: const TextStyle(color: AppColors.goldLight, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  PaymentMethods(
                    selected: paymentMethod,
                    onSelected: (value) => setState(() => paymentMethod = value),
                    onDeferredConfirm: (name, phone, amount) {
                      setState(() {
                        paymentMethod = PaymentMethod.credit;
                        deferredPaidAmount = amount;
                      });
                    },
                  ),
                  if (paymentMethod == PaymentMethod.cash) ...[
                    const SizedBox(height: 10),
                    TextField(
                      controller: receivedController,
                      onChanged: (_) => setState(() {}),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'المبلغ المستلم',
                        suffixText: 'الباقي ${_change(total).toStringAsFixed(2)} ج',
                        isDense: true,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  const TextField(
                    maxLines: 1,
                    decoration: InputDecoration(hintText: 'ملاحظة (اختياري)', isDense: true),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: state.cartItems.isEmpty || state.status == CartStatus.loading
                              ? null
                              : () => _checkout(state),
                          icon: state.status == CartStatus.loading
                              ? const SizedBox(
                            width: 18, height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                          )
                              : const Icon(Icons.check_circle_outline),
                          label: Text(state.status == CartStatus.loading ? 'جاري الحفظ...' : 'إتمام البيع'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.calculate_outlined)),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}