import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/cart/cart_state.dart';

class CartPanel extends StatefulWidget {
  final CartUpdated state;
  final void Function(String productId, int quantity) onQuantityChanged;
  final void Function(String productId) onRemove;
  final void Function(double discount) onDiscountChanged;
  final void Function(String paymentMethod) onCheckout;

  const CartPanel({
    super.key,
    required this.state,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onDiscountChanged,
    required this.onCheckout,
  });

  @override
  State<CartPanel> createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  String _selectedPayment = 'كاش';
  final List<String> _paymentMethods = ['كاش', 'فيزا', 'ماي فوري', 'انستاباي', 'آجل'];

  @override
  Widget build(BuildContext context) {
    final items = widget.state.items;

    return Container(
      color: AppColors.background,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.shopping_cart_outlined, color: AppColors.primary),
                Text('السلة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.receipt_long_outlined, color: Colors.white24, size: 48),
                        SizedBox(height: 8),
                        Text('السلة فارغة', style: TextStyle(color: Colors.white38)),
                        Text('امسح الباركود أو ابحث عن منتج', style: TextStyle(color: Colors.white24, fontSize: 12)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final line = items[index];
                      return Card(
                        color: AppColors.surface,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(line.product.name,
                              textAlign: TextAlign.right, style: const TextStyle(color: Colors.white)),
                          subtitle: Text('${line.product.price.toStringAsFixed(0)} ج × ${line.quantity}',
                              textAlign: TextAlign.right, style: const TextStyle(color: Colors.white54)),
                          leading: IconButton(
                            icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                            onPressed: () => widget.onRemove(line.product.id),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 20),
                                onPressed: () =>
                                    widget.onQuantityChanged(line.product.id, line.quantity + 1),
                              ),
                              Text('${line.quantity}', style: const TextStyle(color: Colors.white)),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.white54, size: 20),
                                onPressed: () =>
                                    widget.onQuantityChanged(line.product.id, line.quantity - 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${widget.state.subtotal.toStringAsFixed(2)} ج',
                        style: const TextStyle(color: Colors.white70)),
                    const Text('الإجمالي قبل الخصم', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'خصم (ج)', labelStyle: TextStyle(color: Colors.white54)),
                  onChanged: (v) => widget.onDiscountChanged(double.tryParse(v) ?? 0),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      const Text('الإجمالي', style: TextStyle(color: Colors.black87)),
                      Text('${widget.state.total.toStringAsFixed(2)} ج',
                          style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _paymentMethods.map((method) {
                    final selected = method == _selectedPayment;
                    return ChoiceChip(
                      label: Text(method),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedPayment = method),
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.surface,
                      labelStyle: TextStyle(color: selected ? Colors.black : Colors.white70),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: items.isEmpty ? null : () => widget.onCheckout(_selectedPayment),
                  child: const Text('إتمام البيع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
