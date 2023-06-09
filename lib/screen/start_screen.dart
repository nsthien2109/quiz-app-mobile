import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/utils/reponsive.dart';
import 'package:quiz_app/utils/theme.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Container(
          width: widthP(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.iconQuiz),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => {
                  Provider.of<QuizProvider>(context, listen: false)
                      .getAllQuiz()
                      .then((value) => Navigator.pushNamed(context, '/quiz'))
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.second),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40), // Set the padding
                  ),
                ),
                child: const Text("Start"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
