import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';

class ActionButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Text? text;
  final int verticalPadding;
  final int radius;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.text,
    this.verticalPadding = 16,
    this.radius = 16,
  });
  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                AppColors.kPrimary1Color,
                AppColors.kPrimary2Color
              ]),
          borderRadius: BorderRadius.circular(radius.r), // Scaled border radius
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: verticalPadding.h),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
