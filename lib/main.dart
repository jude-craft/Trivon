import 'package:flutter/material.dart';
import 'package:trivon/views/screens/home_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trivon',
      theme: ThemeData(
        useMaterial3: true
      ),
      home: HomeScreen(),
    );
  }
}