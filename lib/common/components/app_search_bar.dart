import 'package:exercies4/common/components/app_decoration.dart';
import 'package:exercies4/common/components/app_icon_image.dart';
import 'package:exercies4/common/components/app_text_field.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/common/utils/image_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchBar extends StatelessWidget {
  final Function()? onTap;
  final Function(String value)? onChanged;
  final double width;
  final bool haveIcon;
  final bool? readOnly;
  final bool? focus;
  final String? hintText;
  const AppSearchBar({
    super.key,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.focus,
    this.width = 280,
    this.hintText = 'Tính năng bạn cần...',
    this.haveIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 17.h),
            width: width.w,
            height: 40.h,
            decoration: appBoxShadow(
                color: AppColors.primaryBackground,
                boxBorder: Border.all(color: AppColors.primaryElement)),
            child: Row(
              children: [
                const AppImage(imagePath: ImageRes.search),
                SizedBox(
                  width: 240.w,
                  height: 40.h,
                  child: AppTextFieldOnly(
                    focus: focus,
                    search: true,
                    onChanged: onChanged,
                    readOnly: readOnly,
                    onTap: onTap,
                    width: 240,
                    height: 40,
                    hintText: hintText ?? '',
                  ),
                ),
              ],
            ),
          ),
          if (haveIcon)
            Container(
              padding: EdgeInsets.all(8.w),
              width: 40.w,
              height: 40.h,
              decoration: appBoxShadow(
                boxBorder: Border.all(color: AppColors.primaryElement),
              ),
              child: const AppImage(
                imagePath: ImageRes.search,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
