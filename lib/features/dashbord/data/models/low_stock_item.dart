enum StockStatus { nearingOut, critical }

class LowStockItem {
  final String name;
  final String remaining;
  final StockStatus status;

  const LowStockItem({
    required this.name,
    required this.remaining,
    required this.status,
  });
}
