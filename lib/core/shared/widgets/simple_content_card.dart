import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/shared/widgets/cached_nework_image.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/helper/spacing.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';

class SimpleContentCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool moduleContentType;
  final String? leadingLabel;
  final double? progress;
  final Function()? onTap;
  const SimpleContentCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      this.moduleContentType = false,
      this.progress,
      this.leadingLabel,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: progress != null ? 184.h : 156.h,
        child: Stack(
          children: [
            ClipRRect(
              child: CachedImage(
                url: imageUrl,
                boxfit: BoxFit.cover,
                boxShap: BoxShape.rectangle,
                width: 144.w,
                height: 156.h,
                radius: moduleContentType ? 8.r : 16.r,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 134.w,
                  height: progress != null ? 84.h : 56.h,
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: progress != null ? 12 : 8),
                  decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(fontSize: FontSize.s14),
                        ),
                      ),
                      if (progress != null) verticalSpace(12),
                      if (progress != null)
                        SizedBox(
                          width: double.infinity,
                          child: LinearProgressIndicator(
                            value: progress ?? 0,
                            backgroundColor: AppColors.kLighterLightBlueColor,
                            color: AppColors.kPrimaryColor,
                            minHeight: 8.h,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (leadingLabel != null)
              Positioned.fill(
                top: 6,
                left: 6,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: leadingLabel == "Course"
                            ? AppColors.kMeduimPurpleColor
                            : AppColors.kMediumBlueColor,
                        borderRadius: BorderRadius.circular(40.r)),
                    child: Text(
                      leadingLabel ?? "",
                      textAlign: TextAlign.center,
                      style: getMediumStyle(color: AppColors.kWhiteColor),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
