import 'package:aqsa_key_game/features/player/games/models/input_model.dart';
import 'package:aqsa_key_game/features/player/games/models/output_model.dart';

class StepModel {
  final String? title; // Made nullable
  final List<InputModel>? inputs; // Nullable and list
  final List<OutputModel>? outputs; // Nullable and list
  final bool? isCompleted; // Nullable and list

  StepModel({
    this.title,
    this.inputs,
    this.isCompleted,
    this.outputs,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
        title: json['title'], // Now nullable
        inputs: json['inputs'] != null
            ? List<InputModel>.from(
                json['inputs'].map((x) => InputModel.fromJson(x)))
            : null,
        outputs: json['outputs'] != null
            ? List<OutputModel>.from(
                json['outputs'].map((x) => OutputModel.fromJson(x)))
            : null,
        isCompleted: json['completed']);
  }
}
