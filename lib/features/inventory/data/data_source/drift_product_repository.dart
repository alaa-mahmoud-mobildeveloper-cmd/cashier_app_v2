import 'package:cashier_app_v2/features/inventory/data/data_source/products_local_data_source.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'package:cashier_app_v2/core/database/app_database.dart';

import '../../domain/repositories/product_repository.dart';


/// تنفيذ [ProductRepository] فوق [ProductsLocalDataSource].
///
/// ملحوظة مهمة: عمود purchasePrice في جدول Products مستخدم فعليًا في
/// شاشة المبيعات (SalesRepositoryImpl) لحساب ربح الفاتورة، فمش بنشيله.
/// بدل كده، كل مرة نضيف أو نعدّل صنف من هنا، بنحسب سعر شراء الوحدة من
/// cartonPrice/unitsPerCarton ونخزنه في نفس عمود purchasePrice، عشان
/// شاشة المبيعات تفضل شغالة وتاخد رقم محدّث دايمًا.
@Injectable(as: ProductRepository)
class DriftProductRepository implements ProductRepository {
  final ProductsLocalDataSource _dataSource;

  DriftProductRepository(this._dataSource);

  @override
  Stream<List<ProductItem>> watchProducts() {
    return _dataSource.watchAll().map((rows) => rows.map(_toEntity).toList());
  }

  @override
  Future<List<ProductItem>> getProducts() async {
    final rows = await _dataSource.getAll();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<void> addProduct(ProductItem product) {
    return _dataSource.insert(_toCompanion(product));
  }

  @override
  Future<void> updateProduct(ProductItem product) {
    final id = int.tryParse(product.id);
    if (id == null) {
      // الـ id لسه مؤقت (اتحط في الفورم قبل ما الصنف يتحفظ فعليًا) —
      // مفيش صف حقيقي نعدّله عليه.
      return Future.value();
    }
    return _dataSource.update(id, _toCompanion(product));
  }

  @override
  Future<void> deleteProduct(String id) {
    final parsedId = int.tryParse(id);
    if (parsedId == null) return Future.value();
    return _dataSource.delete(parsedId);
  }

  ProductItem _toEntity(Product row) => ProductItem(
    id: row.id.toString(),
    name: row.name,
    barcode: row.barcode,
    category: row.category,
    sellPrice: row.price,
    cartonPrice: row.cartonPrice,
    unitsPerCarton: row.unitsPerCarton,
    quantity: row.stockQuantity,
  );

  /// بنحط purchasePrice = item.unitCost (المحسوبة تلقائيًا من
  /// cartonPrice/unitsPerCarton) عشان تفضل متزامنة مع نفس العمود اللي
  /// شاشة المبيعات بتقرا منه. باقي الأعمدة (unit, minStockLimit,
  /// isActive, imageUrl, ...) متعمدين مبنحطهاش هنا عشان .write() تسيبها
  /// زي ما هي من غير ما تتصفر.
  ProductsCompanion _toCompanion(ProductItem item) => ProductsCompanion(
    name: Value(item.name),
    barcode: Value(item.barcode),
    category: Value(item.category),
    price: Value(item.sellPrice),
    cartonPrice: Value(item.cartonPrice),
    unitsPerCarton: Value(item.unitsPerCarton),
    purchasePrice: Value(item.unitCost),
    stockQuantity: Value(item.quantity),
  );
}