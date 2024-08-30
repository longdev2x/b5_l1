import 'package:exercies4/common/components/app_icon_image.dart';
import 'package:exercies4/common/components/loader_provider.dart';
import 'package:exercies4/common/data/model/product_entity.dart';
import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/common/utils/image_res.dart';
import 'package:exercies4/feature/cart/controller/cart_provider.dart';
import 'package:exercies4/feature/detail_product/controller/quantity_product_entity.dart';
import 'package:exercies4/feature/detail_product/view/widgets/product_chose.dart';
import 'package:exercies4/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailProductScreen extends ConsumerWidget {
  const DetailProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoader = ref.watch(isLoaderProvider);
    final int quantity = ref.watch(quantityProductProvider);
    final ProductEntity objProduct =
        ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      appBar: AppBar(
        title: Text(objProduct.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: objProduct.id,
                    child: AppImage(
                      imagePath: objProduct.imageUrl,
                      width: double.infinity,
                      height: 300.w,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          objProduct.name,
                          style: TextStyle(
                              color: AppColors.primaryElement,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp),
                        ),
                        Text(
                          objProduct.description,
                          style: TextStyle(
                              color: AppColors.primaryElement,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Số lượng',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        const ProductChoseQuantity(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  '${(objProduct.price * quantity).toInt()} đồng',
                  style: TextStyle(
                      color: AppColors.primaryElement,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
                const Spacer(),
                isLoader
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            ref
                                .read(cartProvider.notifier)
                                .addCartItem(objProduct, quantity);
                            ref.read(isLoaderProvider.notifier).state = true;
                            await ref
                                .read(cartProvider.notifier)
                                .addCartItem(objProduct, quantity);
                            ref.read(isLoaderProvider.notifier).state = false;
                            navKey.currentState!.pushNamed(AppRouteName.cart);
                          },
                          icon: const AppIconAsset(
                            path: ImageRes.icCart,
                            iconColor: AppColors.primaryElement,
                          ),
                          label: const Text(
                            'Add To Cart',
                            style: TextStyle(color: AppColors.primaryElement),
                          ),
                        ),
                      ),
                SizedBox(width: 10.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
