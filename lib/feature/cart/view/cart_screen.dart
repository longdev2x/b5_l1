import 'package:exercies4/common/components/app_button.dart';
import 'package:exercies4/feature/cart/controller/cart_provider.dart';
import 'package:exercies4/feature/cart/view/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchCarts = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: fetchCarts.when(
          data: (carts) {
            if(carts.isEmpty)  {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Giỏ hàng trống', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.h),
                  AppButton(name: 'Mua hàng', ontap: () {
                    Navigator.of(context).pop();
                  },)
                ],
              );
            }
            return ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index) {
                return CartItemWidget(objCart: carts[index]);
              },
            );
          },
          error: (e, s) => Center(child: Text(e.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
