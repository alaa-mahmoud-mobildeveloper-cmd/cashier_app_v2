import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.stock,
    required super.category,
    super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'stock': stock,
        'category': category,
        'imageUrl': imageUrl,
      };

  factory ProductModel.fromEntity(Product p) => ProductModel(
        id: p.id,
        name: p.name,
        price: p.price,
        stock: p.stock,
        category: p.category,
        imageUrl: p.imageUrl,
      );
}
