import 'package:flutter/material.dart';
import 'package:trivon/core/routes/app_routes.dart';
import '../../provider/change_notifier_provider.dart';
import '../../viewmodels/quiz_viewmodel.dart';
import '../widgets/quiz_header.dart';
import '../widgets/question_widget.dart';
import '../widgets/option_button.dart';
import '../widgets/feedback_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late QuizViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = QuizViewModel();
    viewModel.startTimer();
  }

  @override
  void dispose() {
    viewModel.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizViewModel>(
      create: (_) => viewModel,
      builder: (context, vm, child) {
        if (vm.answered && vm.isLastQuestion) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.result,
              (route) => false,
              arguments: {'score': vm.score, 'total': vm.totalQuestions},
            );
          });
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.cyan.shade600, Colors.teal.shade400],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  QuizHeader(viewModel: vm),
                  LinearProgressIndicator(
                    value: (vm.currentQuestionIndex + 1) / vm.totalQuestions,
                    minHeight: 6,
                    backgroundColor: Colors.white30,
                    valueColor: AlwaysStoppedAnimation(Colors.amber),
                  ),
                  Expanded(
                    child: _buildQuestionContent(vm),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionContent(QuizViewModel vm) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuestionWidget(question: vm.currentQuestion),
          _buildOptions(vm),
          FeedbackWidget(viewModel: vm),
        ],
      ),
    );
  }

  Widget _buildOptions(QuizViewModel vm) {
    return Column(
      children: List.generate(
        vm.currentQuestion.options.length,
        (index) => OptionButton(
          viewModel: vm,
          index: index,
        ),
      ),
    );
  }
}