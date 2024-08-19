import 'package:exercies4/common/components/app_icon_image.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/feature/application/controller/index_selected_provider.dart';
import 'package:exercies4/feature/application/view/widgets/bottom_navs.dart';
import 'package:exercies4/feature/application/view/widgets/screens.dart';
import 'package:exercies4/feature/home/controller/is_drawer_closed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexSelected = ref.watch(indexSelectedProvider);
    bool isDrawerClosed = ref.watch(isDrawerClosedProvider);
    return Scaffold(
      body: screens[indexSelected],
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: !isDrawerClosed
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 10.h),
                decoration: BoxDecoration(
                    color: AppColors.primaryBg.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(24.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      bottomNavs.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            ref.read(indexSelectedProvider.notifier).state =
                                index;
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedBar(isActive: indexSelected == index),
                              AppIconAsset(
                                path: bottomNavs[index].icon,
                                iconColor: Colors.white,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
