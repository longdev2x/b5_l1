import 'dart:async';

import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:exercies4/common/data/model/product_entity.dart';
import 'package:exercies4/feature/cart/Repos/cart_repos.dart';
import 'package:exercies4/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends AutoDisposeAsyncNotifier<List<CartItemEntity>> {
  CartNotifier() : super();

  @override
  FutureOr<List<CartItemEntity>> build() {
    return _fetchCarts();
  }

  Future<List<CartItemEntity>> _fetchCarts() async {
    return CartRepos.getAllCart();
  }

  Future<void> addCartItem(ProductEntity objProduct, int quantity) async {
    CartItemEntity objCartItem = CartItemEntity(
        userId: Global.storageService.getUserId(),
        price: objProduct.price,
        productId: objProduct.id,
        quantity: quantity);

    // if (state.value != null) {
    //   state = AsyncData([objCartItem, ...state.value!]);
    // } else {
    //   state = AsyncData([objCartItem]);
    // }

    try {
      await CartRepos.addProduct(objCartItem, quantity);
    } on FirebaseException catch (e) {
      throw Exception(e);
    } finally {
      state = await AsyncValue.guard(() async => await _fetchCarts());
    }
  }

  Future<void> addQuantity(String cartId) async {
    CartItemEntity? objCartItem =
        state.asData?.value.firstWhere((e) => e.id == cartId);
    if (objCartItem == null) return;

    objCartItem = objCartItem.copyWith(quantity: objCartItem.quantity + 1);

    _refershStateQuantity(objCartItem);
  }

  Future<void> minusQuantity(String cartId) async {
    CartItemEntity? objCartItem =
        state.asData?.value.firstWhere((e) => e.id == cartId);
    if (objCartItem == null) return;
    if (objCartItem.quantity < 0) return;

    objCartItem = objCartItem.copyWith(quantity: objCartItem.quantity - 1);

    _refershStateQuantity(objCartItem);
  }

  Future<void> updateQuantity(String cartId, int quantity) async {
    CartItemEntity? objCartItem =
        state.asData?.value.firstWhere((e) => e.id == cartId);
    if (objCartItem == null) return;

    objCartItem = objCartItem.copyWith(quantity: quantity);

    _refershStateQuantity(objCartItem);
  }

  Future<void> _refershStateQuantity(CartItemEntity objCartItem) async {
    //Update Local
    state = AsyncData(state.value!.map((e) {
      if (e.id == objCartItem.id) {
        e = objCartItem;
      }
      return e;
    }).toList());
    //Update sever 
    try {
      await CartRepos.updateQuantity(objCartItem);
    } on FirebaseException catch (e) {
      throw Exception(e);
    } finally {
      // state = await AsyncValue.guard(() async => await _fetchCarts());
    }
  }
}

final cartProvider =
    AsyncNotifierProvider.autoDispose<CartNotifier, List<CartItemEntity>>(
  () => CartNotifier(),
);
