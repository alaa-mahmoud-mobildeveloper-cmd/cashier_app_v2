import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/purchases/domian/entities/product_search_result.dart';
import 'package:cashier_app_v2/features/purchases/domian/repositories/product_lookup_repository.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/product_search_bloc.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/product_search_event.dart';
import 'package:cashier_app_v2/features/purchases/presentation/bloc/product_search_state.dart';

class AddProductSheet {
  AddProductSheet._();

  static const List<String> categories = [
    'مواد غذائية',
    "مشروبات",
    "مياه وعصائر",
    "ألبان",
    "جبن",
    "زبادي",
    "بسكوت"
        "حلويات",
    "شوكولاتة",
    "سناكس",
    "معلبات",
    "أرز ومكرونة",
    "بقوليات",
    "زيوت وسمن",
    "سكر وملح",
    "توابل",
    "صلصات",
    "شاي وقهوة",
    "منظفات",
    "مجمدات",
    "أخرى",
  ];

  static const List<String> units = [
    'قطعه','عبوه','زجاجه','كيس'
  ];

  static Future<ProductSearchResult?> show(
      BuildContext context, {
        required ProductSearchBloc bloc,
        String? initialName,
        String? initialBarcode,
      }) {
    return showModalBottomSheet<ProductSearchResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: _AddProductForm(
            categories: categories,
            initialName: initialName,
            initialBarcode: initialBarcode, units: units,
          ),
        ),
      ),
    );
  }
}

class _AddProductForm extends StatefulWidget {
  const _AddProductForm({
    required this.categories,
    required this.units,
    this.initialName,
    this.initialBarcode,
  });

  final List<String> categories;
  final List<String> units;
  final String? initialName;
  final String? initialBarcode;

  @override
  State<_AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<_AddProductForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _nameCtrl;
  late final TextEditingController _barcodeCtrl;
  late final TextEditingController _sellPriceCtrl;
  late final TextEditingController _cartonPriceCtrl;
  late final TextEditingController _unitsPerCartonCtrl;
  late final TextEditingController _cartonQuantityCtrl;
  late final TextEditingController _quantityCtrl;
  late  String _unitCtrl;

  late String _category;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _addListeners();
  }

  void _initControllers() {
    _nameCtrl = TextEditingController(text: widget.initialName ?? '');
    _barcodeCtrl = TextEditingController(text: widget.initialBarcode ?? '');
    _sellPriceCtrl = TextEditingController();
    _cartonPriceCtrl = TextEditingController();
    _unitsPerCartonCtrl = TextEditingController(text: '1');
    _cartonQuantityCtrl = TextEditingController(text: '1');
    _quantityCtrl = TextEditingController(text: '1');
    _unitCtrl =widget.units.isNotEmpty
        ? widget.units.first
        : 'قطعة';

    _category = widget.categories.isNotEmpty
        ? widget.categories.first
        : 'مواد غذائية';
  }

  void _addListeners() {
    _cartonQuantityCtrl.addListener(_updateQuantityFromCartons);
    _unitsPerCartonCtrl.addListener(_updateQuantityFromCartons);

    for (final controller in [
      _cartonPriceCtrl,
      _unitsPerCartonCtrl,
      _cartonQuantityCtrl,
      _quantityCtrl,
      _sellPriceCtrl,
    ]) {
      controller.addListener(_refreshPreview);
    }
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

  // --- Computed Getters & Logic ---

  double get _cartonPrice => _parseNum(_cartonPriceCtrl.text) ?? 0;
  int get _unitsPerCarton => _parseNum(_unitsPerCartonCtrl.text)?.toInt() ?? 0;
  double get _cartonQuantity => _parseNum(_cartonQuantityCtrl.text) ?? 0;
  int get _quantity => _parseNum(_quantityCtrl.text)?.toInt() ?? 0;
  double get _sellPrice => _parseNum(_sellPriceCtrl.text) ?? 0;

  double get _unitPurchasePrice {
    if (_unitsPerCarton <= 0) return 0;
    return _cartonPrice / _unitsPerCarton;
  }

  double get _profit => _sellPrice - _unitPurchasePrice;

  double get _marginPercent {
    if (_sellPrice <= 0) return 0;
    return (_profit / _sellPrice) * 100;
  }

  void _refreshPreview() {
    if (mounted) setState(() {});
  }

  void _updateQuantityFromCartons() {
    final quantity = (_cartonQuantity * _unitsPerCarton).round();
    if (_quantityCtrl.text != quantity.toString()) {
      _quantityCtrl.text = quantity.toString();
    }
  }

  double? _parseNum(String text) {
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    var value = text.trim().replaceAll('٫', '.').replaceAll('،', '.');

    for (var i = 0; i < arabic.length; i++) {
      value = value.replaceAll(arabic[i], '$i');
    }

    return double.tryParse(value);
  }

  // --- Validators ---

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'مطلوب';
    return null;
  }

  String? _positiveValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'مطلوب';
    final number = _parseNum(value);
    if (number == null || number <= 0) return 'لازم يكون أكبر من صفر';
    return null;
  }

  String? _nonNegativeDoubleValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'مطلوب';
    final number = _parseNum(value);
    if (number == null || number < 0) return 'مينفعش يكون سالب';
    return null;
  }

  String? _nonNegativeIntValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'مطلوب';
    final number = _parseNum(value);
    if (number == null || number < 0 || number != number.roundToDouble()) {
      return 'أدخل رقم صحيح موجب أو صفر';
    }
    return null;
  }

  // --- Actions ---

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ProductSearchBloc>().add(
      ProductAddSubmitted(
        NewProductParams(
          name: _nameCtrl.text.trim(),
          barcode: _barcodeCtrl.text.trim(),
          unit: _unitCtrl.trim().isEmpty
              ? 'قطعة'
              : _unitCtrl.trim(),
          category: _category,
          cartonPrice: _cartonPrice,
          unitsPerCarton: _unitsPerCarton,
          price: _sellPrice,
        ),
      ),
    );
  }

  // --- UI Build ---

  @override
  Widget build(BuildContext context) {
    final marginColor = _profit < 0
        ? AppColors.danger
        : (_profit == 0 ? AppColors.textSecondary : AppColors.success);

    return BlocConsumer<ProductSearchBloc, ProductSearchState>(
      listenWhen: (previous, current) =>
      previous.addStatus != current.addStatus,
      listener: _handleBlocListener,
      builder: (context, state) {
        final submitting = state.addStatus == ProductAddStatus.submitting;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                      _buildActionButtons(submitting),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleBlocListener(BuildContext context, ProductSearchState state) {
    if (state.addStatus == ProductAddStatus.success) {
      Navigator.of(context).pop(state.createdProduct);
    } else if (state.addStatus == ProductAddStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.addError ?? 'حدث خطأ أثناء إضافة الصنف',
          ),
        ),
      );
    }
  }

  // --- UI Widgets ---

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'إضافة صنف جديد',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ],
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
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _category,
                isExpanded: true,
                dropdownColor: AppColors.surfaceLight,
                decoration: const InputDecoration(labelText: 'الفئة'),
                items: widget.categories
                    .map(
                      (category) => DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _category = value);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _unitCtrl,
                isExpanded: true,
                dropdownColor: AppColors.surfaceLight,
                decoration: const InputDecoration(labelText: 'الوحده'),
                items: widget.units
                    .map(
                      (unit) => DropdownMenuItem<String>(
                    value: unit,
                    child: Text(
                      unit,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _unitCtrl = value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _sellPriceCtrl,
          textAlign: TextAlign.right,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'سعر البيع'),
          validator: _positiveValidator,
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
                validator: _positiveValidator,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _unitsPerCartonCtrl,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'وحدة/كرتونة'),
                validator: _positiveValidator,
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
            '$_quantity وحدة',
            'الكمية الحالية بالوحدة',
            AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          _buildPreviewRow(
            _unitPurchasePrice.toStringAsFixed(2),
            'سعر شراء الوحدة',
            AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          _buildPreviewRow(
            '${_profit.toStringAsFixed(2)} ج (${_marginPercent.toStringAsFixed(1)}%)',
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
      'الكمية بالوحدة = الكمية بالكرتونة × وحدة/كرتونة، ويمكن تعديلها قبل الحفظ.',
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _buildActionButtons(bool submitting) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: submitting ? null : () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: submitting ? null : _submit,
            child: submitting
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Text('حفظ وإضافة للفاتورة'),
          ),
        ),
      ],
    );
  }
}