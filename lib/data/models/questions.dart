class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String category;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
  });
}