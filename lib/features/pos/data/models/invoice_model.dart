import '../../domain/entities/invoice.dart';
import '../../domain/entities/product.dart';
import 'product_model.dart';

class InvoiceItemModel extends InvoiceItem {
  const InvoiceItemModel({required super.product, required super.quantity});

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': ProductModel.fromEntity(product).toJson(),
        'quantity': quantity,
      };
}

class InvoiceModel extends Invoice {
  const InvoiceModel({
    required super.id,
    required super.items,
    required super.discount,
    required super.total,
    required super.paymentMethod,
    required super.createdAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] as String,
      items: (json['items'] as List)
          .map((e) => InvoiceItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items
            .map((e) => InvoiceItemModel(product: e.product, quantity: e.quantity).toJson())
            .toList(),
        'discount': discount,
        'total': total,
        'paymentMethod': paymentMethod,
        'createdAt': createdAt.toIso8601String(),
      };
}
