import 'package:flutter/material.dart';
import 'package:quiz_app/screen/quiz_screen.dart';
import 'package:quiz_app/screen/result_screen.dart';
import 'package:quiz_app/screen/start_screen.dart';

class AppRouter {
  static const String homeRouter = '/';
  static const String quizRouter = '/quiz';
  static const String resultRouter = '/result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRouter:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => StartScreen(),
        );
      case quizRouter:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => QuizScreen(),
        );
      case resultRouter:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ResultScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const StartScreen(),
        );
    }
  }
}
