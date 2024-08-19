import 'package:exercies4/common/components/app_icon_image.dart';
import 'package:exercies4/common/data/model/product_entity.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/common/utils/image_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  '${objProduct.price.toInt()} đồng',
                  style: TextStyle(
                      color: AppColors.primaryElement,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const AppIconAsset(path: ImageRes.icCart, iconColor: AppColors.primaryElement,),
                    label: const Text('Add To Cart', style: TextStyle(color: AppColors.primaryElement),),
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
