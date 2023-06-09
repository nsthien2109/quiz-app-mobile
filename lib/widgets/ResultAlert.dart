import 'package:flutter/material.dart';
import 'package:quiz_app/utils/reponsive.dart';
import 'package:quiz_app/utils/theme.dart';

class ResultAlert extends StatelessWidget {
  int completed;
  int totalQues;
  Function onViewResult;
  int status;
  String totalTime;
  ResultAlert(
      {super.key,
      required this.onViewResult,
      required this.status,
      required this.completed,
      required this.totalQues,
      required this.totalTime});

  @override
  Widget build(BuildContext context) {
    const STATUS_WINNER = 3;
    const STATUS_PASSED = 2;
    const STATUS_MISSED = 1;
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      content: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: widthP(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                status == STATUS_WINNER
                    ? AppImages.iconCongratulation
                    : status == STATUS_PASSED
                        ? AppImages.iconPassed
                        : AppImages.iconEmbarrassed,
                width: widthP(context) / 4,
              ),
              Container(
                child: Column(
                  children: [
                    status == STATUS_WINNER
                        ? const Text("Congratulations")
                        : status == STATUS_PASSED
                            ? const Text("You're passed")
                            : const Text("You're missed, play again"),
                    Text(
                        "$completed/$totalQues correct answer in $totalTime minute"),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: widthP(context),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.browLight), // Set the background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Set the text color
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24), // Set the padding
                          ),
                        ),
                        onPressed: () => onViewResult(),
                        child: const Text("View result")),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: widthP(context),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.second), // Set the background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Set the text color
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24), // Set the padding
                          ),
                        ),
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false),
                        child: const Text("Play Again")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
