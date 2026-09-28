import 'sales_invoice.dart';
import 'top_product.dart';

class SalesReport {
  final List<SalesInvoice> invoices;
  final List<TopProduct> topProducts;
  final double totalSales;
  final double totalProfit;
  final int invoiceCount;

  const SalesReport({
    required this.invoices,
    required this.topProducts,
    required this.totalSales,
    required this.totalProfit,
    required this.invoiceCount,
  });

  double get averageInvoice {
    if (invoiceCount == 0) {
      return 0;
    }

    return totalSales / invoiceCount;
  }
}