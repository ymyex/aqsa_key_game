import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aqsa_key_game/features/player/games/models/input_model.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';

class TextInput extends StatefulWidget {
  final InputModel inputModel;
  final bool blocked; // to disable text entry if blocked

  const TextInput({
    super.key,
    required this.inputModel,
    this.blocked = false,
  });

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  final TextEditingController _localController = TextEditingController();

  @override
  void dispose() {
    _localController.dispose();
    super.dispose();
  }

  /// Returns:
  ///   - `true` if the text matches a possibleAnswer
  ///   - `false` if the text is non-empty but doesn't match
  ///   - `null` if the text is empty
  bool? isAnswerCorrect() {
    final text = _localController.text.trim();

    // 1) If the user did not fill the field at all, return null
    if (text.isEmpty) {
      return null;
    }

    // 2) If there is no list of possibleAnswers, treat any non-empty input as correct
    if (widget.inputModel.possibleAnswers == null ||
        widget.inputModel.possibleAnswers!.isEmpty) {
      return true;
    }

    // 3) Otherwise, it must match one of the possible answers
    return widget.inputModel.possibleAnswers!.contains(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.inputModel.instructions != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              widget.inputModel.instructions.toString(),
              style: getRegularStyle(
                fontSize: FontSize.s16,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ),
        TextFormField(
          controller: _localController,
          readOnly: widget.blocked, // disable typing if blocked
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kWhiteColor,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 20.w,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColors.kDarkGreyColor,
                width: 1.5.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColors.kPrimary1Color,
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
