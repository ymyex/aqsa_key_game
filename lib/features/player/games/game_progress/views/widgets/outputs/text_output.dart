import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:aqsa_key_game/features/player/games/models/output_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextDisplayWidget extends StatelessWidget {
  final OutputModel outputModel;

  const TextDisplayWidget({
    super.key,
    required this.outputModel,
  });

  @override
  Widget build(BuildContext context) {
    // Validate the OutputModel
    if (outputModel.type != 'text' ||
        outputModel.data == null ||
        outputModel.data!.trim().isEmpty) {
      return _buildErrorWidget('Invalid or empty text data.');
    }

    // Extract the text to display
    String displayText = outputModel.data!;

    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kDarkGreyColor.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Center(
        child: SelectableText(
          displayText,
          style: getBoldStyle(
            fontSize: 16.sp,
            color: AppColors.kPrimaryColor,
          ),
        ),
      ),
    );
  }

  // Helper method to build error widgets
  Widget _buildErrorWidget(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kDarkGreyColor.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
