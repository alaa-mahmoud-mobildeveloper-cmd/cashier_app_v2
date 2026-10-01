import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/worker.dart';

class WorkerRow extends StatelessWidget {
  final Worker worker;
  final VoidCallback? onToggle;
  final VoidCallback? onView;
  final VoidCallback? onDelete;

  const WorkerRow({
    super.key,
    required this.worker,
    this.onToggle,
    this.onView,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // اسم العامل والوظيفة
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    worker.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    worker.role,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // رقم الهاتف
            Expanded(
              flex: 2,
              child: Text(
                worker.phone,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),

            // الراتب
            Expanded(
              flex: 2,
              child: Text(
                '${worker.salary.toStringAsFixed(2)} ج',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),

            // الحالة (نشط / غير نشط) قابلة للضغط
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(14),
                  child: _buildStatusChip(),
                ),
              ),
            ),

            // الإجراءات (عرض وإخفاء)
            SizedBox(
              width: 96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onView,
                    tooltip: 'عرض التفاصيل',
                    icon: const Icon(
                      Icons.visibility_outlined,
                      color: AppColors.gold,
                      size: 19,
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    tooltip: 'إخفاء العامل مع الاحتفاظ بالسجل',
                    icon: const Icon(
                      Icons.archive_outlined,
                      color: AppColors.danger,
                      size: 19,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    final isActive = worker.status == WorkerStatus.active;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isActive ? AppColors.success : AppColors.textHint).withValues(
          alpha: .12,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        isActive ? 'نشط' : 'غير نشط',
        style: TextStyle(
          color: isActive ? AppColors.success : AppColors.textHint,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
