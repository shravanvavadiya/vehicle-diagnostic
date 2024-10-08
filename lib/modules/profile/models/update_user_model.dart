class UpdateUserModel {
  UpdateApiResponse? updateApiResponse;

  UpdateUserModel({this.updateApiResponse});

  UpdateUserModel.fromJson(Map<String, dynamic> json) {
    updateApiResponse = json['apiresponse'] != null
        ? UpdateApiResponse.fromJson(json['apiresponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (updateApiResponse != null) {
      data['apiresponse'] = updateApiResponse!.toJson();
    }
    return data;
  }
}

class UpdateApiResponse {
  Null dataArray;
  UpdateData? data;
  int? timestamp;

  UpdateApiResponse({this.dataArray, this.data, this.timestamp});

  UpdateApiResponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    data = json['data'] != null ? UpdateData.fromJson(json['data']) : null;
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

class UpdateData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? postCode;
  bool? verified;
  bool? profileCompleted;
  bool? subscriptionPlan;

  UpdateData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.postCode,
        this.verified,
        this.profileCompleted,
        this.subscriptionPlan});

  UpdateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    postCode = json['postCode'];
    verified = json['verified'];
    profileCompleted = json['profileCompleted'];
    subscriptionPlan = json['subscriptionPlan'];
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
    data['subscriptionPlan'] = subscriptionPlan;
    return data;
  }
}
