import 'package:flutter/material.dart';

class PaymentForm extends StatelessWidget {
  final String methodLabel;
  final void Function(String name, String phone, double amount) onConfirm;

  const PaymentForm({
    super.key,
    required this.methodLabel,
    required this.onConfirm,
  });

  static Future<void> show(
      BuildContext context, {
        required String methodLabel,
        required void Function(String name, String phone, double amount) onConfirm,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: PaymentForm(methodLabel: methodLabel, onConfirm: onConfirm),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final amountController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'بيانات الدفع - $methodLabel',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'الاسم'),
            validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'من فضلك ادخل الاسم' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'رقم التليفون'),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'من فضلك ادخل رقم التليفون';
              if (v.trim().length < 10) return 'رقم غير صحيح';
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'المبلغ المدفوع'),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'من فضلك ادخل المبلغ';
              if (double.tryParse(v.trim()) == null) return 'المبلغ غير صحيح';
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onConfirm(
                  nameController.text.trim(),
                  phoneController.text.trim(),
                  double.parse(amountController.text.trim()),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}