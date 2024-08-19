import 'package:exercies4/common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final double? height, width;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool isPass;
  final EdgeInsetsGeometry? padding;
  final String label;
  const AppTextField(
      {super.key,
      required this.label,
      this.isPass = false,
      this.padding,
      this.validator,
      this.controller,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPass,
        decoration: InputDecoration(
          contentPadding: padding,
          label: Text(label),
          border: _customBorder(color: AppColors.primarySecondaryElementText),
          errorBorder: _customBorder(color: Colors.red),
          enabledBorder:
              _customBorder(color: AppColors.primarySecondaryElementText),
          focusedBorder: _customBorder(color: Colors.black),
        ),
      ),
    );
  }

  InputBorder _customBorder({Color color = Colors.black}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color),
      );
}

class AppTextFieldOnly extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController? controller;
  final String hintText;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final bool obscureText;
  final bool? search;
  final bool? focus;
  final bool? readOnly;

  const AppTextFieldOnly(
      {super.key,
      this.height = 55,
      this.width = 280,
      this.controller,
      this.hintText = 'Type in your info',
      this.onChanged,
      this.onTap,
      this.readOnly = false,
      this.obscureText = false,
      this.focus = false,
      this.search = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: search == true ? TextInputAction.search : null,
        keyboardType: TextInputType.multiline,
        readOnly: readOnly ?? false,
        onTap: onTap,
        autofocus: focus ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7.h, left: 10.w),
          hintText: hintText,
          border: _outline(),
          enabledBorder: _outline(),
          focusedBorder: _outline(),
          disabledBorder: _outline(),
        ),
        maxLines: 1,
        autocorrect: false,
        obscureText: obscureText,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
      ),
    );
  }

  OutlineInputBorder _outline() => const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      );
}
