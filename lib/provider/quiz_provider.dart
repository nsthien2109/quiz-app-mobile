import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/services/QuizServices.dart';

class QuizProvider extends ChangeNotifier {
  static const STATUS_WINNER = 3;
  static const STATUS_PASSED = 2;
  static const STATUS_MISSED = 1;
  List<QuizModel>? _quizs = [];
  List<QuizModel>? get quizs => _quizs;

  QuizModel _currentQuestion = QuizModel();
  QuizModel get currentQuestion => _currentQuestion;

  int _quizIndex = 0;
  int get quizIndex => _quizIndex;

  List<Answers> _yourAnswers = [];
  List<Answers> get yourAnswers => _yourAnswers;

  Answers? _currentAnswer;
  Answers? get currentAnswer => _currentAnswer;

  int _totalTime = 0;
  int get totalTime => _totalTime;

  int _totalCorrect = 0;
  int get totalCorrect => _totalCorrect;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _selectedValue;
  int? get selectedValue => _selectedValue;

  bool _isSelected = false;
  bool get isSelected => _isSelected;

  bool _isEnded = false;
  bool get isEnded => _isEnded;

  int? _statusResult;
  int? get statusResult => _statusResult;

  late Timer time;

  Future getAllQuiz() async {
    resetState();
    await QuizServices.getQuestions().then((quizData) => {_quizs = quizData});
    _currentQuestion = _quizs![_quizIndex];
    notifyListeners();
    startTimer();
  }

  void onChangedRadio(Answers answer) {
    _currentAnswer = answer;
    _isSelected = true;
    _selectedValue = answer.answerId;
    notifyListeners();
    debugPrint('${currentAnswer!.answerId}');
  }

  void nextQuestion(context) {
    if (currentAnswer?.answerId == null) {
      _isSelected = false;
      notifyListeners();
      return;
    }
    _yourAnswers.add(currentAnswer!);

    if (quizIndex + 1 == quizs!.length) {
      _isEnded = true;
      notifyListeners();
      return;
    }
    _quizIndex += 1;
    _currentQuestion = _quizs![_quizIndex];
    _currentAnswer = null;
    notifyListeners();
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    time = Timer.periodic(duration, (Timer t) {
      _totalTime++;
      notifyListeners();
    });
  }

  String getFormattedTime(int count) {
    int minutes = count ~/ 60;
    int seconds = count % 60;
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void checkResult() {
    for (var answer in yourAnswers) {
      if (answer.isCorrect == true) {
        _totalCorrect += 1;
        notifyListeners();
      }
    }
    if (totalCorrect > ((quizs!.length / 2) + 1).toInt()) {
      _statusResult = STATUS_WINNER;
    } else if (totalCorrect == ((quizs!.length / 2) + 1).toInt()) {
      _statusResult = STATUS_PASSED;
    } else {
      _statusResult = STATUS_MISSED;
    }
    notifyListeners();
  }

  void resultState() {
    _quizIndex = 0;
    _currentAnswer = null;
    time.cancel();
    _isLoading = false;
    _selectedValue = null;
    _isSelected = false;
    _isEnded = false;
    notifyListeners();
  }

  void resetState() {
    _quizs = [];
    _currentQuestion = QuizModel();
    _quizIndex = 0;
    _yourAnswers = [];
    _totalCorrect = 0;
    _currentAnswer = null;
    _totalTime = 0;
    _isLoading = false;
    _selectedValue = null;
    _isSelected = false;
    _isEnded = false;
    _statusResult = null;
    notifyListeners();
  }
}
