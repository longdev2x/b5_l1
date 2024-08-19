import 'package:uuid/uuid.dart';

class CartItemEntity {
  final String id;
  final String userId;
  final String productId;
  final double price;
  int quantity;

  CartItemEntity({
    String? id,
    required this.userId,
    required this.productId,
    required this.price,
    required this.quantity,
  }) : id = id ?? const Uuid().v4();

  CartItemEntity copyWith({int? quantity}) => CartItemEntity(
        id: id,
        userId: userId,
        price: price,
        productId: productId,
        quantity: quantity ?? this.quantity,
      );

  factory CartItemEntity.fromJson(Map<String, dynamic> map) {
    return CartItemEntity(
      id: map['id'] ?? '',
      userId: map['userId'],
      price: (map['price'] ?? 0.0).toDouble(),
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'price': price,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
