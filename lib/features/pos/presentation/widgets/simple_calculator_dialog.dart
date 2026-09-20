import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// A plain calculator (no ties to the cart) for quick manual math, e.g.
/// working out change by hand. Open it with:
/// `showDialog(context: context, builder: (_) => const SimpleCalculatorDialog())`
class SimpleCalculatorDialog extends StatefulWidget {
  const SimpleCalculatorDialog({super.key});

  @override
  State<SimpleCalculatorDialog> createState() => _SimpleCalculatorDialogState();
}

class _SimpleCalculatorDialogState extends State<SimpleCalculatorDialog> {
  String _expression = '';
  String _result = '0';

  static const _buttons = [
    'C', '⌫', '%', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '00', '0', '.', '=',
  ];

  void _onPressed(String value) {
    setState(() {
      switch (value) {
        case 'C':
          _expression = '';
          _result = '0';
        case '⌫':
          if (_expression.isNotEmpty) {
            _expression = _expression.substring(0, _expression.length - 1);
          }
        case '=':
          _result = _evaluate(_expression);
        default:
          _expression += value;
      }
    });
  }

  String _evaluate(String expr) {
    try {
      final value = _calculate(expr.replaceAll('×', '*').replaceAll('÷', '/'));
      return value == value.roundToDouble() ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
    } catch (_) {
      return 'خطأ';
    }
  }

  /// Minimal left-to-right evaluator (no operator precedence) — enough
  /// for the quick manual sums a cashier needs at the register.
  double _calculate(String expr) {
    final tokens = <String>[];
    var current = '';
    for (final ch in expr.split('')) {
      if ('+-*/%'.contains(ch) && !(current.isEmpty && ch == '-')) {
        tokens
          ..add(current)
          ..add(ch);
        current = '';
      } else {
        current += ch;
      }
    }
    if (current.isNotEmpty) tokens.add(current);
    if (tokens.isEmpty) return 0;

    var result = double.parse(tokens.first);
    for (var i = 1; i < tokens.length - 1; i += 2) {
      final operand = double.parse(tokens[i + 1]);
      switch (tokens[i]) {
        case '+':
          result += operand;
        case '-':
          result -= operand;
        case '*':
          result *= operand;
        case '/':
          result /= operand;
        case '%':
          result %= operand;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280), // تقييد العرض الكلي لتكون صغيرة
        child: Padding(
          padding: const EdgeInsets.all(12), // تصغير الهوامش الكلية
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الآلة الحاسبة',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression.isEmpty ? ' ' : _expression,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _result,
                      maxLines: 1,
                      style: const TextStyle(color: AppColors.gold, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 6, // تقليل المسافات الرأسية بين الأزرار
                crossAxisSpacing: 6, // تقليل المسافات الأفقية بين الأزرار
                childAspectRatio: 1.4, // جعل الأزرار أضيق وأكثر تناسقاً
                children: _buttons.map((b) {
                  final isOperator = ['÷', '×', '-', '+', '='].contains(b);
                  final isUtility = ['C', '⌫', '%'].contains(b);
                  return InkWell(
                    onTap: () => _onPressed(b),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isOperator
                            ? AppColors.gold
                            : isUtility
                            ? AppColors.goldSurface
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        b,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isOperator ? Colors.black : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}