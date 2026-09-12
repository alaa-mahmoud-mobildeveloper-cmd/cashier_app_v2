import 'package:flutter/material.dart';

/// كل ألوان التطبيق في مكان واحد - نفس الاستايل اللي في تصميم الكاشير
/// (خلفية سوداء + لمسات ذهبية). أي تغيير في اللون هنا بينعكس على المشروع كله.
class AppColors {
  AppColors._();

  // ---- الخلفيات ----
  static const background = Color(0xFF0D0D0D); // خلفية الشاشة الأساسية
  static const surface = Color(0xFF1E1E1E); // خلفية الكروت والعناصر (Card, TextField)
  static const surfaceLight = Color(0xFF141414); // خلفية الهيدر / الـ AppBar
  static const surfaceElevated = Color(0xFF262626); // عناصر فوق الـ surface (Dialogs, Sheets)
  static const border = Colors.white12; // خطوط الفواصل الخفيفة

  // ---- اللون الأساسي (الذهبي) ----
  static const primary = Color(0xFFD4A017);
  static const primaryLight = Color(0xFFE8C158); // Hover / تفعيل خفيف
  static const primaryDark = Color(0xFFA87D0E); // ظل أغمق للأزرار المضغوطة
  static const onPrimary = Colors.black; // لون النص/الأيقونة فوق الذهبي

  // ---- ألوان الحالة ----
  static const danger = Color(0xFFE53935); // حذف / نفاذ المخزون / أخطاء
  static const dangerBg = Color(0xFF3A1F1F); // خلفية خفيفة لأزرار/تنبيهات الخطر
  static const success = Color(0xFF43A047); // نجاح / إتمام بيع / مطابقة الكاش
  static const warning = Color(0xFFF9A825); // تنبيهات متوسطة (مخزون منخفض)

  // ---- النصوص ----
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.white70;
  static const textMuted = Colors.white38;
  static const textDisabled = Colors.white24;
}
