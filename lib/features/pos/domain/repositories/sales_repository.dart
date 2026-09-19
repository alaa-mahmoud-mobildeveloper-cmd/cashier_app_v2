import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/pos/data/models/cart_item_model.dart';


abstract class SalesRepository {
  Future<List<Product>> getAllProducts();

  Future<Product?> getProductByBarcode(String barcode);

  Future<int> checkout({
    required int userId,
    required List<CartItem> cartItems,
    required double discount,
    required double tax,
    required String paymentMethod,
    double? paidAmount,
  });
}