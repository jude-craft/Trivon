import 'package:flutter/material.dart';
import '../../viewmodels/quiz_viewmodel.dart';

class QuizHeader extends StatelessWidget {
  final QuizViewModel viewModel;

  const QuizHeader({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuestionCounter(),
          _buildTimer(),
          _buildScore(),
        ],
      ),
    );
  }

  Widget _buildQuestionCounter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        'Q${viewModel.currentQuestionIndex + 1}/${viewModel.totalQuestions}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTimer() {
    return Container(
      decoration: BoxDecoration(
        color: viewModel.timeLeft <= 5 ? Colors.red : Colors.amber,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.timer, color: Colors.black, size: 18),
          SizedBox(width: 6),
          Text(
            '${viewModel.timeLeft} s',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScore() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        'Score: ${viewModel.score}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}