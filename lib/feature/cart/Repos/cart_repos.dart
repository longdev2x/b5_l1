import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:exercies4/common/data/model/product_entity.dart';
import 'package:exercies4/global.dart';

class CartRepos {
  static final FirebaseFirestore _fbStore = FirebaseFirestore.instance;

  static Future<List<CartItemEntity>> getAllCart() async {
    final querySnapshot = await _fbStore
        .collection('cart')
        .where('userId', isEqualTo: Global.storageService.getUserId())
        .get();
    return querySnapshot.docs
        .map((docRef) => CartItemEntity.fromJson(docRef.data()))
        .toList();
  }

  static Future<List<ProductEntity>> getAllProducts() async {
    final querySnapshot = await _fbStore.collection('product').get();

    return querySnapshot.docs
        .map((e) => ProductEntity.fromJson(e.data()))
        .toList();
  }

  static Future<ProductEntity?> getProductFollowId(String id) async {
    final docRef = await _fbStore.collection('product').doc(id).get();
    if (!docRef.exists) {
      return null;
    }
    return ProductEntity.fromJson(docRef.data()!);
  }

  static Future<void> addProduct(CartItemEntity objCartItem) async {
    final querySnapshot = await _fbStore
        .collection('cart')
        .where('userId', isEqualTo: Global.storageService.getUserId())
        .where('productId', isEqualTo: objCartItem.productId)
        .get();
    if (querySnapshot.docs.isEmpty) {
      await _fbStore
          .collection('cart')
          .doc(objCartItem.id)
          .set(objCartItem.toJson());
    } else {
      CartItemEntity oldObjCartItem =
          CartItemEntity.fromJson(querySnapshot.docs.first.data());
      int oldQuantity = oldObjCartItem.quantity;
      oldObjCartItem = oldObjCartItem.copyWith(quantity: oldQuantity + 1);

      await _fbStore
          .collection('cart')
          .doc(oldObjCartItem.id)
          .update(oldObjCartItem.toJson());
    }
  }

  static Future<void> updateQuantity(CartItemEntity objCartItem) async {
    final querySnapshot =
        await _fbStore.collection('cart').doc(objCartItem.id).get();
    if (!querySnapshot.exists) {
      return;
    } else {

      await _fbStore
          .collection('cart')
          .doc(objCartItem.id)
          .update(objCartItem.toJson());
    }
  }

  static Future<void> removeCartItem(String id) async {
    await _fbStore.collection('cart').doc('id').delete();
  }

  //1 lần

  static Future<void> uploadList(List<ProductEntity> products) async {
    final batch = _fbStore.batch();
    final collectionRef = _fbStore.collection('product');

    for (final product in products) {
      final docRef = collectionRef.doc(product.id);
      batch.set(docRef, product.toJson());
    }

    await batch.commit();
  }
}
