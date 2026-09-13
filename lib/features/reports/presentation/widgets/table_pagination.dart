import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TablePagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final ValueChanged<int> onPageChanged;

  const TablePagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) {
      return const Text('لا توجد نتائج', style: TextStyle(color: AppColors.textSecondary, fontSize: 12));
    }

    final start = ((currentPage - 1) * pageSize) + 1;
    final end = (currentPage * pageSize).clamp(0, totalCount);

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        Text('عرض $start-$end من $totalCount', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(totalPages, (i) {
            final page = i + 1;
            final selected = page == currentPage;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => onPageChanged(page),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.gold : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$page',
                    style: TextStyle(color: selected ? Colors.black : AppColors.textPrimary, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
