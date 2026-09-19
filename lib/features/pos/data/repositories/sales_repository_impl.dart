import 'package:drift/drift.dart';
import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';
import 'package:cashier_app_v2/features/pos/domain/repositories/sales_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SalesRepository)
class SalesRepositoryImpl implements SalesRepository {
  final AppDatabase _db;

  SalesRepositoryImpl(this._db);

  @override
  Future<List<Product>> getAllProducts() async {
    return await _db.select(_db.products).get();
  }

  @override
  Future<Product?> getProductByBarcode(String barcode) async {
    final query = _db.select(_db.products)
      ..where((p) => p.barcode.equals(barcode));
    return await query.getSingleOrNull();
  }

  @override
  Future<int> checkout({
    required int userId,
    required List<CartItem> cartItems,
    required double discount,
    required double tax,
    required String paymentMethod,
    double? paidAmount,
  }) async {
    if (cartItems.isEmpty) {
      throw Exception('لا يمكن تنفيذ بيع بدون منتجات');
    }

    final subtotal = cartItems.fold<double>(
      0,
          (sum, item) => sum + item.totalPrice,
    );

    final netAmount = subtotal + tax - discount;
    final paid = paidAmount ?? netAmount;

    final invoiceNumber =
        'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    return await _db.transaction(() async {
      double totalProfit = 0;
      final products = <int, Product>{};

      for (final item in cartItems) {
        final product = await (_db.select(_db.products)
          ..where((p) => p.id.equals(item.product.id)))
            .getSingleOrNull();

        if (product == null) {
          throw Exception('المنتج غير موجود: ${item.product.name}');
        }
        if (product.stockQuantity < item.quantity) {
          throw Exception('المخزون غير كافي للمنتج ${product.name}');
        }

        products[product.id] = product;
        totalProfit +=
            (product.price - product.purchasePrice) * item.quantity;
      }

      final invoiceId = await _db.into(_db.invoices).insert(
        InvoicesCompanion.insert(
          invoiceNumber: invoiceNumber,
          userId: userId,
          totalAmount: subtotal,
          discount: Value(discount),
          tax: Value(tax),
          netAmount: netAmount,
          paidAmount: Value(paid),
          remainingAmount: Value(netAmount - paid),
          paymentMethod: Value(paymentMethod),
          profit: Value(totalProfit),
        ),
      );

      for (final item in cartItems) {
        final product = products[item.product.id]!;
        final itemProfit =
            (product.price - product.purchasePrice) * item.quantity;
        final itemTotal = product.price * item.quantity;

        await _db.into(_db.invoiceItems).insert(
          InvoiceItemsCompanion.insert(
            invoiceId: invoiceId,
            productId: product.id,
            productName: product.name,
            barcode: product.barcode,
            category: product.category,
            unit: product.unit,
            purchasePrice: product.purchasePrice,
            unitPrice: product.price,
            quantity: item.quantity,
            totalPrice: itemTotal,
            profit: Value(itemProfit),
          ),
        );

        await (_db.update(_db.products)
          ..where((p) => p.id.equals(product.id)))
            .write(
          ProductsCompanion(
            stockQuantity: Value(product.stockQuantity - item.quantity),
          ),
        );

        await _db.into(_db.stockMovements).insert(
          StockMovementsCompanion.insert(
            productId: product.id,
            userId: userId,
            quantity: -item.quantity,
            type: 'sale',
            note: Value('فاتورة $invoiceNumber'),
          ),
        );
      }

      return invoiceId;
    });
  }
}