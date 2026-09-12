import 'package:flutter/material.dart';

abstract final class AppColors {
  // خلفيات
  static const background = Color(0xFF090909);
  static const surface = Color(0xFF101010);
  static const surfaceLight = Color(0xFF161616);
  static const card = Color(0xFF121212);
  static const input = Color(0xFF111111);

  // الحدود والفواصل
  static const border = Color(0xFF242424);
  static const borderLight = Color(0xFF303030);
  static const divider = Color(0xFF1D1D1D);

  // الألوان الأساسية
  static const gold = Color(0xFFE0B52F);
  static const goldLight = Color(0xFFF1CF4A);
  static const goldDark = Color(0xFF9C7814);

  // الحالات
  static const success = Color(0xFF36C878);
  static const danger = Color(0xFFE95B5B);
  static const warning = Color(0xFFF0B429);

  // النصوص
  static const textPrimary = Color(0xFFF2F2F2);
  static const textSecondary = Color(0xFFA0A0A0);
  static const textHint = Color(0xFF686868);
  static const textDisabled = Color(0xFF505050);

  // ألوان شفافة جاهزة
  static const goldSurface = Color(0x1FE0B52F);
  static const dangerSurface = Color(0x26E95B5B);
  static const successSurface = Color(0x2636C878);
}
