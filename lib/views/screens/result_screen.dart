import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  int get percentage => ((score / totalQuestions) * 100).toInt();

  String get message => percentage >= 80
      ? '🎉 Outstanding!'
      : percentage >= 60
          ? '👍 Good Job!'
          : '💪 Keep Practicing!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.cyan.shade600, Colors.teal.shade400],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTrophyIcon(),
              SizedBox(height: 32),
              _buildTitle(),
              SizedBox(height: 16),
              _buildMessage(),
              SizedBox(height: 32),
              _buildScoreCard(),
              SizedBox(height: 48),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrophyIcon() {
    return AnimatedScale(
      scale: 1.0,
      duration: Duration(milliseconds: 800),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(70),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.5),
              blurRadius: 30,
              spreadRadius: 5,
            )
          ],
        ),
        child: Icon(
          Icons.emoji_events,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Quiz Completed!',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMessage() {
    return Text(
      message,
      style: TextStyle(
        color: Colors.amber,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '$score / $totalQuestions',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '$percentage%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.white),
            ),
          ),
          icon: Icon(Icons.home, color: Colors.white),
          label: Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.quiz,
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Icon(Icons.refresh, color: Colors.black),
          label: Text(
            'Retake',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}