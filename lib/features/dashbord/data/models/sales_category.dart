import 'dart:ui';

class SalesCategory {
  final String name;
  final double totalSales;
  final Color color;

  const SalesCategory({
    required this.name,
    required this.totalSales,
    required this.color,
  });

  // أضف هذه الميثود
  factory SalesCategory.fromJson(Map<String, dynamic> json) {
    return SalesCategory(
      name: json['name'] as String? ?? '',
      totalSales: (json['totalSales'] as num?)?.toDouble() ?? 0.0,
      color: Color(int.parse(json['color'] as String? ?? '0xFFFFFFFF'))
    );
  }

  // وأضف هذه الميثود أيضاً
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'totalSales': totalSales,
      'color': '#${color.value.toRadixString(16)}'
    };
  }
}