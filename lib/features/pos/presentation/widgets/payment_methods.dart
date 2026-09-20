import 'package:cashier_app_v2/features/pos/presentation/widgets/PaymentForm.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/product.dart';


class PaymentMethods extends StatelessWidget {
  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onSelected;
  final void Function(String name, String phone, double amount)? onDeferredConfirm;

  const PaymentMethods({
    super.key,
    required this.selected,
    required this.onSelected,
    this.onDeferredConfirm,
  });

  void _handleTap(BuildContext context, PaymentMethod method) {
    if (method == PaymentMethod.credit) {
      PaymentForm.show(
        context,
        methodLabel: method.label,
        onConfirm: (name, phone, amount) {
          onSelected(method);
          onDeferredConfirm?.call(name, phone, amount);
        },
      );
    } else {
      onSelected(method);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: PaymentMethod.values.map((method) {
        final isSelected = selected == method;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: InkWell(
              onTap: () => _handleTap(context, method),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.successSurface : AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.success : AppColors.border,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      method.icon,
                      size: 18,
                      color: isSelected ? AppColors.success : AppColors.textSecondary,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      method.label,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected ? AppColors.success : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}