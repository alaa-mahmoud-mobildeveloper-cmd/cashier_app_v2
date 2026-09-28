import 'package:cashier_app_v2/features/purchases/domian/entities/product_search_result.dart' ;
import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';
// تعديل: الـ entity من الـ domain مش من purchase_ui_models


class ProductSearchField extends StatelessWidget {
  const ProductSearchField({
    super.key,
    required this.controller,
    required this.results,
    required this.isSearching,
    required this.hasSearched, // جديد
    required this.onChanged,
    required this.onProductSelected,
    required this.onBarcodeSubmitted,
    required this.onAddNewRequested, // جديد
  });

  final TextEditingController controller;
  final List<ProductSearchResult> results;
  final bool isSearching;
  final bool hasSearched; // جديد: بحث خلص فعلًا (مش لسه بيكتب)
  final ValueChanged<String> onChanged;
  final ValueChanged<ProductSearchResult> onProductSelected;
  final ValueChanged<String> onBarcodeSubmitted;
  final ValueChanged<String> onAddNewRequested; // جديد

  @override
  Widget build(BuildContext context) {
    final query = controller.text.trim();
    final showNotFound =
        hasSearched && !isSearching && results.isEmpty && query.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearchTextField(),
        if (results.isNotEmpty) _buildResultsList(),
        if (showNotFound) _buildNotFoundTile(query), // جديد
      ],
    );
  }

  /// حقل إدخال البحث والباركود
  Widget _buildSearchTextField() {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onBarcodeSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        labelText: 'ابحث عن صنف بالاسم أو الباركود',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: isSearching ? _buildLoadingIndicator() : null,
      ),
    );
  }

  /// مؤشر التحميل أثناء البحث
  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(14),
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  /// قائمة نتائج البحث المنسدلة
  Widget _buildResultsList() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      constraints: const BoxConstraints(maxHeight: 240),
      decoration: _dropdownDecoration(),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          color: AppColors.divider,
        ),
        itemBuilder: (context, index) {
          final product = results[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(
              'باركود: ${product.barcode} · الكرتونة: ${product.unitsPerCarton} وحدة',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            onTap: () => onProductSelected(product),
          );
        },
      ),
    );
  }

  /// جديد: عنصر "مفيش نتيجة، أضف صنف جديد"
  Widget _buildNotFoundTile(String query) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: _dropdownDecoration(),
      child: ListTile(
        leading: const Icon(Icons.add_circle_outline),
        title: Text('مفيش صنف باسم "$query"'),
        subtitle: const Text(
          'اضغط لإضافته كصنف جديد',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        onTap: () => onAddNewRequested(query),
      ),
    );
  }

  /// جديد: نفس ستايل القايمة، مستخرج عشان يتكرر في الاتنين
  BoxDecoration _dropdownDecoration() {
    return BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.border),
    );
  }
}