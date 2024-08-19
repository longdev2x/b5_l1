import 'package:uuid/uuid.dart';

class CartItemEntity {
  final String id;
  final String userId;
  final String productId;
  int quantity;

  CartItemEntity({
    String? id,
    required this.userId,
    required this.productId,
    required this.quantity,
  }) : id = id ?? const Uuid().v4();

  CartItemEntity copyWith({int? quantity}) => CartItemEntity(
        id: id,
        userId: userId,
        productId: productId,
        quantity: quantity ?? this.quantity,
      );

  factory CartItemEntity.fromJson(Map<String, dynamic> map) {
    return CartItemEntity(
      id: map['id'] ?? '',
      userId: map['userId'],
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId' : userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
