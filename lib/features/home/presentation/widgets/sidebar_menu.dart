import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'sidebar_footer.dart';
import 'sidebar_header.dart';
import 'sidebar_nav_data.dart';
import 'sidebar_nav_item.dart';
import 'sidebar_section_title.dart';

/// القائمة الجانبية الكاملة - مسؤوليتها الوحيدة هي تجميع الأجزاء
/// (Header, Sections, NavItems, Footer) مع بعض. كل جزء منها widget
/// مستقل قابل لإعادة الاستخدام والاختبار لوحده.
class SidebarMenu extends StatelessWidget {
  final String currentRoute;
  final List<String> allowedRoutes;
  final String userName;
  final String userRole;
  final VoidCallback? onLogout;
  final ValueChanged<String> onNavigate;

  const SidebarMenu({
    super.key,
    required this.currentRoute,
    required this.allowedRoutes,
    required this.userName,
    required this.userRole,
    required this.onLogout,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 280,
        color: AppColors.background,
        child: Column(
          children: [
            const SidebarHeader(),
            const Divider(color: AppColors.border, height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final section in sidebarSections)
                    if (section.items.any(
                      (item) => allowedRoutes.contains(item.route),
                    )) ...[
                      SidebarSectionTitle(section.title),
                      for (final item in section.items)
                        if (allowedRoutes.contains(item.route))
                          SidebarNavItem(
                            icon: item.icon,
                            label: item.label,
                            isActive: currentRoute == item.route,
                            onTap: () => onNavigate(item.route),
                          ),
                    ],
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            SidebarFooter(userName: userName, userRole: userRole, onLogout: onLogout,),
          ],
        ),
      ),
    );
  }
}
