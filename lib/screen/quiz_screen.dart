import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/utils/theme.dart';
import 'package:quiz_app/widgets/QuitAlert.dart';
import 'package:quiz_app/widgets/RadioButton.dart';
import 'package:quiz_app/widgets/ResultAlert.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (__, state, _) {
      //init
      // display current question index  (1/5)
      int currentQuestion = state.quizIndex + 1;
      int totalQuestion = state.quizs!.length; // display total question
      QuizModel currentQuiz = state.currentQuestion; // current quiz
      int letterIndex = 0; // get letters to show A,B,C,D

      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return QuitAlert(onExit: () {
                      Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false)
                          .then((value) => state.resetState());
                    });
                  });
            },
          ),
          iconTheme: const IconThemeData(color: AppColors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  state.getFormattedTime(state.totalTime),
                  style: const TextStyle(color: AppColors.white, fontSize: 13),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Question $currentQuestion/$totalQuestion",
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 20)),
                const SizedBox(height: 30),
                Text("${currentQuiz.questionText}",
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 25)),
                const SizedBox(height: 40),
                ListView(
                  shrinkWrap: true,
                  children: [
                    ...currentQuiz.answers!.map((answer) {
                      letterIndex++;
                      return RadioButton(
                        selectedValue: state.selectedValue,
                        radioId: answer.answerId,
                        value: String.fromCharCode(65 + letterIndex - 1),
                        answerTitle: "${answer.answerText}",
                        onChanged: () {
                          state.onChangedRadio(answer);
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.second), // Set the background color
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set the text color
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24), // Set the padding
                      ),
                    ),
                    onPressed: () {
                      SnackBar snackBar = SnackBar(
                          elevation: 5,
                          duration: const Duration(seconds: 1),
                          backgroundColor: state.isSelected == false
                              ? AppColors.redLight
                              : state.currentAnswer!.isCorrect!
                                  ? AppColors.greenLight
                                  : AppColors.redLight,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                          content: state.isSelected == false
                              ? const Text('Oops, please select answer 🤦‍♂️😤')
                              : state.currentAnswer!.isCorrect!
                                  ? const Text('That is answer correct 🎉🎊')
                                  : const Text(
                                      'Oops, that is incorrect 🤦‍♂️😤'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      state.nextQuestion(context);

                      if (state.isEnded == true) {
                        state.resultState();
                        state.checkResult();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ResultAlert(
                                onViewResult: () =>
                                    Navigator.pushNamed(context, '/result'),
                                status: state.statusResult!,
                                completed: state.totalCorrect,
                                totalQues: state.quizs!.length,
                                totalTime:
                                    state.getFormattedTime(state.totalTime),
                              );
                            });
                      }
                    },
                    child: const Text('Next'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
