import 'package:flutter/material.dart';

import '../../data/models/questions.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCategoryBadge(),
        SizedBox(height: 16),
        _buildQuestionText(),
      ],
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber),
      ),
      child: Text(
        question.category,
        style: TextStyle(
          color: Colors.amber,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuestionText() {
    return Text(
      question.questionText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }
}