import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel?> getProductByBarcode(String barcode);
  Future<void> updateStock(String productId, int newStock);
}

/// تنفيذ مبدئي بالذاكرة (In-Memory) - استبدله بـ drift/sqflite لاحقاً
/// من غير ما تغيّر أي حاجة في الطبقات التانية.
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final List<ProductModel> _fakeDb = [
    const ProductModel(id: '1', name: 'شاي ليبتون 100 كيس', price: 45, stock: 0, category: 'مشروبات'),
    const ProductModel(id: '2', name: 'سكر أبيض 1 كجم', price: 12, stock: 3, category: 'مواد غذائية'),
    const ProductModel(id: '3', name: 'زيت عباد الشمس 1.5 لتر', price: 28, stock: 45, category: 'مواد غذائية'),
    const ProductModel(id: '4', name: 'حليب بارمالات 1 لتر', price: 18, stock: 60, category: 'ألبان'),
    const ProductModel(id: '5', name: 'صابون اريال 3 كجم', price: 55, stock: 5, category: 'منظفات'),
    const ProductModel(id: '6', name: 'أرز بسمتي 5 كجم', price: 85, stock: 22, category: 'مواد غذائية'),
  ];

  @override
  Future<List<ProductModel>> getProducts() async => _fakeDb;

  @override
  Future<ProductModel?> getProductByBarcode(String barcode) async {
    try {
      return _fakeDb.firstWhere((p) => p.id == barcode);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateStock(String productId, int newStock) async {
    final index = _fakeDb.indexWhere((p) => p.id == productId);
    if (index == -1) throw DatabaseException('المنتج غير موجود');
    _fakeDb[index] = ProductModel(
      id: _fakeDb[index].id,
      name: _fakeDb[index].name,
      price: _fakeDb[index].price,
      stock: newStock,
      category: _fakeDb[index].category,
      imageUrl: _fakeDb[index].imageUrl,
    );
  }

  // ---- العمليات دي بيستخدمها فيتشر إدارة الأصناف (Inventory) ----
  // بتضيف/تعدل/تحذف من نفس المصدر المشترك عشان أي تغيير
  // يظهر فوراً في شاشة الكاشير كمان.

  void debugAddProduct(ProductModel product) {
    _fakeDb.add(product);
  }

  void debugUpdateProduct(ProductModel product) {
    final index = _fakeDb.indexWhere((p) => p.id == product.id);
    if (index == -1) {
      throw DatabaseException('المنتج غير موجود');
    }
    _fakeDb[index] = product;
  }

  void debugDeleteProduct(String productId) {
    _fakeDb.removeWhere((p) => p.id == productId);
  }
}
