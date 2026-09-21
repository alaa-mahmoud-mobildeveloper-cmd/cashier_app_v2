import 'package:equatable/equatable.dart';

import 'low_stock_item.dart';
import 'sales_category.dart';

class DashboardModel extends Equatable {
  final double todaySales;
  final double todayProfit;
  final int todayInvoices;
  final int todayCustomers;
  final List<double> weeklySales;
  final List<String> weekLabels;
  final List<SalesCategory> salesByCategory;
  final List<LowStockItem> lowStockItems;

  const DashboardModel({
    required this.todaySales,
    required this.todayProfit,
    required this.todayInvoices,
    required this.todayCustomers,
    required this.weeklySales,
    required this.weekLabels,
    required this.salesByCategory,
    required this.lowStockItems,
  });

  /// إنشاء نموذج فارغ للقيم الافتراضية
  factory DashboardModel.empty() {
    return const DashboardModel(
      todaySales: 0.0,
      todayProfit: 0.0,
      todayInvoices: 0,
      todayCustomers: 0,
      weeklySales: [0, 0, 0, 0, 0, 0, 0],
      weekLabels: [
        'السبت',
        'الأحد',
        'الاثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
      ],
      salesByCategory: [],
      lowStockItems: [],
    );
  }


  /// تحويل البيانات القادمة من JSON (API أو قاعدة بيانات)
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      todaySales: (json['todaySales'] as num?)?.toDouble() ?? 0.0,
      todayProfit: (json['todayProfit'] as num?)?.toDouble() ?? 0.0,
      todayInvoices: json['todayInvoices'] as int? ?? 0,
      todayCustomers: json['todayCustomers'] as int? ?? 0,
      weeklySales: (json['weeklySales'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [0, 0, 0, 0, 0, 0, 0],
      weekLabels: (json['weekLabels'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'],
      salesByCategory: (json['salesByCategory'] as List<dynamic>?)
          ?.map((e) => SalesCategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      lowStockItems: (json['lowStockItems'] as List<dynamic>?)
          ?.map((e) => LowStockItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  /// تحويل النموذج إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'todaySales': todaySales,
      'todayProfit': todayProfit,
      'todayInvoices': todayInvoices,
      'todayCustomers': todayCustomers,
      'weeklySales': weeklySales,
      'weekLabels': weekLabels,
      'salesByCategory': salesByCategory.map((e) => e.toJson()).toList(),
      'lowStockItems': lowStockItems.map((e) => e.toJson()).toList(),
    };
  }

  /// لعمل نسخ مع تعديل بعض الخصائص بسهولة (مفيد مع State Management)
  DashboardModel copyWith({
    double? todaySales,
    double? todayProfit,
    int? todayInvoices,
    int? todayCustomers,
    List<double>? weeklySales,
    List<String>? weekLabels,
    List<SalesCategory>? salesByCategory,
    List<LowStockItem>? lowStockItems,
  }) {
    return DashboardModel(
      todaySales: todaySales ?? this.todaySales,
      todayProfit: todayProfit ?? this.todayProfit,
      todayInvoices: todayInvoices ?? this.todayInvoices,
      todayCustomers: todayCustomers ?? this.todayCustomers,
      weeklySales: weeklySales ?? this.weeklySales,
      weekLabels: weekLabels ?? this.weekLabels,
      salesByCategory: salesByCategory ?? this.salesByCategory,
      lowStockItems: lowStockItems ?? this.lowStockItems,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    todaySales,
    todayProfit,
    todayInvoices,
    todayCustomers,
    weeklySales,
    weekLabels,
    salesByCategory,
    lowStockItems,
  ];
}