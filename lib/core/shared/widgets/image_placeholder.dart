import 'package:flutter/material.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';

class ImagePlaceholder extends StatelessWidget {
  final double width;
  final double height;

  const ImagePlaceholder({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Image.asset(
        AssetsData.placeholderImage,
        color: AppColors.kWhiteColor,
        fit: BoxFit.cover,
      ),
    );
  }
}
