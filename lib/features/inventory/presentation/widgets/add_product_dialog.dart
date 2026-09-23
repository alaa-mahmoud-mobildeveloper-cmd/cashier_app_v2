import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';

class AddProductDialog extends StatefulWidget {
  final List<String> categories;
  final ProductItem? initial;

  const AddProductDialog({
    super.key,
    required this.categories,
    this.initial,
  });

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  // ==================== Controllers & Keys ====================
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _barcodeCtrl;
  late final TextEditingController _sellPriceCtrl;
  late final TextEditingController _cartonPriceCtrl;
  late final TextEditingController _unitsPerCartonCtrl;
  late final TextEditingController _cartonQuantityCtrl;
  late final TextEditingController _quantityCtrl;

  late String _category;

  // ==================== Getters ====================
  bool get _isEditing => widget.initial != null;

  double get _previewUnitCost {
    final cartonPrice = double.tryParse(_cartonPriceCtrl.text.trim()) ?? 0;
    final unitsPerCarton = int.tryParse(_unitsPerCartonCtrl.text.trim()) ?? 0;
    return unitsPerCarton > 0 ? cartonPrice / unitsPerCarton : 0;
  }

  double get _previewSellPrice =>
      double.tryParse(_sellPriceCtrl.text.trim()) ?? 0;

  double get _previewProfit => _previewSellPrice - _previewUnitCost;

  double get _previewMarginPercent {
    if (_previewSellPrice <= 0) return 0;
    return (_previewProfit / _previewSellPrice) * 100;
  }

  int get _previewQuantity => int.tryParse(_quantityCtrl.text.trim()) ?? 0;

  // ==================== Lifecycle Methods ====================
  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupListeners();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _barcodeCtrl.dispose();
    _sellPriceCtrl.dispose();
    _cartonPriceCtrl.dispose();
    _unitsPerCartonCtrl.dispose();
    _cartonQuantityCtrl.dispose();
    _quantityCtrl.dispose();
    super.dispose();
  }

  // ==================== Initialization & Logic ====================
  void _initializeControllers() {
    final p = widget.initial;

    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _barcodeCtrl = TextEditingController(text: p?.barcode ?? '');
    _sellPriceCtrl = TextEditingController(text: p?.sellPrice.toString() ?? '');
    _cartonPriceCtrl = TextEditingController(text: p?.cartonPrice.toString() ?? '');
    _unitsPerCartonCtrl = TextEditingController(text: p?.unitsPerCarton.toString() ?? '');
    _cartonQuantityCtrl = TextEditingController(text: p?.cartonQuantity.toString() ?? '');
    _quantityCtrl = TextEditingController(text: p?.quantity.toString() ?? '');

    _category = p?.category ?? widget.categories.first;
  }

  void _setupListeners() {
    for (final ctrl in [
      _cartonPriceCtrl,
      _unitsPerCartonCtrl,
      _cartonQuantityCtrl,
      _quantityCtrl,
    ]) {
      ctrl.addListener(() {
        if (mounted) setState(() {});
      });
    }

    if (!_isEditing) {
      _cartonQuantityCtrl.addListener(_updateQuantityFromCartons);
      _unitsPerCartonCtrl.addListener(_updateQuantityFromCartons);
    }
  }

  void _updateQuantityFromCartons() {
    final cartonQuantity = double.tryParse(_cartonQuantityCtrl.text.trim()) ?? 0;
    final unitsPerCarton = int.tryParse(_unitsPerCartonCtrl.text.trim()) ?? 0;
    final quantity = (cartonQuantity * unitsPerCarton).round();

    if (_quantityCtrl.text != quantity.toString()) {
      _quantityCtrl.text = quantity.toString();
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text.trim();
    final barcode = _barcodeCtrl.text.trim();
    final sellPrice = double.parse(_sellPriceCtrl.text.trim());
    final cartonPrice = double.parse(_cartonPriceCtrl.text.trim());
    final unitsPerCarton = int.parse(_unitsPerCartonCtrl.text.trim());
    final cartonQuantity = double.parse(_cartonQuantityCtrl.text.trim());
    final quantity = int.parse(_quantityCtrl.text.trim());

    final item = _isEditing
        ? widget.initial!.copyWith(
      name: name,
      barcode: barcode,
      category: _category,
      sellPrice: sellPrice,
      cartonPrice: cartonPrice,
      unitsPerCarton: unitsPerCarton,
      cartonQuantity: cartonQuantity,
      quantity: quantity,
    )
        : ProductItem.fromCartonQuantity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      barcode: barcode,
      category: _category,
      sellPrice: sellPrice,
      cartonPrice: cartonPrice,
      unitsPerCarton: unitsPerCarton,
      cartonQuantity: cartonQuantity,
    );

    Navigator.of(context).pop(item);
  }

  // ==================== Validators ====================
  String? _requiredValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'مطلوب';
    return null;
  }

  String? _numberValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'مطلوب';
    if (double.tryParse(v.trim()) == null) return 'رقم غير صحيح';
    return null;
  }

  String? _positiveIntValidator(String? v) {
    final err = _numberValidator(v);
    if (err != null) return err;

    final n = int.tryParse(v!.trim());
    if (n == null || n <= 0) return 'لازم يكون أكبر من صفر';
    return null;
  }

  String? _nonNegativeDoubleValidator(String? v) {
    final err = _numberValidator(v);
    if (err != null) return err;

    final n = double.tryParse(v!.trim());
    if (n == null || n < 0) return 'مينفعش يكون سالب';
    return null;
  }

  String? _nonNegativeIntValidator(String? v) {
    final err = _numberValidator(v);
    if (err != null) return err;

    final n = int.tryParse(v!.trim());
    if (n == null || n < 0) return 'مينفعش يكون سالب';
    return null;
  }

  // ==================== UI Build Methods ====================
  @override
  Widget build(BuildContext context) {
    final marginColor = _previewProfit < 0
        ? AppColors.danger
        : (_previewProfit == 0 ? AppColors.textSecondary : AppColors.success);

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
                  _buildHeader(context),
                  const SizedBox(height: 20),
                  _buildTextFields(),
                  const SizedBox(height: 16),
                  _buildPreviewContainer(marginColor),
                  const SizedBox(height: 6),
                  _buildHelpText(context),
                  const SizedBox(height: 24),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      _isEditing ? 'تعديل صنف' : 'إضافة صنف جديد',
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
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
        TextFormField(
          controller: _sellPriceCtrl,
          textAlign: TextAlign.right,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'سعر البيع'),
          validator: _numberValidator,
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
                validator: _positiveIntValidator,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _cartonQuantityCtrl,
                textAlign: TextAlign.right,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'الكمية بالكرتونة'),
                validator: _nonNegativeDoubleValidator,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _quantityCtrl,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'الكمية بالوحدة'),
                validator: _nonNegativeIntValidator,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreviewContainer(Color marginColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPreviewRow(
            '$_previewQuantity وحدة',
            'الكمية الحالية بالوحدة',
            AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          _buildPreviewRow(
            _previewUnitCost.toStringAsFixed(2),
            'سعر شراء الوحدة',
            AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          _buildPreviewRow(
            '${_previewProfit.toStringAsFixed(2)} ج (${_previewMarginPercent.toStringAsFixed(1)}%)',
            'هامش الربح المتوقع للوحدة',
            marginColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String value, String label, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildHelpText(BuildContext context) {
    return Text(
      _isEditing
          ? 'يمكن تعديل الكمية بالوحدة والكمية بالكرتونة يدويًا من هنا.'
          : 'الكمية بالوحدة = الكمية بالكرتونة × وحدة/كرتونة، ويمكن تعديلها قبل الحفظ.',
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
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
    );
  }
}