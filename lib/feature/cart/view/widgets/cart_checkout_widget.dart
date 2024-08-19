import 'package:exercies4/common/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCheckoutWidget extends StatelessWidget {
  final int total;
  final Function() onTap;
  const CartCheckoutWidget({super.key, required this.total, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Row(children: [
            const Text('Total', style: TextStyle(fontWeight: FontWeight.bold),),
            const Spacer(),
            Text('$total đồng', style: const TextStyle(fontWeight: FontWeight.bold),),
          ],),
          SizedBox(height: 10.h),
          AppButton(ontap: onTap, name: 'Checkout'),
        ],),
      ),
    );
  }
}