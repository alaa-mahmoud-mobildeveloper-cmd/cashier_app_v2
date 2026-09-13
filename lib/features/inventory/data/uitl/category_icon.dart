import 'package:flutter/material.dart';

/// أيقونة تمثيلية لكل فئة (بديل الصورة الحقيقية للصنف)
IconData categoryIcon(String category) {
  switch (category) {
    case 'مواد غذائية':
      return Icons.rice_bowl_outlined;
    case 'مشروبات':
      return Icons.local_drink_outlined;
    case 'منظفات':
      return Icons.cleaning_services_outlined;
    case 'ألبان':
      return Icons.icecream_outlined;
    default:
      return Icons.inventory_2_outlined;
  }
}
