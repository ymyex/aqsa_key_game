class InputModel {
  final String? type; // Made nullable
  final List<String>? possibleAnswers; // Nullable and list
  final dynamic instructions; // Made nullable

  InputModel({
    this.type,
    this.possibleAnswers,
    this.instructions,
  });

  factory InputModel.fromJson(Map<String, dynamic> json) {
    return InputModel(
        type: json['type'], // Now nullable
        possibleAnswers: json['possible_answers'] != null
            ? List<String>.from(
                json['possible_answers']) // Convert to List<String>
            : null, // Hand
        instructions: json['instructions']);
  }
}
