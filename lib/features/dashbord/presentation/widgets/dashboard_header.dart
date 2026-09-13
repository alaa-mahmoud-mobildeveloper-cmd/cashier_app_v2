import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  final String userName;
  final DateTime date;
  final bool hasNotification;
  final VoidCallback? onNotifications;
  final VoidCallback? onProfile;

  const DashboardHeader({
    super.key,
    required this.userName,
    required this.date,
    this.hasNotification = true,
    this.onNotifications,
    this.onProfile,
  });

  static const _weekdays = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
  static const _months = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  String get _formattedDate {
    final weekday = _weekdays[date.weekday - 1];
    return '$weekday، ${date.day} ${_months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final initial = userName.trim().isNotEmpty ? userName.trim()[0] : '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'لوحة التحكم',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(_formattedDate, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: onProfile,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(userName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.gold,
                        child: Text(initial, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: onNotifications,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      const Center(child: Icon(Icons.notifications_none_rounded, color: AppColors.gold, size: 20)),
                      if (hasNotification)
                        Positioned(
                          top: 9,
                          right: 11,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
