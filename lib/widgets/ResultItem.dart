import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/utils/theme.dart';

class ResultItem extends StatelessWidget {
  QuizModel quiz;
  Answers result;
  ResultItem({super.key, required this.quiz, required this.result});

  @override
  Widget build(BuildContext context) {
    int letterIndex = 0;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Question ${quiz.questionId} : ',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: AppColors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '${quiz.questionText}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const Divider(),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: .8, color: AppColors.primary),
                              borderRadius: BorderRadius.circular(20)),
                          child: quiz.answers![index].isCorrect == true
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.green,
                                )
                              : const SizedBox(),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${String.fromCharCode(65 + index)} : ${quiz.answers![index].answerText}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: quiz.answers?.length ?? 0),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You're ${result.isCorrect == true ? 'correct' : 'wrong !'}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:
                          result.isCorrect == true ? Colors.green : Colors.red),
                ),
                Text(
                  "Your answer : ${result.answerText}",
                  style: TextStyle(
                      color:
                          result.isCorrect == true ? Colors.green : Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
