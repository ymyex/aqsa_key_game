import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aqsa_key_game/features/player/games/models/input_model.dart';
import 'package:aqsa_key_game/features/player/games/models/mcq_instructions.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';

class MCQInput extends StatefulWidget {
  final InputModel inputModel;

  /// Whether the user is currently blocked from selecting options
  final bool blocked;

  const MCQInput({
    super.key,
    required this.inputModel,
    this.blocked = false,
  });

  @override
  MCQInputState createState() => MCQInputState();
}

class MCQInputState extends State<MCQInput> {
  MCQInstructions? mcqInstructions;

  /// Stores the user’s currently selected option index (null if none)
  int? selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    if (widget.inputModel.type == 'mcq_input' &&
        widget.inputModel.instructions is Map<String, dynamic>) {
      mcqInstructions = MCQInstructions.fromMap(widget.inputModel.instructions);
    }
  }

  /// Called by the parent to check correctness
  bool? isAnswerCorrect() {
    if (mcqInstructions == null || selectedOptionIndex == null) {
      return null; // e.g., no selection or invalid instructions
    }
    return selectedOptionIndex == mcqInstructions!.answer;
  }

  void _selectOption(int index) {
    if (widget.blocked) return; // ignore taps if blocked
    setState(() {
      selectedOptionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mcqInstructions == null) {
      return Text(
        'حدث خطأ ما',
        style: getMediumStyle(
            color: AppColors.kAccentRedColor, fontSize: FontSize.s14),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Display the question
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            mcqInstructions!.question,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),

        /// Display the options
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mcqInstructions!.options.length,
          itemBuilder: (context, index) {
            bool isSelected = (selectedOptionIndex == index);
            return GestureDetector(
              onTap: () => _selectOption(index),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.kPrimary1Color.withOpacity(0.1)
                      : AppColors.kWhiteColor,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.kPrimary1Color
                        : AppColors.kDarkGreyColor,
                    width: 1.5.w,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    /// Circle indicator
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.kPrimary1Color
                            : AppColors.kLightGreyColor,
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: AppColors.kWhiteColor,
                              size: 16.sp,
                            )
                          : null,
                    ),
                    SizedBox(width: 12.w),

                    /// Option text
                    Expanded(
                      child: Text(
                        mcqInstructions!.options[index],
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
