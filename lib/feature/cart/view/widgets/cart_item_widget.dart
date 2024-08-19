import 'package:exercies4/common/components/app_icon_image.dart';
import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:exercies4/common/data/model/product_entity.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/feature/cart/controller/product_provider.dart';
import 'package:exercies4/feature/cart/view/widgets/cart_chose_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItemEntity objCart;
  const CartItemWidget({super.key, required this.objCart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProductEntity?> fetchProduct = ref.watch(productDetailProvider(objCart.productId));

    return Container(
      height: 100.h,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: fetchProduct.when(
          data: (objProduct) {
            if (objProduct == null) return const SizedBox();
            return Row(
              children: [
                AppImage(
                  imagePath: objProduct.imageUrl,
                  height: 60.w,
                  width: 70.w,
                  boxFit: BoxFit.contain,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      objProduct.name,
                      style: TextStyle(
                          color: AppColors.primaryElement,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    Text(
                      '${objProduct.price.toInt()} đồng',
                      style: TextStyle(
                          color: AppColors.primaryElement,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.red,)),
                  Expanded(child: CartChoseQuantity(quantity: objCart.quantity))
                ],),
              ],
            );
          },
          error: (e, s) => Center(
                child: Text('Error - $e'),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
