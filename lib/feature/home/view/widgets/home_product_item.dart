import 'package:exercies4/common/components/app_icon_image.dart';
import 'package:exercies4/common/data/model/product_entity.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/common/utils/image_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProductItem extends StatelessWidget {
  final ProductEntity objProduct;
  final Function() onItemTap;
  final Function() onCartTap;
  const HomeProductItem({super.key, required this.objProduct, required this.onItemTap, required this.onCartTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Hero(
            tag: objProduct.id,
            child: AppImage(
              imagePath: objProduct.imageUrl,
              boxFit: BoxFit.fitWidth,
              width: double.infinity,
              height: 100.w,
            ),
          ),
          SizedBox(height: 10.h),
          Text(objProduct.name, style: TextStyle(color: AppColors.primaryElement, fontWeight: FontWeight.bold, fontSize: 16.sp),),
          Text(objProduct.description, style: TextStyle(color: AppColors.primaryElement,fontWeight: FontWeight.w400, fontSize: 12.sp),),
          SizedBox(height: 8.h),
          Row(children: [
            Text('${objProduct.price.toInt()} đồng', style: TextStyle(color: AppColors.primaryElement,fontWeight: FontWeight.bold, fontSize: 12.sp),),
            const Spacer(),
            AppImage(onTap: onCartTap, imagePath: ImageRes.icCart, color: AppColors.primaryElement, height: 23.w, width: 23.w,),
          ],),
        ],),
      ),
    );
  }
}
