class GetChatQuestionModel {
  Apiresponse? apiresponse;

  GetChatQuestionModel({this.apiresponse});

  GetChatQuestionModel.fromJson(Map<String, dynamic> json) {
    apiresponse = json['apiresponse'] != null ? new Apiresponse.fromJson(json['apiresponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apiresponse != null) {
      data['apiresponse'] = this.apiresponse!.toJson();
    }
    return data;
  }
}

class Apiresponse {
  Null? dataArray;
  List<Data>? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataArray'] = this.dataArray;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  int? question;
  String? value;

  Data({this.question, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['value'] = this.value;
    return data;
  }
}
