class GiveAnsModel {

  List<QaVehicleRequests>? qaVehicleRequests;
  int? vehicleId;

  GiveAnsModel({this.qaVehicleRequests, this.vehicleId});

  GiveAnsModel.fromJson(Map<String, dynamic> json) {
    if (json['qaVehicleRequests'] != null) {
      qaVehicleRequests = <QaVehicleRequests>[];
      json['qaVehicleRequests'].forEach((v) {
        qaVehicleRequests!.add(QaVehicleRequests.fromJson(v));
      });
    }
    vehicleId = json['vehicleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.qaVehicleRequests != null) {
      data['qaVehicleRequests'] =
          this.qaVehicleRequests!.map((v) => v.toJson()).toList();
    }
    data['vehicleId'] = this.vehicleId;
    return data;
  }
}

class QaVehicleRequests {
  String? answer;
  String? question;

  QaVehicleRequests({this.answer, this.question});

  QaVehicleRequests.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = answer;
    data['question'] = question;
    return data;
  }
}