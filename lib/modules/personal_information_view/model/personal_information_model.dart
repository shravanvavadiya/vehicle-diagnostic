class PersonalInformation {
  Apiresponse? apiResponse;

  PersonalInformation({this.apiResponse});

  PersonalInformation.fromJson(Map<String, dynamic> json) {
    apiResponse = json['apiresponse'] != null
        ? Apiresponse.fromJson(json['apiresponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apiResponse != null) {
      data['apiresponse'] = apiResponse!.toJson();
    }
    return data;
  }
}

class Apiresponse {
  Data? data;
  int? timestamp;

  Apiresponse({this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? postCode;
  bool? verified;
  bool? profileCompleted;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.postCode,
        this.verified,
        this.profileCompleted});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    postCode = json['postCode'];
    verified = json['verified'];
    profileCompleted = json['profileCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['postCode'] = postCode;
    data['verified'] = verified;
    data['profileCompleted'] = profileCompleted;
    return data;
  }
}
