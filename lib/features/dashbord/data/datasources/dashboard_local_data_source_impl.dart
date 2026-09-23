import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/dashbord/data/datasources/dashboard_local_data_source.dart';
import 'package:cashier_app_v2/features/dashbord/data/models/dashboard_model.dart';
import 'package:cashier_app_v2/features/dashbord/data/models/low_stock_item.dart';
import 'package:cashier_app_v2/features/dashbord/data/models/sales_category.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: DashboardLocalDataSource)
class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final AppDatabase _db;

  DashboardLocalDataSourceImpl(this._db);

  @override
  Future<DashboardModel> getDashboard() async {
    return _buildDashboard();
  }

  @override
  Stream<DashboardModel> watchDashboardData() {
    return Rx.combineLatest2(
      _db.select(_db.invoices).watch(),
      _db.select(_db.products).watch(),
          (_, __) async* {},
    ).asyncMap((_) => _buildDashboard());
  }

  Future<DashboardModel> _buildDashboard() async {
    final now = DateTime.now();

    final todayStart = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final tomorrowStart = todayStart.add(
      const Duration(days: 1),
    );

    final sevenDaysAgo = todayStart.subtract(
      const Duration(days: 6),
    );

    final results = await Future.wait([
      _getTodaySales(
        todayStart,
        tomorrowStart,
      ),
      _getTodayProfit(
        todayStart,
        tomorrowStart,
      ),
      _getTodayInvoices(
        todayStart,
        tomorrowStart,
      ),
      _getTodayCustomers(
        todayStart,
        tomorrowStart,
      ),
      _getWeeklySales(
        sevenDaysAgo,
        tomorrowStart,
      ),
      _getSalesByCategory(
        todayStart,
        tomorrowStart,
      ),
      _getLowStockItems(),
    ]);

    return DashboardModel(
      todaySales: results[0] as double,
      todayProfit: results[1] as double,
      todayInvoices: results[2] as int,
      todayCustomers: results[3] as int,
      weeklySales: results[4] as List<double>,
      weekLabels: _buildWeekLabels(sevenDaysAgo),
      salesByCategory: results[5] as List<SalesCategory>,
      lowStockItems: results[6] as List<LowStockItem>,
    );
  }

  Future<double> _getTodaySales(
      DateTime start,
      DateTime end,
      ) async {
    final query = _db.selectOnly(_db.invoices)
      ..addColumns([
        _db.invoices.netAmount.sum(),
      ])
      ..where(
        _db.invoices.createdAt.isBiggerOrEqualValue(start) &
        _db.invoices.createdAt.isSmallerThanValue(end) &
        _db.invoices.status.equals('completed'),
      );

    final row = await query.getSingle();

    return row.read(
      _db.invoices.netAmount.sum(),
    ) ??
        0.0;
  }

  Future<double> _getTodayProfit(
      DateTime start,
      DateTime end,
      ) async {
    final query = _db.selectOnly(_db.invoices)
      ..addColumns([
        _db.invoices.profit.sum(),
      ])
      ..where(
        _db.invoices.createdAt.isBiggerOrEqualValue(start) &
        _db.invoices.createdAt.isSmallerThanValue(end) &
        _db.invoices.status.equals('completed'),
      );

    final row = await query.getSingle();

    return row.read(
      _db.invoices.profit.sum(),
    ) ??
        0.0;
  }

  Future<int> _getTodayInvoices(
      DateTime start,
      DateTime end,
      ) async {
    final query = _db.selectOnly(_db.invoices)
      ..addColumns([
        _db.invoices.id.count(),
      ])
      ..where(
        _db.invoices.createdAt.isBiggerOrEqualValue(start) &
        _db.invoices.createdAt.isSmallerThanValue(end) &
        _db.invoices.status.equals('completed'),
      );

    final row = await query.getSingle();

    return row.read(
      _db.invoices.id.count(),
    ) ??
        0;
  }

  Future<int> _getTodayCustomers(
      DateTime start,
      DateTime end,
      ) async {
    final query = _db.selectOnly(_db.invoices)
      ..addColumns([
        _db.invoices.customerId.count(
          distinct: true,
        ),
      ])
      ..where(
        _db.invoices.createdAt.isBiggerOrEqualValue(start) &
        _db.invoices.createdAt.isSmallerThanValue(end) &
        _db.invoices.status.equals('completed') &
        _db.invoices.customerId.isNotNull(),
      );

    final row = await query.getSingle();

    return row.read(
      _db.invoices.customerId.count(
        distinct: true,
      ),
    ) ??
        0;
  }

  Future<List<double>> _getWeeklySales(
      DateTime start,
      DateTime end,
      ) async {
    final invoices = await (_db.select(_db.invoices)
      ..where(
            (invoice) =>
        invoice.createdAt.isBiggerOrEqualValue(start) &
        invoice.createdAt.isSmallerThanValue(end) &
        invoice.status.equals('completed'),
      ))
        .get();

    final values = List<double>.filled(
      7,
      0.0,
    );

    for (final invoice in invoices) {
      final invoiceDate = DateTime(
        invoice.createdAt.year,
        invoice.createdAt.month,
        invoice.createdAt.day,
      );

      final difference = invoiceDate.difference(start).inDays;

      if (difference >= 0 && difference < 7) {
        values[difference] += invoice.netAmount;
      }
    }

    return values;
  }

  Future<List<SalesCategory>> _getSalesByCategory(
      DateTime start,
      DateTime end,
      ) async {
    final query = _db.select(_db.invoiceItems).join([
      innerJoin(
        _db.invoices,
        _db.invoices.id.equalsExp(
          _db.invoiceItems.invoiceId,
        ),
      ),
    ])
      ..where(
        _db.invoices.createdAt.isBiggerOrEqualValue(start) &
        _db.invoices.createdAt.isSmallerThanValue(end) &
        _db.invoices.status.equals('completed'),
      );

    final rows = await query.get();

    final totals = <String, double>{};

    for (final row in rows) {
      final item = row.readTable(
        _db.invoiceItems,
      );

      final category = item.category.trim().isEmpty
          ? 'أخرى'
          : item.category.trim();

      totals[category] =
          (totals[category] ?? 0.0) + item.totalPrice;
    }

    final entries = totals.entries.toList()
      ..sort(
            (a, b) => b.value.compareTo(a.value),
      );

    const colors = [
      Color(0xFFE0B52F),
      Color(0xFFF1CF4A),
      Color(0xFFB99424),
      Color(0xFF8F741C),
      Color(0xFF6F5A16),
    ];

    return List.generate(
      entries.length,
          (index) {
        final entry = entries[index];

        return SalesCategory(
          name: entry.key,
          color: colors[index % colors.length],
          totalSales: entry.value,
        );
      },
    );
  }

  Future<List<LowStockItem>> _getLowStockItems() async {
    final products = await (_db.select(_db.products)
      ..where(
            (product) =>
        product.isActive.equals(true) &
        product.stockQuantity.isSmallerOrEqual(
          product.minStockLimit,
        ),
      )
      ..orderBy([
            (product) => OrderingTerm(
          expression: product.stockQuantity,
        ),
      ]))
        .get();

    return products.map((product) {
      return LowStockItem(
        id: '${product.id}',
        name: product.name,
        quantity: product.stockQuantity,
      );
    }).toList();
  }

  List<String> _buildWeekLabels(DateTime start) {
    const labels = [
      'السبت',
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
    ];

    return List.generate(
      7,
          (index) {
        final date = start.add(
          Duration(days: index),
        );

        final saturdayBasedIndex =
            (date.weekday + 1) % 7;

        return labels[saturdayBasedIndex];
      },
    );
  }
}