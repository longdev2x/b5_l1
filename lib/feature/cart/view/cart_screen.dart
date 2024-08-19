import 'package:exercies4/common/components/app_button.dart';
import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:exercies4/feature/cart/controller/cart_provider.dart';
import 'package:exercies4/feature/cart/view/widgets/cart_checkout_widget.dart';
import 'package:exercies4/feature/cart/view/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int total = 0;
    final fetchCarts = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: fetchCarts.when(
        data: (carts) {
          if (carts.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Giỏ hàng trống',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                AppButton(
                  name: 'Mua hàng',
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          for(CartItemEntity objCart in carts) {
            total += objCart.quantity * objCart.price.toInt();
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(objCart: carts[index]);
                    },
                  ),
                ),
              ),
              CartCheckoutWidget(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRouteName.checkOut);
                },
                total: total,
              )
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
