import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/core/shared/widgets/action_button.dart';
import 'package:aqsa_key_game/core/shared/widgets/custom_scaffold.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/helper/spacing.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:aqsa_key_game/features/player/games/cubit/games_cubit.dart';
import 'package:aqsa_key_game/features/player/games/models/input_model.dart';
import 'package:aqsa_key_game/features/player/games/models/output_model.dart';
import 'package:aqsa_key_game/features/player/games/models/step_model.dart';

// The custom input widgets
import 'package:aqsa_key_game/features/player/games/game_progress/views/widgets/inputs/mcq_input.dart';
import 'package:aqsa_key_game/features/player/games/game_progress/views/widgets/inputs/text_input.dart';

// The output widgets
import 'package:aqsa_key_game/features/player/games/game_progress/views/widgets/outputs/image_output.dart';
import 'package:aqsa_key_game/features/player/games/game_progress/views/widgets/outputs/text_output.dart';
import 'package:aqsa_key_game/features/player/games/game_progress/views/widgets/outputs/video_player_output.dart';

class StepPage extends StatefulWidget {
  final StepModel initialStepModel;
  final String category;
  final String gameName;
  final int initialStepIndex;

  const StepPage({
    super.key,
    required this.initialStepModel,
    required this.initialStepIndex,
    required this.category,
    required this.gameName,
  });

  @override
  StepPageState createState() => StepPageState();
}

class StepPageState extends State<StepPage> {
  late StepModel _currentStepModel;
  late int _currentStepIndex;

  /// Each input in this step is assigned a GlobalKey so we can call
  /// isAnswerCorrect() from the parent.
  final Map<int, GlobalKey> _inputKeys = {};

  /// Whether a particular input is blocked right now
  final Map<int, bool> _blockedStatus = {};

  /// Timers that will unblock the input after 30 seconds
  final Map<int, Timer?> _timers = {};

  bool isLoading = false;
  bool disabled = false;

  @override
  void initState() {
    super.initState();
    _loadStep(widget.initialStepModel, widget.initialStepIndex);
  }

  @override
  void dispose() {
    // Cancel all timers when leaving the screen
    for (var timer in _timers.values) {
      timer?.cancel();
    }
    super.dispose();
  }

  void _loadStep(StepModel stepModel, int stepIndex) {
    // Cancel any previous step's timers
    for (var timer in _timers.values) {
      timer?.cancel();
    }
    _timers.clear();
    _inputKeys.clear();
    _blockedStatus.clear();

    _currentStepModel = stepModel;
    _currentStepIndex = stepIndex;

    if (_currentStepModel.inputs != null) {
      for (int i = 0; i < _currentStepModel.inputs!.length; i++) {
        _inputKeys[i] = GlobalKey();
        _blockedStatus[i] = false; // default is unblocked

        // Attempt to restore any existing block from local storage
        final blockKey = 'block_${widget.gameName}_${stepIndex}_$i';
        final savedString = CacheHelper.getData(key: blockKey);
        if (savedString != null) {
          // If we saved a DateTime in ISO8601 form
          final savedEndTime = DateTime.tryParse(savedString);
          if (savedEndTime != null) {
            final now = DateTime.now();
            if (now.isBefore(savedEndTime)) {
              // We are still within the block period => remain blocked
              _blockedStatus[i] = true;

              final remaining = savedEndTime.difference(now).inSeconds;
              // Start a new timer for the remaining block duration
              _timers[i] = Timer(Duration(seconds: remaining), () {
                setState(() => _blockedStatus[i] = false);
                // Optionally remove from CacheHelper once unblocked
                CacheHelper.saveData(key: blockKey, value: null);
              });
            } else {
              // The block time has passed => no longer blocked
              CacheHelper.saveData(key: blockKey, value: null);
            }
          }
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onBack: () {
        // Make sure to pass back `true` so the caller knows to refresh
        Navigator.pop(context, true);
      },
      backgroundColor: AppColors.kbackgoundGreen,
      title: _currentStepModel.title ?? 'الخطوة',
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show any output items (images, videos, text, etc.)
            if (_currentStepModel.outputs != null)
              ..._currentStepModel.outputs!.map((output) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: _buildOutputWidget(output),
                );
              }),

            // Show any input items
            if (_currentStepModel.inputs != null)
              ...List.generate(_currentStepModel.inputs!.length, (index) {
                final input = _currentStepModel.inputs![index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: _buildInputWidget(input, index),
                );
              }),

            // "Next Step" button
            ActionButton(
              onTap: isLoading
                  ? null
                  : _currentStepModel.outputs == null
                      ? _handleNextStep
                      : _currentStepModel.outputs!
                                  .any((s) => s.type == "video") &&
                              !disabled
                          ? null
                          : _handleNextStep,
              color: _currentStepModel.outputs == null
                  ? ColorStyle.green
                  : _currentStepModel.outputs!.any((s) => s.type == "video") &&
                          !disabled
                      ? ColorStyle.white
                      : ColorStyle.green,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kWhiteColor,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'الخطوة التالية',
                          style: getExtraBoldStyle(
                            color: _currentStepModel.outputs == null
                                ? AppColors.kWhiteColor
                                : _currentStepModel.outputs!
                                            .any((s) => s.type == "video") &&
                                        !disabled
                                    ? AppColors.kBlackColor
                                    : AppColors.kWhiteColor,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        horizontalSpace(5),
                        Icon(
                          Icons.arrow_circle_left_outlined,
                          color: _currentStepModel.outputs == null
                              ? AppColors.kWhiteColor
                              : _currentStepModel.outputs!
                                          .any((s) => s.type == "video") &&
                                      !disabled
                                  ? AppColors.kBlackColor
                                  : AppColors.kWhiteColor,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputWidget(InputModel input, int index) {
    switch (input.type) {
      case 'text_input':
        return TextInput(
          key: _inputKeys[index],
          inputModel: input,
          blocked: _blockedStatus[index] ?? false,
        );
      case 'mcq_input':
        return MCQInput(
          key: _inputKeys[index],
          inputModel: input,
          blocked: _blockedStatus[index] ?? false,
        );
      default:
        return Text(
          'Unknown input type: ${input.type}',
          style: TextStyle(color: Colors.red, fontSize: 16.sp),
        );
    }
  }

  Widget _buildOutputWidget(OutputModel output) {
    switch (output.type) {
      case 'image':
        return ImageDisplayWidget(outputModel: output);
      case 'video':
        return VideoPlayerWidget(
          outputModel: output,
          onVideoComplete: () {
            setState(() {
              disabled = true;
            });
          },
        );
      case 'text':
        return TextDisplayWidget(outputModel: output);
      default:
        return Text(
          'Unknown output type: ${output.type}',
          style: TextStyle(color: Colors.red, fontSize: 16.sp),
        );
    }
  }

  /// Called when user presses "الخطوة التالية".
  /// We check if each input is correct. If any is wrong, block that input for 30s.
  /// Only if all are correct do we move on.
  Future<void> _handleNextStep() async {
    bool anyWrong = false;
    bool anyEmpty = false;

    if (_currentStepModel.inputs != null) {
      for (int i = 0; i < _currentStepModel.inputs!.length; i++) {
        final inputModel = _currentStepModel.inputs![i];
        final key = _inputKeys[i];
        if (key == null) continue;

        bool? correct;

        if (inputModel.type == 'text_input') {
          final textState = key.currentState as TextInputState?;
          if (textState == null) continue;
          correct = textState.isAnswerCorrect();
        } else if (inputModel.type == 'mcq_input') {
          final mcqState = key.currentState as MCQInputState?;
          correct = mcqState?.isAnswerCorrect();
        }

        // If correct == null, the user left it empty => not wrong, but also not answered
        if (correct == null) {
          anyEmpty = true;
        }
        // If correct == false, the user gave a wrong answer => block
        else if (correct == false) {
          anyWrong = true;
          _blockInput(i);
        }
      }
    }

    // 1) If any is empty => prompt user to fill first, but do NOT block
    if (anyEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الرجاء ملء جميع الحقول قبل المتابعة.',
            style: getMediumStyle(
                color: AppColors.kBlackColor, fontSize: FontSize.s14),
          ),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    // 2) If any is wrong => block for 30s, don't proceed
    if (anyWrong) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'يوجد إجابة خاطئة. حاول مجدداً بعد 30 ثانية.',
            style: getMediumStyle(
                color: AppColors.kWhiteColor, fontSize: FontSize.s14),
          ),
          backgroundColor: AppColors.kAccentRedColor,
        ),
      );
      return;
    }

    // 3) If we get here, no empties & no wrongs => everything is correct => proceed
    setState(() => isLoading = true);
    try {
      // 1) Mark the current step as completed
      await GamesCubit.get(context).markStepCompleted(
        _currentStepIndex,
        widget.gameName,
      );
      // 2) Retrieve updated data
      final updatedGames = GamesCubit.games;
      final updatedGame =
          updatedGames.firstWhere((g) => g.title == widget.gameName);

      final updatedPath = updatedGame.paths!.firstWhere(
        (p) => p.title == CacheHelper.getData(key: 'group_name'),
      );

      // 3) Find next uncompleted step
      final nextStepIndex = updatedPath.steps!.indexWhere(
        (s) => s.isCompleted == null || s.isCompleted == false,
      );

      if (nextStepIndex == -1) {
        // No more steps
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم إكمال جميع الخطوات!',
              style: getMediumStyle(color: AppColors.kBlackColor),
            ),
            backgroundColor: AppColors.kOffWhiteColor,
          ),
        );
        Navigator.pop(context, true);
      } else {
        final nextStep = updatedPath.steps![nextStepIndex];
        _loadStep(nextStep, nextStepIndex);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ ما'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// Blocks a single input from editing/selection for 30s.
  /// Persists the block end time in local storage.
  void _blockInput(int index) {
    setState(() => _blockedStatus[index] = true);

    final blockEndTime = DateTime.now().add(const Duration(seconds: 30));
    final blockKey = 'block_${widget.gameName}_${_currentStepIndex}_$index';
    // Save in local storage
    CacheHelper.saveData(key: blockKey, value: blockEndTime.toIso8601String());

    // Cancel any existing timer for this input, then start a new one
    _timers[index]?.cancel();
    const remainingSecs =
        30; // or blockEndTime.difference(DateTime.now()).inSeconds
    _timers[index] = Timer(const Duration(seconds: remainingSecs), () {
      setState(() => _blockedStatus[index] = false);
      // Optionally clear the local storage key
      CacheHelper.saveData(key: blockKey, value: null);
    });
  }
}
