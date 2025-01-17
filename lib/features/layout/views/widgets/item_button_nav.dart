import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';

class ItemBottonNav extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onPressed;
  final bool selected;

  const ItemBottonNav({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Theme(
        data: ThemeData(
          highlightColor: AppColors.kTansparentColor,
          splashColor: AppColors.kPrimary2Color.withOpacity(.2),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: selected ? 2 : 0,
                child: Container(
                  width: 40.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            AppColors.kPrimary1Color,
                            AppColors.kPrimary2Color
                          ]),
                      borderRadius: BorderRadius.circular(8.r)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      // color: selected ? AppColors.BASE_COLOR : AppColors.GRAY,
                      width: 26.w,
                      height: 26.h,
                    ),
                    SizedBox(height: 8.h),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: selected
                            ? getBoldStyle(
                                fontSize: FontSize.s12,
                                color: AppColors.kPrimaryColor,
                              )
                            : getMediumStyle(
                                color: AppColors.kGreyColor,
                              ))
                  ],
                ),
              ),
              SizedBox(
                height: 14.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
