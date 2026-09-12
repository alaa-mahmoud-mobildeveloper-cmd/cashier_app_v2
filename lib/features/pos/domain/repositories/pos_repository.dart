import '../entities/product.dart';
import '../entities/invoice.dart';

abstract class PosRepository {
  Future<List<Product>> getProducts();
  Future<Product?> getProductByBarcode(String barcode);
  Future<Invoice> createInvoice({
    required List<InvoiceItem> items,
    required double discount,
    required double total,
    required String paymentMethod,
  });
}
