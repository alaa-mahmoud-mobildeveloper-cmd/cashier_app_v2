class TopProduct {
  final int productId;
  final String productName;
  final String category;
  final int quantity;
  final double totalSales;
  final double profit;

  const TopProduct({
    required this.productId,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.totalSales,
    required this.profit,
  });
}