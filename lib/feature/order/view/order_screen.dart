import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/feature/order/controller/order_provider.dart';
import 'package:exercies4/feature/order/view/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchOrders = ref.watch(orderProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'Danh Sách Đơn Hàng',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp, color: AppColors.primaryElement),
          ),
          SizedBox(height: 10.h),
          fetchOrders.when(
            data: (orders) {
              return Expanded(
                child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (ctx, index) {
                      return OrderItem(objOrder: orders[index]);
                    }),
              );
            },
            error: (error, stackTrace) {
              print('zzz-$error');
              return const Center(child: Text('Error'));
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
