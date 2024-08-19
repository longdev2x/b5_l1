import 'package:exercies4/common/utils/image_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomItem {
  final String name;
  final String icon;
  const BottomItem({
    required this.name,
    required this.icon,
  });
}

final bottomNavs = [
  const BottomItem(name: 'Home', icon: ImageRes.icHome),
  const BottomItem(name: 'Profile', icon: ImageRes.icProfile),
];


class AnimatedBar extends StatelessWidget {
  final bool isActive;
  const AnimatedBar({
    super.key,
    required this.isActive,
  });


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(bottom: 4.h),
      height: 4.w,
      width: isActive ? 20.w : 0,
      decoration: BoxDecoration(
        color: const Color(0xFF81B4FF),
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }
}