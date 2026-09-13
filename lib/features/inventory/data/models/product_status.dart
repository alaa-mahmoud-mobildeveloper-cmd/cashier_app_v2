import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// حالة الصنف بناءً على الكمية المتاحة
enum ProductStatus { available, lowStock, outOfStock }

extension ProductStatusX on ProductStatus {
  String get label {
    switch (this) {
      case ProductStatus.available:
        return 'متوفر';
      case ProductStatus.lowStock:
        return 'قرب يخلص';
      case ProductStatus.outOfStock:
        return 'ناقص';
    }
  }

  Color get color {
    switch (this) {
      case ProductStatus.available:
        return AppColors.success;
      case ProductStatus.lowStock:
        return AppColors.warning;
      case ProductStatus.outOfStock:
        return AppColors.danger;
    }
  }

  /// خلفية شفافة جاهزة تناسب لون كل حالة (نفس فكرة goldSurface/dangerSurface)
  Color get surfaceColor {
    switch (this) {
      case ProductStatus.available:
        return AppColors.successSurface;
      case ProductStatus.lowStock:
        return AppColors.goldSurface;
      case ProductStatus.outOfStock:
        return AppColors.dangerSurface;
    }
  }

  /// يحسب الحالة تلقائيًا حسب الكمية
  /// صفر = ناقص | من 1 إلى 5 = قرب يخلص | أكبر من 5 = متوفر
  static ProductStatus fromQuantity(int quantity) {
    if (quantity <= 0) return ProductStatus.outOfStock;
    if (quantity <= 5) return ProductStatus.lowStock;
    return ProductStatus.available;
  }
}

/// فلتر الشاشة (بيضيف خيار "الكل" فوق حالات الصنف)
enum ProductFilter { all, available, lowStock, outOfStock }

extension ProductFilterX on ProductFilter {
  String get label {
    switch (this) {
      case ProductFilter.all:
        return 'الكل';
      case ProductFilter.available:
        return 'متوفر';
      case ProductFilter.lowStock:
        return 'قرب يخلص';
      case ProductFilter.outOfStock:
        return 'ناقص';
    }
  }

  bool matches(ProductStatus status) {
    switch (this) {
      case ProductFilter.all:
        return true;
      case ProductFilter.available:
        return status == ProductStatus.available;
      case ProductFilter.lowStock:
        return status == ProductStatus.lowStock;
      case ProductFilter.outOfStock:
        return status == ProductStatus.outOfStock;
    }
  }
}
