import 'package:aqsa_key_game/features/player/games/models/step_model.dart';

class PathModel {
  final String? title; // Made nullable
  final List<StepModel>? steps; // Nullable and list

  PathModel({
    this.title,
    this.steps,
  });

  factory PathModel.fromJson(Map<String, dynamic> json) {
    return PathModel(
      title: json['title'], // Now nullable
      steps: json['steps'] != null
          ? List<StepModel>.from(
              json['steps'].map((x) => StepModel.fromJson(x)))
          : null,
    );
  }
}
