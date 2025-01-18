class StepModel {
  final String? title; // Made nullable

  StepModel({
    this.title,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      title: json['title'], // Now nullable
    );
  }
}
