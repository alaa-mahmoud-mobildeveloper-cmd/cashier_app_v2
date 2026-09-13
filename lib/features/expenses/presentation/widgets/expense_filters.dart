import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ExpenseFilters extends StatelessWidget {
  final TextEditingController controller;
  final String selected;
  final List<String> categories;
  final ValueChanged<String> onSelected;
  final ValueChanged<String> onSearch;

  const ExpenseFilters({
    super.key,
    required this.controller,
    required this.selected,
    required this.categories,
    required this.onSelected,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // إذا كان العرض ضيقاً (موبايل)، اجعل البحث والفلاتر فوق بعضهما
        final isCompact = constraints.maxWidth < 600;

        final searchField = TextField(
          controller: controller,
          onChanged: onSearch,
          decoration: const InputDecoration(
            hintText: 'ابحث باسم المصروف أو الوصف...',
            prefixIcon: Icon(Icons.search),
          ),
        );

        final chipsWidget = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: selected == category,
                  onSelected: (_) => onSelected(category),
                  labelStyle: TextStyle(
                    color: selected == category
                        ? AppColors.gold
                        : AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
        );

        if (isCompact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchField,
              const SizedBox(height: 12),
              chipsWidget,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: searchField),
            const SizedBox(width: 12),
            chipsWidget,
          ],
        );
      },
    );
  }
}