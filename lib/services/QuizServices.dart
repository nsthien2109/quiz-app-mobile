// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizServices {
  static const supabaseUrl = 'https://fjykiaypiappuumxekac.supabase.co';
  static const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqeWtpYXlwaWFwcHV1bXhla2FjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODYxNDUzMTYsImV4cCI6MjAwMTcyMTMxNn0.pHulNxK8r1qcUdsdpQVOPsmLuBVb8eeZTAtTP_VJ9p4';
  static final supabaseClient = SupabaseClient(supabaseUrl, supabaseKey);

  static Future<List<QuizModel>?> getQuestions() async {
    try {
      final response =
          await supabaseClient.from('questions').select('*, answers(*)');
      final quizData = response as List<dynamic>;
      final List<QuizModel> quizList = [];
      for (var quiz in quizData) {
        final answerData = quiz['answers'] as List<dynamic>;
        final List<Answers> answers = [];
        for (var answer in answerData) {
          answers.add(Answers(
              answerId: answer['answer_id'],
              answerText: answer['answer_text'],
              questionId: answer['question_id'],
              isCorrect: answer['is_correct'],
              createdAt: answer['created_at']));
        }
        quizList.add(QuizModel(
            questionId: quiz['question_id'],
            questionText: quiz['question_text'],
            isActive: quiz['isActive'],
            answers: answers,
            createdAt: quiz['created_at']));
      }

      return quizList;
    } catch (e) {
      debugPrint('$e');
    }
    return <QuizModel>[];
  }
}
