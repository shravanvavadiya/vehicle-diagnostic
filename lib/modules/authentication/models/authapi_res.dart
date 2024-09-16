class AuthApiRes {
  Apiresponse? apiresponse;

  AuthApiRes({this.apiresponse});

  AuthApiRes.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? token;
  String? firstName;
  String? lastName;
  String? postCode;
  bool? profileCompleted;
  bool? verified;

  Data(
      {this.id,
        this.email,
        this.token,
        this.firstName,
        this.lastName,
        this.postCode,
        this.profileCompleted,
        this.verified});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    token = json['token'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    postCode = json['postCode'];
    profileCompleted = json['profileCompleted'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['token'] = this.token;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['postCode'] = this.postCode;
    data['profileCompleted'] = this.profileCompleted;
    data['verified'] = this.verified;
    return data;
  }
}
