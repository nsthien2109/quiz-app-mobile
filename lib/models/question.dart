class QuizModel {
  int? questionId;
  String? questionText;
  bool? isActive;
  String? createdAt;
  List<Answers>? answers;

  QuizModel(
      {this.questionId,
      this.questionText,
      this.isActive,
      this.createdAt,
      this.answers});

  QuizModel.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionText = json['question_text'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['question_text'] = questionText;
    data['isActive'] = isActive;
    data['created_at'] = createdAt;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? answerId;
  String? answerText;
  int? questionId;
  bool? isCorrect;
  String? createdAt;

  Answers(
      {this.answerId,
      this.answerText,
      this.questionId,
      this.isCorrect,
      this.createdAt});

  Answers.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    answerText = json['answer_text'];
    questionId = json['question_id'];
    isCorrect = json['is_correct'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_id'] = answerId;
    data['answer_text'] = answerText;
    data['question_id'] = questionId;
    data['is_correct'] = isCorrect;
    data['created_at'] = createdAt;
    return data;
  }
}
