import 'package:flutter/material.dart';
import '../../viewmodels/quiz_viewmodel.dart';

class OptionButton extends StatelessWidget {
  final QuizViewModel viewModel;
  final int index;

  const OptionButton({
    super.key,
    required this.viewModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = viewModel.selectedAnswerIndex == index;
    bool isCorrect = index == viewModel.currentQuestion.correctAnswerIndex;
    bool showCorrectAnswer = viewModel.showResult && isCorrect;
    bool showWrongAnswer = viewModel.showResult && isSelected && !isCorrect;

    Color borderColor = Colors.white30;
    Color backgroundColor = Colors.transparent;
    double borderWidth = 2;

    if (showWrongAnswer) {
      borderColor = Colors.red;
      backgroundColor = Colors.red.withOpacity(0.2);
      borderWidth = 3;
    } else if (showCorrectAnswer) {
      borderColor = Colors.green;
      backgroundColor = Colors.green.withOpacity(0.2);
      borderWidth = 3;
    } else if (isSelected) {
      borderColor = viewModel.optionColors[index];
      backgroundColor = viewModel.optionColors[index].withOpacity(0.2);
      borderWidth = 3;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: viewModel.answered ? null : () => viewModel.answerQuestion(index),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: viewModel.optionColors[index],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    viewModel.currentQuestion.options[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (showCorrectAnswer)
                  Icon(Icons.check_circle, color: Colors.green, size: 28),
                if (showWrongAnswer)
                  Icon(Icons.cancel, color: Colors.red, size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}