class SelectedQnsAnsModel {
  String? answer;
  String? question;

  SelectedQnsAnsModel({this.answer, this.question});

  SelectedQnsAnsModel.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['question'] = question;
    return data;
  }
}
