class QuestionAndAnswerModel {
  String? question;
  String? answer = "";
  int? index;

  QuestionAndAnswerModel({this.answer, this.question, this.index});

  QuestionAndAnswerModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'] = "";
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    data['index'] = index;
    return data;
  }
}
