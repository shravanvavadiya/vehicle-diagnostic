class PersonalInformationModel {
  Apiresponse? apiresponse;

  PersonalInformationModel({this.apiresponse});

  PersonalInformationModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? photo;
  String? firstName;
  String? lastName;
  String? email;
  String? postCode;
  bool? verified;
  bool? profileCompleted;
  bool? subscriptionPlan;

  Data(
      {this.id,
        this.photo,
        this.firstName,
        this.lastName,
        this.email,
        this.postCode,
        this.verified,
        this.profileCompleted,
        this.subscriptionPlan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    postCode = json['postCode'];
    verified = json['verified'];
    profileCompleted = json['profileCompleted'];
    subscriptionPlan = json['subscriptionPlan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['postCode'] = this.postCode;
    data['verified'] = this.verified;
    data['profileCompleted'] = this.profileCompleted;
    data['subscriptionPlan'] = this.subscriptionPlan;
    return data;
  }
}
