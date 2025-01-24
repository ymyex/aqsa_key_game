class MCQInstructions {
  final String question;
  final List<String> options;
  final int answer;

  MCQInstructions({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory MCQInstructions.fromMap(Map<String, dynamic> map) {
    return MCQInstructions(
      question: map['question'] as String,
      options: List<String>.from(map['options']),
      answer: map['answer'] as int,
    );
  }
}
