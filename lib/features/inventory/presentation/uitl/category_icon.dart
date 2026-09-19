import 'package:flutter/material.dart';

/// بيرجع أيقونة مناسبة لاسم الفئة. لو الفئة مش من ضمن القائمة المعروفة
/// بترجع أيقونة افتراضية بدل ما تكسر الشاشة.
///
/// ملحوظة: الملف ده كان قبل كده في data/uitl/category_icon.dart (فيه
/// تايبو "uitl" بدل "util"). نقلته هنا لـ presentation/utils لسببين:
/// 1) تحويل category -> IconData هو منطق عرض (UI)، مش منطق بيانات،
///    فمكانه الصح presentation مش data.
/// 2) تصحيح التايبو. لو عندك أي import قديم بيشاور على المسار القديم
///    لازم تحدّثه لـ:
///    package:cashier_app_v2/features/inventory/presentation/utils/category_icon.dart
IconData categoryIcon(String category) {
  switch (category) {
    case 'مواد غذائية':
      return Icons.restaurant_menu;
    case 'مشروبات':
      return Icons.local_drink;
    case 'منظفات':
      return Icons.cleaning_services;
    case 'ألبان':
      return Icons.icecream_outlined;
    case 'خضار وفاكهة':
      return Icons.eco;
    case 'مخبوزات':
      return Icons.bakery_dining;
    case 'حلويات':
      return Icons.cake;
    case 'أدوات منزلية':
      return Icons.home_outlined;
    case 'سجائر':
      return Icons.smoking_rooms_outlined;
    default:
      return Icons.inventory_2_outlined;
  }
}