import 'package:exercies4/common/components/app_button.dart';
import 'package:exercies4/common/components/app_text_field.dart';
import 'package:exercies4/common/data/model/cart_entity.dart';
import 'package:exercies4/common/data/model/order_entity.dart';
import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:exercies4/feature/cart/controller/cart_provider.dart';
import 'package:exercies4/feature/cart/view/widgets/cart_item_widget.dart';
import 'package:exercies4/feature/order/controller/order_provider.dart';
import 'package:exercies4/global.dart';
import 'package:exercies4/is_loader_provider.dart';
import 'package:exercies4/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int total = 0;
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fetchCarts = ref.watch(cartProvider);
    final bool isLoader = ref.watch(isLoaderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: fetchCarts.when(
        data: (carts) {
          if (carts.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Giỏ hàng trống',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                AppButton(
                  name: 'Mua hàng',
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          for (CartItemEntity objCart in carts) {
            total += objCart.quantity * objCart.price.toInt();
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Stack(
              children: [
                ListView.builder(
                  // shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CartItemWidget(objCart: carts[index]);
                  },
                ),
                Positioned(
                  bottom:  80.h,
                  left: 0,
                  right: 0,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                const Spacer(),
                                Text(
                                  '$total đồng',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                              ],
                            ),
                            Text(
                              'Điền thông tin',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            SizedBox(height: 15.h),
                            AppTextField(
                              label: 'Tên',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'vui lòng không bỏ trống';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15.h),
                            AppTextField(
                              label: 'Địa chỉ',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'vui lòng không bỏ trống';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15.h),
                            AppTextField(
                              label: 'Số điện thoại',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'vui lòng không bỏ trống';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: isLoader 
                    ? const Center(child: CircularProgressIndicator(),)
                    : AppButton(
                      name: 'Mua ngay',
                      ontap: () async {
                        if (!_formKey.currentState!.validate()) return;

                        OrderEntity objOrder = OrderEntity(
                          userId: Global.storageService.getUserId(),
                          items: carts,
                          totalPrice: total.toDouble(),
                          dateTime: DateTime.now(),
                          status: 'Đã mua',
                          name: _nameController.text.trim(),
                          address: _addressController.text.trim(),
                          phone: _phoneController.text.trim(),
                        );

                        ref.read(isLoaderProvider.notifier).state = true;
                        await ref
                            .read(orderProvider.notifier)
                            .addOrder(objOrder);
                        ref.read(isLoaderProvider.notifier).state = false;
                        navKey.currentState!.pushNamed(AppRouteName.order);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
