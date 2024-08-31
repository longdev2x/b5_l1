import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class OrderEntity {
  final String id;
  final String userId;
  final List<CartItemEntity> items;
  final double totalPrice;
  final DateTime dateTime;
  final String status;
  final String name;
  final String address;
  final String phone;

  OrderEntity({
    String? id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.dateTime,
    required this.status,
    required this.name,
    required this.address,
    required this.phone
  }) : id = id ?? const Uuid().v4();

  factory OrderEntity.fromJosn(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: json['items'] != null ? (json['items'] as List).map((e) => CartItemEntity.fromJson(e)).toList() : [],
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
      dateTime: DateTime.parse(json['dateTime'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? '',
      name: json['name'],
      address: json['address'] ?? '',
      phone: json['phone']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((x) => x.toJson()).toList(),
      'totalPrice': totalPrice,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'name' : name,
      'address': address,
      'phone' : phone,
    };
  }

  String get dateFormat {
    final format = DateFormat.yMd();
    return format.format(dateTime);
  }
}