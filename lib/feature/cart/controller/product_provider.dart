import 'package:exercies4/common/data/model/product_entity.dart';
import 'package:exercies4/feature/cart/Repos/cart_repos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productAllProvider = FutureProvider<List<ProductEntity>>((ref) async {
  return CartRepos.getAllProducts();
},);


final productDetailProvider = FutureProviderFamily<ProductEntity?, String>((ref, arg) async {
  return await CartRepos.getProductFollowId(arg);
},);
