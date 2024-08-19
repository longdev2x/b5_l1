import 'package:exercies4/common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration appBoxShadow(
    {Color color = AppColors.primaryElement,
    double radius = 15,
    double bR = 2,
    double sR = 1,
    BoxBorder? boxBorder}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius.w),
    border: boxBorder,
    boxShadow: [
      BoxShadow(
        color: Colors.red.withOpacity(0.1),
        blurRadius: bR,
        spreadRadius: sR,
        offset: const Offset(0, 5),
      ),
    ],
  );
}
