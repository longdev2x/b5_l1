import 'dart:async';

import 'package:exercies4/common/data/model/order_entity.dart';
import 'package:exercies4/feature/order/repos/order_repos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNotifier extends AsyncNotifier<List<OrderEntity>>{
  OrderNotifier() : super();
  @override
  FutureOr<List<OrderEntity>> build() {
    return _getAll();
  }

  Future<List<OrderEntity>> _getAll() async {
    return OrderRepos.getAll();
  }

  Future<void> addOrder(OrderEntity objOrder) async {
     print('zzz-01');
    //  print(state.value);
    // state = AsyncData([objOrder, ...state.value!]);
     print('zzz-02');

    try {
      OrderRepos.addOrder(objOrder);
       print('zzz-03');
    } on FirebaseException catch(e) {
      print('zzzok-$e');
      throw Exception(e);
    } finally {
      state = await AsyncValue.guard(() async => await _getAll());
    }
  }
}

final orderProvider = AsyncNotifierProvider<OrderNotifier, List<OrderEntity>>(() => OrderNotifier(),);