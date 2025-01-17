import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconWithText extends StatelessWidget {
  final String iconPath;
  final String text;
  final TextStyle? textStyle;

  const IconWithText({
    super.key,
    required this.iconPath,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: textStyle ?? getRegularStyle(),
        ),
      ],
    );
  }
}
