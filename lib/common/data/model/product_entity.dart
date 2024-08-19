import 'package:uuid/uuid.dart';

enum ProductCategory { shoes, clothes, book, light, other }

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final ProductCategory category;

  ProductEntity({
    String? id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  }) : id = id ?? const Uuid().v4();

  factory ProductEntity.fromJson(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: ProductCategory.values.firstWhere(
        (cate) => cate.name == map['category'],
        orElse: () => ProductCategory.other,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category.name
    };
  }
}
