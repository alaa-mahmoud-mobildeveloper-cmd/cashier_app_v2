import 'package:cashier_app_v2/features/inventory/domain/entities/product_status.dart';
import 'package:flutter/material.dart';

import 'package:cashier_app_v2/core/constants/app_colors.dart';


/// الشكل البصري (الألوان) لكل حالة صنف. متعمول extension بدل ما يبقى
/// getter جوه enum الـ ProductStatus نفسه عشان الـ Domain entity يفضل
/// Dart خالص من غير أي اعتماد على Flutter أو ألوان الثيم.
extension ProductStatusStyle on ProductStatus {
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
}