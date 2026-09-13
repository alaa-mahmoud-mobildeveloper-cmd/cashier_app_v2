import 'package:cashier_app_v2/features/inventory/data/models/product_item.dart';
import 'package:cashier_app_v2/features/inventory/data/models/product_status.dart';
import 'package:cashier_app_v2/features/inventory/presentation/widgets/add_product_dialog.dart';
import 'package:flutter/material.dart';

import '../widgets/products_filter_bar.dart';
import '../widgets/products_header.dart';
import '../widgets/products_table.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  static const _allCategoriesLabel = 'كل الفئات';

  final List<String> _categories = const [
    'مواد غذائية',
    'مشروبات',
    'منظفات',
    'ألبان',
  ];

  // بيانات تجريبية مطابقة للتصميم
  final List<ProductItem> _products = [
    const ProductItem(
      id: '1',
      name: 'زيت عباد الشمس 1.5 لتر',
      barcode: '6001',
      category: 'مواد غذائية',
      sellPrice: 28,
      unitCost: 20.00,
      cartonPrice: 230,
      unitsPerCarton: 12,
      quantity: 45,
    ),
    const ProductItem(
      id: '2',
      name: 'سكر أبيض 1 كجم',
      barcode: '6002',
      category: 'مواد غذائية',
      sellPrice: 12,
      unitCost: 8.00,
      cartonPrice: 155,
      unitsPerCarton: 20,
      quantity: 3,
    ),
    const ProductItem(
      id: '3',
      name: 'شاي ليبتون 100 كيس',
      barcode: '6003',
      category: 'مشروبات',
      sellPrice: 45,
      unitCost: 32.00,
      cartonPrice: 188,
      unitsPerCarton: 6,
      quantity: 0,
    ),
    const ProductItem(
      id: '4',
      name: 'أرز بسمتي 5 كجم',
      barcode: '6004',
      category: 'مواد غذائية',
      sellPrice: 85,
      unitCost: 60.00,
      cartonPrice: 235,
      unitsPerCarton: 4,
      quantity: 22,
    ),
    const ProductItem(
      id: '5',
      name: 'صابون اريل 3 كجم',
      barcode: '6005',
      category: 'منظفات',
      sellPrice: 55,
      unitCost: 38.00,
      cartonPrice: 224,
      unitsPerCarton: 6,
      quantity: 5,
    ),
    const ProductItem(
      id: '6',
      name: 'حليب بارمالات 1 لتر',
      barcode: '6006',
      category: 'ألبان',
      sellPrice: 18,
      unitCost: 13.00,
      cartonPrice: 152,
      unitsPerCarton: 12,
      quantity: 60,
    ),
    const ProductItem(
      id: '7',
      name: 'ماء معدني 1.5 لتر',
      barcode: '6007',
      category: 'مشروبات',
      sellPrice: 5,
      unitCost: 2.50,
      cartonPrice: 28,
      unitsPerCarton: 12,
      quantity: 120,
    ),
  ];

  ProductFilter _selectedFilter = ProductFilter.all;
  String _selectedCategory = _allCategoriesLabel;
  String _searchQuery = '';

  List<ProductItem> get _filteredProducts {
    return _products.where((p) {
      final matchesFilter = _selectedFilter.matches(p.status);
      final matchesCategory =
          _selectedCategory == _allCategoriesLabel || p.category == _selectedCategory;
      final query = _searchQuery.trim();
      final matchesSearch = query.isEmpty ||
          p.name.contains(query) ||
          p.barcode.contains(query);
      return matchesFilter && matchesCategory && matchesSearch;
    }).toList();
  }

  Future<void> _openAddDialog({ProductItem? editing}) async {
    final result = await showDialog<ProductItem>(
      context: context,
      builder: (_) => AddProductDialog(
        categories: _categories,
        initial: editing,
      ),
    );

    if (result == null) return;

    setState(() {
      if (editing != null) {
        final index = _products.indexWhere((p) => p.id == editing.id);
        if (index != -1) _products[index] = result;
      } else {
        _products.insert(0, result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // خلفية الشاشة بتيجي من scaffoldBackgroundColor في AppTheme
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductsHeader(
                  itemsCount: _products.length,
                  onAddPressed: () => _openAddDialog(),
                ),
                const SizedBox(height: 20),
                ProductsFilterBar(
                  selectedFilter: _selectedFilter,
                  onFilterChanged: (f) => setState(() => _selectedFilter = f),
                  selectedCategory: _selectedCategory,
                  categories: [_allCategoriesLabel, ..._categories],
                  onCategoryChanged: (c) => setState(() => _selectedCategory = c),
                  onSearchChanged: (q) => setState(() => _searchQuery = q),
                ),
                const SizedBox(height: 20),
                ProductsTable(
                  items: _filteredProducts,
                  onEdit: (item) => _openAddDialog(editing: item),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
