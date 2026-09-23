import 'dart:async';

import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';

import '../../domain/repositories/product_repository.dart';

/// تنفيذ في الذاكرة لـ [ProductRepository]. ده اللي بيخلي الشاشة شغالة
/// دلوقتي من غير ما تستنى ربط قاعدة البيانات.
///
/// لما جدول Drift يكون جاهز، تقدر تستبدلها بـ DriftProductRepository
/// (شوف drift_product_repository.dart) من غير ما تغيّر حرف واحد في
/// الـ BLoC أو الشاشة، لأن الاتنين بيطبقوا نفس الـ interface.
///
/// كل الأصناف هنا بتتبنى بـ [ProductItem.fromCartonQuantity] عشان
/// الكمية بالوحدة تتحسب تلقائيًا من الكمية بالكرتونة أول مرة
/// (quantity = cartonQuantity × unitsPerCarton)، بالظبط زي ما هيحصل
/// وقت إضافة صنف حقيقي من الشاشة.
class InMemoryProductRepository implements ProductRepository {
  final List<ProductItem> _items = [
    ProductItem.fromCartonQuantity(
      id: '1',
      name: 'زيت عباد الشمس 1.5 لتر',
      barcode: '6001',
      category: 'مواد غذائية',
      sellPrice: 28,
      cartonPrice: 230,
      unitsPerCarton: 12,
      cartonQuantity: 4, // 4 × 12 = 48 وحدة (اتباع منها 3 وحدات لحد دلوقتي)
    ).sellUnits(3),
    ProductItem.fromCartonQuantity(
      id: '2',
      name: 'سكر أبيض 1 كجم',
      barcode: '6002',
      category: 'مواد غذائية',
      sellPrice: 12,
      cartonPrice: 155,
      unitsPerCarton: 20,
      cartonQuantity: 1, // 1 × 20 = 20 وحدة (اتباع منها 17 وحدة)
    ).sellUnits(17),
    ProductItem.fromCartonQuantity(
      id: '3',
      name: 'شاي ليبتون 100 كيس',
      barcode: '6003',
      category: 'مشروبات',
      sellPrice: 45,
      cartonPrice: 188,
      unitsPerCarton: 6,
      cartonQuantity: 1, // اتباعت كل الكرتونة، الصنف نفذ
    ).sellUnits(6),
    ProductItem.fromCartonQuantity(
      id: '4',
      name: 'أرز بسمتي 5 كجم',
      barcode: '6004',
      category: 'مواد غذائية',
      sellPrice: 85,
      cartonPrice: 235,
      unitsPerCarton: 4,
      cartonQuantity: 6, // 6 × 4 = 24 وحدة (اتباع منها وحدتين)
    ).sellUnits(2),
    ProductItem.fromCartonQuantity(
      id: '5',
      name: 'صابون اريل 3 كجم',
      barcode: '6005',
      category: 'منظفات',
      sellPrice: 55,
      cartonPrice: 224,
      unitsPerCarton: 6,
      cartonQuantity: 1, // 1 × 6 = 6 وحدات (اتباعت وحدة واحدة)
    ).sellUnits(1),
    ProductItem.fromCartonQuantity(
      id: '6',
      name: 'حليب بارمالات 1 لتر',
      barcode: '6006',
      category: 'ألبان',
      sellPrice: 18,
      cartonPrice: 152,
      unitsPerCarton: 12,
      cartonQuantity: 5, // 5 × 12 = 60 وحدة (لسه متباعش منها حاجة)
    ),
    ProductItem.fromCartonQuantity(
      id: '7',
      name: 'ماء معدني 1.5 لتر',
      barcode: '6007',
      category: 'مشروبات',
      sellPrice: 5,
      cartonPrice: 28,
      unitsPerCarton: 12,
      cartonQuantity: 10, // 10 × 12 = 120 وحدة (لسه متباعش منها حاجة)
    ),
  ];

  final _controller = StreamController<List<ProductItem>>.broadcast();

  InMemoryProductRepository() {
    _emit();
  }

  void _emit() => _controller.add(List.unmodifiable(_items));

  @override
  Stream<List<ProductItem>> watchProducts() => _controller.stream;

  @override
  Future<List<ProductItem>> getProducts() async => List.unmodifiable(_items);

  @override
  Future<void> addProduct(ProductItem product) async {
    _items.insert(0, product);
    _emit();
  }

  @override
  Future<void> updateProduct(ProductItem product) async {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index != -1) _items[index] = product;
    _emit();
  }

  @override
  Future<void> deleteProduct(String id) async {
    _items.removeWhere((p) => p.id == id);
    _emit();
  }

  void dispose() => _controller.close();
}