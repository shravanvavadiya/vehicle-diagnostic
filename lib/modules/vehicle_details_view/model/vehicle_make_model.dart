class VehicleMakeModel {
  Apiresponse? apiresponse;

  VehicleMakeModel({this.apiresponse});

  VehicleMakeModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    data = json['data'].cast<String>();
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataArray'] = this.dataArray;
    data['data'] = this.data;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
