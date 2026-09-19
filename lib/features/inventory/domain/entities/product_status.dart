/// حالة الصنف بناءً على الكمية المتاحة بالمخزون.
///
/// ملحوظة معمارية: الـ enum ده جوه Domain layer، فمفيش فيه أي حاجة
/// ليها علاقة بالـ UI (ألوان، أيقونات، ...). أي شكل بصري لكل حالة
/// (اللون مثلاً) موجود في presentation/utils/product_status_style.dart
/// عشان الـ Domain يفضل مستقل تمامًا عن Flutter.
enum ProductStatus {
  available,
  lowStock,
  outOfStock;

  String get label {
    switch (this) {
      case ProductStatus.available:
        return 'متوفر';
      case ProductStatus.lowStock:
        return 'قرب يخلص';
      case ProductStatus.outOfStock:
        return 'نفذ';
    }
  }

  /// بيحسب الحالة تلقائيًا من الكمية المتاحة.
  /// [lowStockThreshold]: أقل عدد وحدات قبل ما نعتبر الصنف "قرب يخلص".
  static ProductStatus fromQuantity(int quantity, {int lowStockThreshold = 10}) {
    if (quantity <= 0) return ProductStatus.outOfStock;
    if (quantity <= lowStockThreshold) return ProductStatus.lowStock;
    return ProductStatus.available;
  }
}

/// فلتر شاشة الأصناف (الكل / متوفر / قرب يخلص / نفذ).
enum ProductFilter {
  all,
  available,
  lowStock,
  outOfStock;

  String get label {
    switch (this) {
      case ProductFilter.all:
        return 'الكل';
      case ProductFilter.available:
        return 'متوفر';
      case ProductFilter.lowStock:
        return 'قرب يخلص';
      case ProductFilter.outOfStock:
        return 'نفذ';
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