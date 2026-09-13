import 'package:cashier_app_v2/features/inventory/data/models/product_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// فورم إضافة/تعديل صنف.
/// بيرجع ProductItem عند الحفظ عن طريق Navigator.pop(item)
/// أو null لو المستخدم لغى العملية.
///
/// كل حقول الإدخال والأزرار هنا بتعتمد على AppTheme (inputDecorationTheme,
/// elevatedButtonTheme, outlinedButtonTheme) الجاهزة في المشروع، فمفيش
/// تكرار لستايل الألوان هنا.
class AddProductDialog extends StatefulWidget {
  final List<String> categories;
  final ProductItem? initial; // لو مبعوت يبقى وضع تعديل

  const AddProductDialog({
    super.key,
    required this.categories,
    this.initial,
  });

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _barcodeCtrl;
  late final TextEditingController _sellPriceCtrl;
  late final TextEditingController _unitCostCtrl;
  late final TextEditingController _cartonPriceCtrl;
  late final TextEditingController _unitsPerCartonCtrl;
  late final TextEditingController _quantityCtrl;

  late String _category;

  bool get _isEditing => widget.initial != null;

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _barcodeCtrl = TextEditingController(text: p?.barcode ?? '');
    _sellPriceCtrl = TextEditingController(text: p?.sellPrice.toString() ?? '');
    _unitCostCtrl = TextEditingController(text: p?.unitCost.toString() ?? '');
    _cartonPriceCtrl = TextEditingController(text: p?.cartonPrice.toString() ?? '');
    _unitsPerCartonCtrl = TextEditingController(text: p?.unitsPerCarton.toString() ?? '');
    _quantityCtrl = TextEditingController(text: p?.quantity.toString() ?? '');
    _category = p?.category ?? widget.categories.first;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _barcodeCtrl.dispose();
    _sellPriceCtrl.dispose();
    _unitCostCtrl.dispose();
    _cartonPriceCtrl.dispose();
    _unitsPerCartonCtrl.dispose();
    _quantityCtrl.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'مطلوب';
    return null;
  }

  String? _numberValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'مطلوب';
    if (double.tryParse(v.trim()) == null) return 'رقم غير صحيح';
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final item = ProductItem(
      id: widget.initial?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      barcode: _barcodeCtrl.text.trim(),
      category: _category,
      sellPrice: double.parse(_sellPriceCtrl.text.trim()),
      unitCost: double.parse(_unitCostCtrl.text.trim()),
      cartonPrice: double.parse(_cartonPriceCtrl.text.trim()),
      unitsPerCarton: int.parse(_unitsPerCartonCtrl.text.trim()),
      quantity: int.parse(_quantityCtrl.text.trim()),
    );

    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _isEditing ? 'تعديل صنف' : 'إضافة صنف جديد',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameCtrl,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(labelText: 'اسم الصنف'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _barcodeCtrl,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(labelText: 'الباركود'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    value: _category,
                    dropdownColor: AppColors.surfaceLight,
                    decoration: const InputDecoration(labelText: 'الفئة'),
                    items: widget.categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => _category = v ?? _category),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _sellPriceCtrl,
                          textAlign: TextAlign.right,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(labelText: 'سعر البيع'),
                          validator: _numberValidator,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _unitCostCtrl,
                          textAlign: TextAlign.right,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(labelText: 'التكلفة/وحدة'),
                          validator: _numberValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cartonPriceCtrl,
                          textAlign: TextAlign.right,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(labelText: 'سعر الكرتونة'),
                          validator: _numberValidator,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _unitsPerCartonCtrl,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'وحدة/كرتونة'),
                          validator: _numberValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _quantityCtrl,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'الكمية المتاحة'),
                    validator: _numberValidator,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'الحالة (متوفر / قرب يخلص / ناقص) بتتحسب تلقائيًا من الكمية.',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('إلغاء'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(_isEditing ? 'حفظ التعديلات' : 'حفظ الصنف'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
