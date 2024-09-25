class VehicleQuestionAndAns {
  Apiresponse? apiresponse;

  VehicleQuestionAndAns({this.apiresponse});

  VehicleQuestionAndAns.fromJson(Map<String, dynamic> json) {
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
  List<QaVehicleResponses>? qaVehicleResponses;

  Data({this.vehicleId, this.qaVehicleResponses});

  Data.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    if (json['qaVehicleResponses'] != null) {
      qaVehicleResponses = <QaVehicleResponses>[];
      json['qaVehicleResponses'].forEach((v) {
        qaVehicleResponses!.add(new QaVehicleResponses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleId'] = this.vehicleId;
    if (this.qaVehicleResponses != null) {
      data['qaVehicleResponses'] =
          this.qaVehicleResponses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QaVehicleResponses {
  int? id;
  String? question;
  String? answer;

  QaVehicleResponses({this.id, this.question, this.answer});

  QaVehicleResponses.fromJson(Map<String, dynamic> json) {
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
