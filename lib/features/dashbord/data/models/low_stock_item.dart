class LowStockItem {
  // افترض أن هذه هي المتغيرات لديك (قم بتعديلها حسب كودك الأصلي)
  final String id;
  final String name;
  final int quantity;

  const LowStockItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  /// أضف ميثود الـ fromJson هنا
  factory LowStockItem.fromJson(Map<String, dynamic> json) {
    return LowStockItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  /// وأضف ميثود الـ toJson هنا
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}