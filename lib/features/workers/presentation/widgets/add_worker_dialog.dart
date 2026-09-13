import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/worker.dart';

class AddWorkerDialog extends StatefulWidget {
  const AddWorkerDialog({super.key});

  @override
  State<AddWorkerDialog> createState() => _AddWorkerDialogState();
}

class _AddWorkerDialogState extends State<AddWorkerDialog> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();
  final salaryController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    roleController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'أدخل $fieldName';
    }

    return null;
  }

  void saveWorker() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final salary = double.tryParse(salaryController.text.trim());

    if (salary == null || salary < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('أدخل راتبًا صحيحًا'),
        ),
      );
      return;
    }

    final worker = Worker(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      role: roleController.text.trim(),
      salary: salary,
      status: WorkerStatus.active,
    );

    Navigator.of(context).pop(worker);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إضافة عامل جديد'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    return validateRequired(value, 'اسم العامل');
                  },
                  decoration: const InputDecoration(
                    labelText: 'اسم العامل',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return validateRequired(value, 'رقم الهاتف');
                  },
                  decoration: const InputDecoration(
                    labelText: 'رقم الهاتف',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: roleController,
                  validator: (value) {
                    return validateRequired(value, 'الوظيفة');
                  },
                  decoration: const InputDecoration(
                    labelText: 'الوظيفة',
                    prefixIcon: Icon(Icons.work_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: salaryController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    return validateRequired(value, 'الراتب');
                  },
                  decoration: const InputDecoration(
                    labelText: 'الراتب',
                    suffixText: 'ج',
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'إلغاء',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: saveWorker,
          child: const Text('حفظ العامل'),
        ),
      ],
    );
  }
}
