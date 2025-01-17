import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/shared/widgets/shimmer_widget.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double? radius;
  final BoxShape boxShap;
  final String? errorImage;
  final BoxFit? boxfit;
  const CachedImage(
      {super.key,
      this.boxShap = BoxShape.circle,
      this.width = 55,
      this.height = 55,
      this.errorImage,
      this.boxfit,
      required this.url,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius:
              radius != null ? BorderRadius.circular(radius!.r) : null,
          shape: boxShap,
          image: DecorationImage(
            image: imageProvider,
            fit: boxfit ?? BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => boxShap == BoxShape.rectangle
          ? ShimmerWidget.circular(
              height: height.h,
              width: width.w,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius ?? 4.r),
                topRight: Radius.circular(radius ?? 4.r),
                bottomLeft: Radius.circular(radius ?? 4.r),
                bottomRight: Radius.circular(radius ?? 4.r),
              )),
            )
          : ShimmerWidget.circular(
              height: height.h,
              width: width.w,
            ),
      errorWidget: (context, url, error) => Container(
        color: radius == null ? AppColors.kPrimaryColor : null,
        decoration: radius != null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(radius!),
                color: AppColors.kPrimaryColor)
            : null,
        child: Image.asset(
          errorImage ?? AssetsData.placeholderImage,
          color: AppColors.kWhiteColor,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
