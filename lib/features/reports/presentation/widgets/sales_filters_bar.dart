import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SalesFiltersBar extends StatelessWidget {
  final List<String> paymentFilters;
  final String selectedPaymentFilter;
  final ValueChanged<String> onPaymentFilterChanged;
  final List<String> cashiers;
  final String selectedCashier;
  final ValueChanged<String> onCashierChanged;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;

  const SalesFiltersBar({
    super.key,
    required this.paymentFilters,
    required this.selectedPaymentFilter,
    required this.onPaymentFilterChanged,
    required this.cashiers,
    required this.selectedCashier,
    required this.onCashierChanged,
    required this.searchController,
    required this.onSearch,
  });

  static const double _mobileBreakpoint = 700;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < _mobileBreakpoint;

      final chips = Wrap(
        spacing: 8,
        runSpacing: 8,
        children: paymentFilters.map((filter) {
          final selected = selectedPaymentFilter == filter;
          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (_) => onPaymentFilterChanged(filter),
            selectedColor: AppColors.gold,
            backgroundColor: Theme.of(context).cardColor,
            labelStyle: TextStyle(
              color: selected ? Colors.black : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide.none,
          );
        }).toList(),
      );

      final cashierDropdown = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedCashier,
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
            dropdownColor: Theme.of(context).cardColor,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
            items: cashiers.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (value) {
              if (value != null) onCashierChanged(value);
            },
          ),
        ),
      );

      final searchField = TextField(
        controller: searchController,
        onChanged: onSearch,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          hintText: 'بحث برقم الفاتورة أو الكاشير...',
          prefixIcon: Icon(Icons.search),
        ),
      );

      if (isMobile) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            chips,
            const SizedBox(height: 10),
            cashierDropdown,
            const SizedBox(height: 10),
            searchField,
          ],
        );
      }

      return Row(
        children: [
          chips,
          const SizedBox(width: 12),
          cashierDropdown,
          const SizedBox(width: 12),
          Expanded(child: searchField),
        ],
      );
    });
  }
}
