import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercies4/common/utils/image_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIconData extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? iconColor;
  const AppIconData({
    super.key,
    required this.icon,
    this.size = 50,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size!.w,
      width: size!.w,
      child: Icon(icon),
    );
  }
}

class AppIconAsset extends StatelessWidget {
  final String? path;
  final double? size;
  final Color? iconColor;
  final Function()? onTap;
  const AppIconAsset(
      {super.key,
      required this.path,
      this.size = 26,
      this.iconColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size!.w,
        child: Image.asset(
          path ?? ImageRes.icProfile,
          color: iconColor,
        ),
      ),
    );
  }
}

class AppImage extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;
  final Function()? onTap;
  final BoxFit? boxFit;
  final Color? color;

  const AppImage(
      {super.key,
      this.imagePath = ImageRes.icProfile,
      this.width = 16,
      this.height = 16,
      this.onTap,
      this.color,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath ?? ImageRes.icProfile,
        width: width.w,
        height: height.h,
        fit: boxFit,
        color: color,
      ),
    );
  }
}

class AppCachedNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final BoxFit boxFit;
  final String? title;
  final String? subTitle;
  final void Function()? onTap;

  const AppCachedNetworkImage(
      {super.key,
      this.width = 40,
      this.height = 40,
      this.boxFit = BoxFit.fitWidth,
      this.onTap,
      this.title,
      this.subTitle,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: height.h,
            width: width.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              image: DecorationImage(fit: boxFit, image: imageProvider),
            ),
          );
        },
        placeholder: (context, url) => SizedBox(
            height: 20.h,
            width: 20.h,
            child: const Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => const Center(child: Text('Error')),
      ),
    );
  }
}
