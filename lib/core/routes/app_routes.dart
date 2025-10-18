import 'package:flutter/material.dart';

import '../../views/screens/home_screen.dart';
import '../../views/screens/quiz_screen.dart';
import '../../views/screens/result_screen.dart';


class AppRoutes {
  static const String home = '/';
  static const String quiz = '/quiz';
  static const String result = '/result';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case quiz:
        return MaterialPageRoute(
          builder: (_) => const QuizScreen(),
        );
      case result:
        final args = settings.arguments as Map<String, int>?;
        return MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: args?['score'] ?? 0,
            totalQuestions: args?['total'] ?? 10,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}