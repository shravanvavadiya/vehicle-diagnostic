class UserAnswerCheckModel {
  Apiresponse? apiresponse;

  UserAnswerCheckModel({this.apiresponse});

  UserAnswerCheckModel.fromJson(Map<String, dynamic> json) {
    apiresponse = json['apiresponse'] != null
        ? new Apiresponse.fromJson(json['apiresponse'])
        : null;
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
  Data? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataArray'] = this.dataArray;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  int? vehicleId;
  List<QaChatGptResponses>? qaChatGptResponses;

  Data({this.vehicleId, this.qaChatGptResponses});

  Data.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    if (json['qaChatGptResponses'] != null) {
      qaChatGptResponses = <QaChatGptResponses>[];
      json['qaChatGptResponses'].forEach((v) {
        qaChatGptResponses!.add(new QaChatGptResponses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleId'] = this.vehicleId;
    if (this.qaChatGptResponses != null) {
      data['qaChatGptResponses'] =
          this.qaChatGptResponses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QaChatGptResponses {
  int? id;
  String? question;
  String? answer;

  QaChatGptResponses({this.id, this.question, this.answer});

  QaChatGptResponses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
