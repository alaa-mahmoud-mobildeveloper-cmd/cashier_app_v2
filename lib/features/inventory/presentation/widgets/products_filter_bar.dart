import 'package:cashier_app_v2/features/inventory/data/models/product_status.dart';
import 'package:flutter/material.dart';
import 'category_dropdown.dart';
import 'filter_chip_button.dart';
import 'product_search_field.dart';

class ProductsFilterBar extends StatelessWidget {
  final ProductFilter selectedFilter;
  final ValueChanged<ProductFilter> onFilterChanged;

  final String selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onCategoryChanged;

  final ValueChanged<String> onSearchChanged;

  const ProductsFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 720;

        final chips = Wrap(
          spacing: 10,
          runSpacing: 10,
          children: ProductFilter.values.map((f) {
            return FilterChipButton(
              label: f.label,
              selected: selectedFilter == f,
              onTap: () => onFilterChanged(f),
            );
          }).toList(),
        );

        final category = SizedBox(
          width: isNarrow ? null : 180,
          height: 48,
          child: CategoryDropdown(
            value: selectedCategory,
            categories: categories,
            onChanged: onCategoryChanged,
          ),
        );

        final search = SizedBox(
          height: 48,
          child: ProductSearchField(onChanged: onSearchChanged),
        );

        if (isNarrow) {
          // شاشات صغيرة: كل عنصر في صف لوحده
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              chips,
              const SizedBox(height: 12),
              category,
              const SizedBox(height: 12),
              search,
            ],
          );
        }

        // شاشات كبيرة: صف واحد (البحث ياخد المساحة المتبقية يمين الشاشة)
        return Row(
          children: [
            Expanded(child: search),
            const SizedBox(width: 12),
            category,
            const SizedBox(width: 12),
            chips,
          ],
        );
      },
    );
  }
}
