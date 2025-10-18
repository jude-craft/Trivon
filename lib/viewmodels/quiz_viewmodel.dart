import 'package:flutter/material.dart';
import 'dart:async';

import '../data/models/questions.dart';

class QuizViewModel extends ChangeNotifier {
  final List<Question> questions = [
    Question(
      questionText: 'What is a StatefulWidget in Flutter?',
      options: [
        'A widget that cannot change',
        'A widget that can change state over time',
        'A widget used only for animations',
        'A widget that is immutable',
      ],
      correctAnswerIndex: 1,
      category: 'Widgets',
    ),
    Question(
      questionText: 'Which method is called when a StatefulWidget is created?',
      options: [
        'build()',
        'initState()',
        'setState()',
        'dispose()',
      ],
      correctAnswerIndex: 1,
      category: 'Widgets',
    ),
    Question(
      questionText: 'What does setState() do?',
      options: [
        'Creates a new state object',
        'Notifies framework to rebuild the widget',
        'Disposes the widget',
        'Initializes the state',
      ],
      correctAnswerIndex: 1,
      category: 'Widgets',
    ),
    Question(
      questionText: 'What is the main purpose of dispose()?',
      options: [
        'To build the widget',
        'To initialize the state',
        'To clean up resources',
        'To update the UI',
      ],
      correctAnswerIndex: 2,
      category: 'Widgets',
    ),
    Question(
      questionText: 'Which of these is NOT a Dart data type?',
      options: [
        'String',
        'Dynamic',
        'Constant',
        'Boolean',
      ],
      correctAnswerIndex: 2,
      category: 'Dart',
    ),
    Question(
      questionText: 'What is a Column widget used for?',
      options: [
        'To arrange widgets horizontally',
        'To arrange widgets vertically',
        'To center widgets',
        'To create circular layouts',
      ],
      correctAnswerIndex: 1,
      category: 'Layouts',
    ),
    Question(
      questionText: 'Which layout widget arranges children horizontally?',
      options: [
        'Column',
        'Stack',
        'Row',
        'GridView',
      ],
      correctAnswerIndex: 2,
      category: 'Layouts',
    ),
    Question(
      questionText: 'What does the BuildContext do?',
      options: [
        'Builds widgets',
        'Holds information about the location of a widget',
        'Manages state',
        'Handles routing',
      ],
      correctAnswerIndex: 1,
      category: 'Widgets',
    ),
    Question(
      questionText: 'In Dart, what is a Future?',
      options: [
        'A type of widget',
        'A representation of an asynchronous operation',
        'A layout widget',
        'A lifecycle method',
      ],
      correctAnswerIndex: 1,
      category: 'Dart',
    ),
    Question(
      questionText: 'Which widget provides scrolling functionality?',
      options: [
        'Container',
        'ListView',
        'Row',
        'Stack',
      ],
      correctAnswerIndex: 1,
      category: 'Layouts',
    ),
  ];

  // State variables
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 15;
  int? _selectedAnswerIndex;
  bool _answered = false;
  bool _showResult = false;
  late Timer _timer;

  final List<Color> optionColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  // Getters
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get timeLeft => _timeLeft;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  bool get answered => _answered;
  bool get showResult => _showResult;

  Question get currentQuestion => questions[_currentQuestionIndex];
  int get totalQuestions => questions.length;
  int get percentage => ((score / totalQuestions) * 100).toInt();

  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;
  bool get isAnswerCorrect =>
      _selectedAnswerIndex == currentQuestion.correctAnswerIndex;

  // Timer management
  void startTimer() {
    _timeLeft = 15;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timeLeft--;
      notifyListeners();

      if (_timeLeft <= 0) {
        timer.cancel();
        handleTimeout();
      }
    });
  }

  void handleTimeout() {
    _showResult = true;
    _answered = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 2), nextQuestion);
  }

  // Answer handling
  void answerQuestion(int index) {
    if (_answered) return;

    _timer.cancel();
    _selectedAnswerIndex = index;
    _answered = true;
    _showResult = true;

    if (isAnswerCorrect) {
      _score++;
    }

    notifyListeners();
    Future.delayed(Duration(seconds: 2), nextQuestion);
  }

  // Navigation
  void nextQuestion() {
    _timer.cancel();

    if (!isLastQuestion) {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
      _answered = false;
      _showResult = false;
      notifyListeners();
      startTimer();
    } else {
      notifyListeners();
    }
  }

  // Reset quiz
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswerIndex = null;
    _answered = false;
    _showResult = false;
    notifyListeners();
    startTimer();
  }

  // Cleanup
  void disposeTimer() {
    _timer.cancel();
  }
}