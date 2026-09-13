import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DebtFilters extends StatelessWidget {
  final TextEditingController controller;
  final String selected;
  final ValueChanged<String> onSelected;
  final ValueChanged<String> onSearch;

  const DebtFilters({
    super.key,
    required this.controller,
    required this.selected,
    required this.onSelected,
    required this.onSearch,
  });

  static const filters = [ 'الكل','غير محصل', 'جزئي', 'محصل'];

  static const double _mobileBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < _mobileBreakpoint;

        final searchField = TextField(
          controller: controller,
          onChanged: onSearch,
          decoration: const InputDecoration(
            hintText: 'إبحث بالاسم أو رقم الفاتورة...',
            prefixIcon: Icon(Icons.search),
          ),
        );

        List<Widget> buildChips() => filters
            .map(
              (filter) => ChoiceChip(
            label: Text(filter),
            selected: selected == filter,
            onSelected: (_) => onSelected(filter),
            labelStyle: TextStyle(
              color: selected == filter
                  ? AppColors.gold
                  : AppColors.textSecondary,
            ),
          ),
        )
            .toList();

        if (isMobile) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                searchField,
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: buildChips(),
                ),
              ],
            ),
          );
        }

        final chipsRow = Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.rtl,
          children: filters
              .map(
                (filter) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(filter),
                selected: selected == filter,
                onSelected: (_) => onSelected(filter),
                labelStyle: TextStyle(
                  color: selected == filter
                      ? AppColors.gold
                      : AppColors.textSecondary,
                ),
              ),
            ),
          )
              .toList(),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
          child: Row(
            children: [
              Expanded(child: searchField),
              const SizedBox(width: 12),
              chipsRow,
            ],
          ),
        );
      },
    );
  }
}