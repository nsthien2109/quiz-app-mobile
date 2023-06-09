import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/widgets/ResultItem.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Consumer<QuizProvider>(builder: (_, state, __) {
          return ListView.separated(
              itemBuilder: (context, index) => ResultItem(
                  quiz: state.quizs![index], result: state.yourAnswers[index]),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: state.quizs?.length ?? 0);
        }),
      ),
    );
  }
}
