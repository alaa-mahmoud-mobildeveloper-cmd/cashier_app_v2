import 'package:uuid/uuid.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/pos_repository.dart';
import '../datasources/invoice_local_datasource.dart';
import '../datasources/product_local_datasource.dart';
import '../models/invoice_model.dart';

class PosRepositoryImpl implements PosRepository {
  final ProductLocalDataSource productLocalDataSource;
  final InvoiceLocalDataSource invoiceLocalDataSource;
  final Uuid uuid;

  PosRepositoryImpl({
    required this.productLocalDataSource,
    required this.invoiceLocalDataSource,
    required this.uuid,
  });

  @override
  Future<List<Product>> getProducts() => productLocalDataSource.getProducts();

  @override
  Future<Product?> getProductByBarcode(String barcode) =>
      productLocalDataSource.getProductByBarcode(barcode);

  @override
  Future<Invoice> createInvoice({
    required List<InvoiceItem> items,
    required double discount,
    required double total,
    required String paymentMethod,
  }) async {
    final invoice = InvoiceModel(
      id: uuid.v4(),
      items: items,
      discount: discount,
      total: total,
      paymentMethod: paymentMethod,
      createdAt: DateTime.now(),
    );
    await invoiceLocalDataSource.saveInvoice(invoice);

    // خصم الكمية من المخزون لكل منتج بيع
    for (final item in items) {
      final newStock = item.product.stock - item.quantity;
      await productLocalDataSource.updateStock(item.product.id, newStock < 0 ? 0 : newStock);
    }

    return invoice;
  }
}
