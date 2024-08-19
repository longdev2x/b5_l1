import 'package:exercies4/common/components/app_icon_image.dart';
import 'package:exercies4/common/components/app_search_bar.dart';
import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:exercies4/common/utils/image_res.dart';
import 'package:exercies4/feature/cart/controller/cart_provider.dart';
import 'package:exercies4/feature/cart/controller/product_provider.dart';
import 'package:exercies4/feature/home/controller/is_drawer_closed.dart';
import 'package:exercies4/feature/home/view/widgets/home_drawer_widget.dart';
import 'package:exercies4/feature/home/view/widgets/home_product_item.dart';
import 'package:exercies4/is_loader_provider.dart';
import 'package:exercies4/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchProducts = ref.watch(productAllProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          AppImage(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouteName.cart);
            },
            imagePath: ImageRes.icCart,
            height: 33.w,
            width: 33.w,
            // color: AppColors.primaryElement,
          ),
          SizedBox(width: 12.w),
        ],
      ),
      drawer: const HomeDrawerWidget(),
      onDrawerChanged: (isOpened) {
        ref.read(isDrawerClosedProvider.notifier).state = !isOpened;
      },
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchBar(
              onTap: () {},
              hintText: 'Sản phẩm cần tìm?',
            ),
            SizedBox(height: 10.h),
            Text(
              'Category',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(height: 5.h),
            fetchProducts.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Center(
                    child: Text('Hiện chưa có sản phẩm'),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: products.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.w,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (ctx, index) => HomeProductItem(
                      objProduct: products[index],
                      onItemTap: () {
                        Navigator.of(context).pushNamed(
                            AppRouteName.detailProduct,
                            arguments: products[index]);
                      },
                      onCartTap: () async {
                        ref.read(isLoaderProvider.notifier).state = true;
                        await ref
                            .read(cartProvider.notifier)
                            .addCartItem(products[index].id);
                        ref.read(isLoaderProvider.notifier).state = false;
                        navKey.currentState!.pushNamed(AppRouteName.cart);
                      },
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => const Center(
                child: Text('Error'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
