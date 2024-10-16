import '../../profile/models/get_user_model.dart';

class PersonalInformationModel {
  Apiresponse? apiresponse;

  PersonalInformationModel({this.apiresponse});

  PersonalInformationModel.fromJson(Map<String, dynamic> json) {
    apiresponse = json['apiresponse'] != null
        ? Apiresponse.fromJson(json['apiresponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apiresponse != null) {
      data['apiresponse'] = apiresponse!.toJson();
    }
    return data;
  }
}

class Apiresponse {
  Null? dataArray;
  ProfileData? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataArray'] = dataArray;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}
