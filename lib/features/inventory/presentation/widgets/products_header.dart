import 'package:cashier_app_v2/features/purchases/presentation/screen/purchases_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProductsHeader extends StatelessWidget {
  final int itemsCount;
  final VoidCallback onAddPressed;

  const ProductsHeader({
    super.key,
    required this.itemsCount,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // يمين الشاشة (RTL): العنوان
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'إدارة الأصناف',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$itemsCount صنف',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ],
        ),
        const Spacer(),
        // يسار الشاشة (RTL): زرار الإضافة - بيستخدم elevatedButtonTheme الجاهز
        ElevatedButton.icon(
          onPressed: onAddPressed,
          icon: const Icon(Icons.add, size: 20),
          label: const Text('إضافة صنف'),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PurchasesScreen()),
            );
          },
          icon: const Icon(Icons.add, size: 20),
          label: const Text('إضافة فاتوره توريد'),
        ),
      ],
    );
  }
}
