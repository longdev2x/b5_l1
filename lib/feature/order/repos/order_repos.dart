import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercies4/common/data/model/order_entity.dart';

class OrderRepos {
  static final FirebaseFirestore _fbStore = FirebaseFirestore.instance;
  static Future<List<OrderEntity>> getAll() async {
    final queryS = await _fbStore.collection('order').get();
    if(queryS.docs.isEmpty) return [];
    return queryS.docs.map((e) {
      return OrderEntity.fromJosn(e.data());
    }).toList();
  }

  static Future<void> addOrder(OrderEntity objOrder) async {
    print('zzz-1');
    _fbStore.collection('order').doc(objOrder.id).set(objOrder.toJson());
     print('zzz-2');
  }
}