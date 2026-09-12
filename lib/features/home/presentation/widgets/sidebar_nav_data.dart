import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';

/// موديل بيانات لعنصر واحد في القائمة - بيسهّل إضافة/حذف/إعادة ترتيب
/// العناصر من مكان واحد من غير ما تلمس الـ UI نفسه.
class SidebarNavItemData {
  final IconData icon;
  final String label;
  final String route;

  const SidebarNavItemData({required this.icon, required this.label, required this.route});
}

/// قسم كامل في القائمة (عنوان + مجموعة عناصر)
class SidebarSectionData {
  final String title;
  final List<SidebarNavItemData> items;

  const SidebarSectionData({required this.title, required this.items});
}

/// كل محتوى القائمة الجانبية - المصدر الوحيد للحقيقة (Single Source of Truth).
/// أي فيتشر جديد تضيفه، بتضيف سطر هنا بس.
const List<SidebarSectionData> sidebarSections = [
  SidebarSectionData(
    title: 'العمليات',
    items: [
      SidebarNavItemData(icon: Icons.shopping_cart, label: 'الكاشير', route: AppRoutes.pos),
      SidebarNavItemData(icon: Icons.credit_card, label: 'الآجل والمديونيات', route: AppRoutes.debts),
    ],
  ),
  SidebarSectionData(
    title: 'الإدارة',
    items: [
      SidebarNavItemData(icon: Icons.grid_view, label: 'لوحة التحكم', route: AppRoutes.dashboard),
      SidebarNavItemData(icon: Icons.show_chart, label: 'تقرير المبيعات', route: AppRoutes.reports),
      SidebarNavItemData(icon: Icons.inventory_2_outlined, label: 'إدارة الأصناف', route: AppRoutes.inventory),
      SidebarNavItemData(icon: Icons.people_outline, label: 'العمال', route: AppRoutes.workers),
      SidebarNavItemData(icon: Icons.description_outlined, label: 'إضافة مصروف', route: AppRoutes.expenses),
      SidebarNavItemData(icon: Icons.lock_outline, label: 'قفلة اليومية', route: AppRoutes.closing),
    ],
  ),
];
