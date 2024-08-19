import 'package:exercies4/common/data/model/cart_entity.dart';

class OrderEntity {
  final String id;
  final String userId;
  final List<CartItemEntity> items;
  final double totalAmount;
  final DateTime dateTime;
  final String status;
  final String address;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
    required this.status,
    required this.address,
  });

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      items: List<CartItemEntity>.from(map['items']?.map((x) => CartItemEntity.fromJson(x)) ?? []),
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      dateTime: DateTime.parse(map['dateTime'] ?? DateTime.now().toIso8601String()),
      status: map['status'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((x) => x.toJson()).toList(),
      'totalAmount': totalAmount,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'address': address,
    };
  }
}