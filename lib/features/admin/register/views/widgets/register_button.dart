import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Gradient? gradient;
  final Text? text;

  const CreateAccountButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.gradient,
  });
  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16.r), // Scaled border radius
        ),
        width: double.infinity,
        height: 56.h,
        margin: EdgeInsets.only(left: 50.w, right: 50.w, top: 24.h),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
