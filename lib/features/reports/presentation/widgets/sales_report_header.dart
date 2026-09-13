import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'date_field.dart';
import 'export_button.dart';

class SalesReportHeader extends StatelessWidget {
  final DateTime fromDate;
  final DateTime toDate;
  final VoidCallback? onExportExcel;
  final VoidCallback? onExportPdf;
  final VoidCallback? onPickFromDate;
  final VoidCallback? onPickToDate;

  const SalesReportHeader({
    super.key,
    required this.fromDate,
    required this.toDate,
    this.onExportExcel,
    this.onExportPdf,
    this.onPickFromDate,
    this.onPickToDate,
  });

  static const double _mobileBreakpoint = 700;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < _mobileBreakpoint;

      final titleBlock = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('تقرير المبيعات', style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('تحليل وعرض بيانات المبيعات', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      );

      final toolbar = Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ExportButton(label: 'Excel', icon: Icons.description_outlined, onTap: onExportExcel),
          ExportButton(label: 'PDF', icon: Icons.picture_as_pdf_outlined, onTap: onExportPdf),
          DateField(date: fromDate, onTap: onPickFromDate),
          const Text('—', style: TextStyle(color: AppColors.textSecondary)),
          DateField(date: toDate, onTap: onPickToDate),
        ],
      );

      if (isMobile) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleBlock,
              const SizedBox(height: 14),
              toolbar,
            ],
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleBlock,
            toolbar,
          ],
        ),
      );
    });
  }
}
