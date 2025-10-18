import 'package:flutter/material.dart';
import '../../viewmodels/quiz_viewmodel.dart';

class FeedbackWidget extends StatelessWidget {
  final QuizViewModel viewModel;

  const FeedbackWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (!viewModel.showResult) {
      return SizedBox.shrink();
    }

    return AnimatedScale(
      scale: 1.2,
      duration: Duration(milliseconds: 500),
      child: Text(
        viewModel.isAnswerCorrect ? '✓ Correct!' : '✗ Wrong!',
        style: TextStyle(
          color: viewModel.isAnswerCorrect ? Colors.green : Colors.red,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: (viewModel.isAnswerCorrect ? Colors.green : Colors.red)
                  .withOpacity(0.5),
              blurRadius: 10,
            )
          ],
        ),
      ),
    );
  }
}