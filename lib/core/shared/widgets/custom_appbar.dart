import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';

class CustomAppbar extends StatelessWidget {
  final dynamic title;
  final bool showBackButton;
  final String? badgeName;
  final Function()? onBack;

  const CustomAppbar({
    super.key,
    required this.title,
    this.onBack,
    this.showBackButton = true,
    this.badgeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(16.w, 18.h, 24.w, badgeName != null ? 4.h : 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showBackButton)
                IconButton(
                  icon: SvgPicture.asset(AssetsData.backIcon),
                  onPressed: onBack ??
                      () {
                        Navigator.of(context).pop();
                      },
                ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12.h),
                  title is Widget
                      ? title
                      : Text(
                          title,
                          style: getExtraBoldStyle(
                            fontSize: FontSize.s20,
                          ),
                        ),
                  if (badgeName != null) SizedBox(height: 8.h),
                  if (badgeName != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.kMeduimPurpleColor,
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsData.badgeIcon),
                            SizedBox(width: 4.w),
                            Text(
                              badgeName!,
                              style: getMediumStyle(
                                color: AppColors.kWhiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              if (showBackButton) const SizedBox(width: 56),
            ],
          ),
        ],
      ),
    );
  }
}
