import 'package:exercies4/common/components/app_button.dart';
import 'package:exercies4/common/components/app_text_field.dart';
import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:exercies4/feature/cart/controller/cart_provider.dart';
import 'package:exercies4/feature/cart/view/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

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
          for (CartItemEntity objCart in carts) {
            total += objCart.quantity * objCart.price.toInt();
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return CartItemWidget(objCart: carts[index]);
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                          const Spacer(),
                          Text(
                            '$total đồng',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                        ],
                      ),
                      Text(
                        'Điền thông tin',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(height: 15.h),
                      AppTextField(
                        label: 'Tên',
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      AppTextField(
                        label: 'Địa chỉ',
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      AppTextField(
                        label: 'Số điện thoại',
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),
              AppButton(
                name: 'Mua ngay',
                ontap: () {},
              ),
              SizedBox(height: 25.h),
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
