import 'package:cashier_app_v2/features/pos/domain/entities/product.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/cart_item_tile.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/empty_cart_state.dart';
import 'package:cashier_app_v2/features/pos/presentation/widgets/payment_methods.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

import '../widgets/category_tabs.dart';

import '../widgets/pos_header.dart';
import '../widgets/products_grid.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final searchController = TextEditingController();
  final discountController = TextEditingController(text: '0');
  final receivedController = TextEditingController(text: '0');
  final cart = <CartItem>[];
  PaymentMethod paymentMethod = PaymentMethod.cash;
  String category = 'الكل';

  static const categories = ['الكل', 'مواد غذائية', 'مشروبات', 'منظفات', 'ألبان', 'مخبوزات'];
  static const products = [
    Product(name: 'سكر أبيض 1 كجم', category: 'مواد غذائية', price: 12, stock: 3, icon: Icons.inventory_2_outlined),
    Product(name: 'زيت عباد الشمس 1.5 لتر', category: 'مواد غذائية', price: 28, stock: 45, icon: Icons.local_drink_outlined),
    Product(name: 'أرز بسمتي 5 كجم', category: 'مواد غذائية', price: 85, stock: 22, icon: Icons.rice_bowl_outlined),
    Product(name: 'حليب 1 لتر', category: 'ألبان', price: 18, stock: 60, icon: Icons.local_drink_outlined),
    Product(name: 'صابون أريل 3 كجم', category: 'منظفات', price: 55, stock: 5, icon: Icons.cleaning_services_outlined),
    Product(name: 'ماء معدني 1.5 لتر', category: 'مشروبات', price: 5, stock: 120, icon: Icons.water_drop_outlined),
    Product(name: 'زيت زيتون 500 مل', category: 'مواد غذائية', price: 65, stock: 18, icon: Icons.opacity_outlined),
    Product(name: 'تونة 185 جم', category: 'مواد غذائية', price: 22, stock: 18, icon: Icons.set_meal_outlined),
  ];

  List<Product> get filteredProducts => products.where((p) => category == 'الكل' || p.category == category).where((p) => searchController.text.isEmpty || p.name.contains(searchController.text)).toList();
  double get subtotal => cart.fold(0, (sum, item) => sum + item.total);
  double get discount => (double.tryParse(discountController.text) ?? 0).clamp(0, subtotal).toDouble();
  double get total => (subtotal - discount).clamp(0, double.infinity).toDouble();
  double get change => ((double.tryParse(receivedController.text) ?? 0) - total).clamp(0, double.infinity).toDouble();

  @override
  void dispose() { searchController.dispose(); discountController.dispose(); receivedController.dispose(); super.dispose(); }

  void addProduct(Product product) {
    setState(() {
      final index = cart.indexWhere((item) => item.product.name == product.name);
      if (index < 0) { cart.add(CartItem(product: product)); } else if (cart[index].quantity < product.stock) { cart[index].quantity++; }
    });
  }

  void changeQuantity(CartItem item, int amount) {
    setState(() { item.quantity += amount; if (item.quantity <= 0) cart.remove(item); if (item.quantity > item.product.stock) item.quantity = item.product.stock; });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(backgroundColor: AppColors.background, body: SafeArea(child: LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth < 900) return Column(children: [Expanded(flex: 6, child: productsPanel()), Expanded(flex: 5, child: cartPanel())]);
      return Row(children: [SizedBox(width: 390, child: cartPanel()), const VerticalDivider(width: 1, color: AppColors.divider), Expanded(child: productsPanel())]);
    }))));
  }

  Widget productsPanel() => Column(children: [
    PosHeader(controller: searchController, onSearch: (_) => setState(() {})),
    CategoryTabs(categories: categories, selected: category, onSelected: (value) => setState(() => category = value)),
    const SizedBox(height: 8),
    Expanded(child: ProductsGrid(products: filteredProducts, onProductTap: addProduct)),
  ]);

  Widget cartPanel() => Container(
    height: double.infinity,
    color: AppColors.surface,
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
    child: LayoutBuilder(
      builder: (context, constraints) {
        // تحديد ما إذا كانت الشاشة سطح مكتب (عرض أكبر من 850 بكسل مثلاً)
        final isDesktop = constraints.maxWidth > 850;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              // منع التمدد الزائد على الشاشات الكبيرة وتحديد حد أقصى للعرض
              maxWidth: isDesktop ? 450 : double.infinity,
            ),
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
                        Text(
                          'السلة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (cart.isNotEmpty)
                      TextButton(
                        onPressed: () => setState(cart.clear),
                        child: const Text(
                          'تفريغ السلة',
                          style: TextStyle(color: AppColors.danger),
                        ),
                      ),
                  ],
                ),
                const Divider(height: 24),
                if (cart.isEmpty)
                  const SizedBox(child: EmptyCartState())
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) => CartItemTile(
                      item: cart[i],
                      onQuantityChanged: (value) => changeQuantity(cart[i], value),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الإجمالي قبل الخصم',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    Text('${subtotal.toStringAsFixed(2)} ج'),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: discountController,
                  onChanged: (_) => setState(() {}),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'خصم (ج)',
                    isDense: true,
                  ),
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
                      const Text(
                        'الإجمالي',
                        style: TextStyle(
                          color: AppColors.goldLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${total.toStringAsFixed(2)} ج',
                        style: const TextStyle(
                          color: AppColors.goldLight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                PaymentMethods(
                  selected: paymentMethod,
                  onSelected: (value) => setState(() => paymentMethod = value),
                ),
                if (paymentMethod == PaymentMethod.cash) ...[
                  const SizedBox(height: 10),
                  TextField(
                    controller: receivedController,
                    onChanged: (_) => setState(() {}),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'المبلغ المستلم',
                      suffixText: 'الباقي ${change.toStringAsFixed(2)} ج',
                      isDense: true,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                const TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'ملاحظة (اختياري)',
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: cart.isEmpty ? null : () {},
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('إتمام البيع'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.calculate_outlined),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
              ],
            ),
          ),
        );
      },
    ),
  );
}
