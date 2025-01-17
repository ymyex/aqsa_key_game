import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Define the enumeration
enum ColorStyle { green, white, red }

class ActionButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;
  final double verticalPadding;
  final double? horizontalPadding;
  final BorderRadiusGeometry? radius;
  final ColorStyle? color;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.child,
    this.verticalPadding = 16,
    this.radius,
    this.color = ColorStyle.green,
    this.horizontalPadding,
  });
  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: color == ColorStyle.green
                  ? <Color>[AppColors.kPrimary1Color, AppColors.kPrimary2Color]
                  : color == ColorStyle.white
                      ? <Color>[
                          AppColors.kWhiteColor,
                          AppColors.kAccentWhiteColor
                        ]
                      : <Color>[
                          AppColors.kAccentRedColor.withAlpha(200),
                          AppColors.kAccentRedColor,
                        ]),
          borderRadius:
              radius ?? BorderRadius.circular(16.r), // Scaled border radius
        ),
        width: horizontalPadding == null ? double.infinity : null,
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding.h, horizontal: horizontalPadding ?? 0),
        child: child,
      ),
    );
  }
}
