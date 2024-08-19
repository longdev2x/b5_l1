import 'package:exercies4/common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartChoseQuantity extends StatelessWidget {
  final int quantity;
  const CartChoseQuantity({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            color: AppColors.primaryElement,
          ),
          Text(quantity.toString(), style: TextStyle(fontSize: 19.sp,color: AppColors.primaryElement, fontWeight: FontWeight.bold),),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove),
            color: AppColors.primaryElement,
          ),
        ],
      );
  }
}
