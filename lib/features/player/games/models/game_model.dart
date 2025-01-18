import 'package:aqsa_key_game/features/player/games/models/step_model.dart';

class GameModel {
  final String? title; // Made nullable
  final List<StepModel>? steps; // Nullable and list

  GameModel({
    this.title,
    this.steps,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      title: json['title'], // Now nullable
      steps: json['achievements'] != null
          ? List<StepModel>.from(json['steps']
              .map((x) => StepModel.fromJson(x)))
          : null,
    );
  }
}
