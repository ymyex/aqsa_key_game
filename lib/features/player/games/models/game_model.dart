import 'package:aqsa_key_game/features/player/games/models/path_model.dart';

class GameModel {
  final String? title; // Made nullable
  final List<PathModel>? paths; // Nullable and list

  GameModel({
    this.title,
    this.paths,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      title: json['title'], // Now nullable
      paths: json['paths'] != null
          ? List<PathModel>.from(
              json['paths'].map((x) => PathModel.fromJson(x)))
          : null,
    );
  }
}
