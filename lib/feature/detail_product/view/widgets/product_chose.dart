import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/feature/detail_product/controller/quantity_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductChoseQuantity extends ConsumerWidget {
  const ProductChoseQuantity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int quantity = ref.watch(quantityProductProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (quantity > 0) {
              ref.read(quantityProductProvider.notifier).state = quantity - 1;
            }
          },
          icon: const Icon(Icons.remove),
          color: AppColors.primaryElement,
        ),
        Text(
          quantity.toString(),
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primaryElement,
              fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            ref.read(quantityProductProvider.notifier).state = quantity + 1;
          },
          icon: const Icon(Icons.add),
          color: AppColors.primaryElement,
        ),
      ],
    );
  }
}
