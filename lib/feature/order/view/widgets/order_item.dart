import 'package:exercies4/common/data/model/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItem extends StatelessWidget {
  final OrderEntity objOrder;
  const OrderItem({super.key, required this.objOrder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 16.h),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số sản phẩm: ${objOrder.items.length}',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Tổng tiền: ${objOrder.totalPrice.toInt()}đ',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Địa chỉ: ${objOrder.address}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trạng thái: ${objOrder.status}',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Thời gian: ${objOrder.dateFormat}',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
