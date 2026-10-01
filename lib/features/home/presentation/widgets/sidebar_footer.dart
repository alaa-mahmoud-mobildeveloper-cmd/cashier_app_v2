import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// تذييل القائمة الجانبية:
/// بيانات المستخدم الحالي وزر المساعدة.
class SidebarFooter extends StatelessWidget {
  final String userName;
  final String userRole;
  final VoidCallback? onLogout;

  const SidebarFooter({
    super.key,
    required this.userName,
    required this.userRole,
   required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final firstLetter = userName.trim().isNotEmpty
        ? userName.trim().characters.first
        : '?';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.gold,
            child: Text(
              firstLetter,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userRole,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onLogout,
              customBorder: const CircleBorder(),
              borderRadius: BorderRadius.circular(30),
              child: Ink(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: const Icon(
                  Icons.logout_outlined,
                  size: 17,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
