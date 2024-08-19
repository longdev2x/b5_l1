import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/feature/cart/controller/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartChoseQuantity extends ConsumerWidget {
  final CartItemEntity objCart;
  const CartChoseQuantity({super.key, required this.objCart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              ref.read(cartProvider.notifier).addQuantity(objCart.id);
            },
            icon: const Icon(Icons.add),
            color: AppColors.primaryElement,
          ),
          Text(objCart.quantity.toString(), style: TextStyle(fontSize: 19.sp,color: AppColors.primaryElement, fontWeight: FontWeight.bold),),
          IconButton(
            onPressed: () {
              ref.read(cartProvider.notifier).minusQuantity(objCart.id);
            },
            icon: const Icon(Icons.remove),
            color: AppColors.primaryElement,
          ),
        ],
      );
  }
}
