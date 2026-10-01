import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/expense.dart';

class AddExpenseDialog extends StatefulWidget {
  final Expense? expense;

  const AddExpenseDialog({super.key, this.expense});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;

  late String _selectedCategory;
  late ExpenseStatus _selectedStatus;

  static const List<String> _categories = [
    'إيجار',
    'رواتب',
    'مرافق',
    'مشتريات',
    'نقل',
    'أخرى',
  ];

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    _titleController = TextEditingController(text: expense?.title ?? '');
    _descriptionController = TextEditingController(
      text: expense?.description ?? '',
    );
    _amountController = TextEditingController(
      text: expense == null ? '' : expense.amount.toString(),
    );
    _selectedCategory = expense?.category ?? _categories.first;
    _selectedStatus = expense?.status ?? ExpenseStatus.paid;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل مبلغًا صحيحًا أكبر من صفر')),
      );
      return;
    }

    final newExpense = Expense(
      id: widget.expense?.id,
      title: _titleController.text.trim(),
      category: _selectedCategory,
      description: _descriptionController.text.trim(),
      date: widget.expense?.date ?? DateTime.now(),
      amount: amount,
      status: _selectedStatus,
    );

    Navigator.pop(context, newExpense);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.expense == null ? 'إضافة مصروف' : 'تعديل المصروف'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'أدخل اسم المصروف' : null,
                  decoration: const InputDecoration(
                    labelText: 'اسم المصروف',
                    prefixIcon: Icon(Icons.receipt_long_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'التصنيف',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value!),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _amountController,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'أدخل المبلغ' : null,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'المبلغ',
                    suffixText: 'ج',
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'الوصف (اختياري)',
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<ExpenseStatus>(
                  initialValue: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'الحالة',
                    prefixIcon: Icon(Icons.flag_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: ExpenseStatus.paid,
                      child: Text('مدفوع'),
                    ),
                    DropdownMenuItem(
                      value: ExpenseStatus.pending,
                      child: Text('معلق'),
                    ),
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedStatus = value!),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'إلغاء',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(onPressed: _save, child: const Text('حفظ')),
      ],
    );
  }
}
