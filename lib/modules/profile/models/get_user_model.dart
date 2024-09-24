class GetUserProfileModel {
  ProfileResponse? profileResponse;

  GetUserProfileModel({this.profileResponse});

  GetUserProfileModel.fromJson(Map<String, dynamic> json) {
    profileResponse = json['apiresponse'] != null ? ProfileResponse.fromJson(json['apiresponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (profileResponse != null) {
      data['apiresponse'] = profileResponse!.toJson();
    }
    return data;
  }
}

class ProfileResponse {
  Null dataArray;
  ProfileData? profileData;
  int? timestamp;

  ProfileResponse({this.dataArray, this.profileData, this.timestamp});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    profileData = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> profileData = Map<String, dynamic>();
    profileData['dataArray'] = dataArray;
    if (this.profileData != null) {
      profileData['data'] = this.profileData!.toJson();
    }
    profileData['timestamp'] = timestamp;
    return profileData;
  }
}

class ProfileData {
  int? creationDate;
  int? lastModifiedDate;
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? postCode;
  String? photo;
  bool? profileCompleted;
  bool? subscriptionPlan;

  ProfileData(
      {this.creationDate,
      this.lastModifiedDate,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.postCode,
      this.photo,
      this.profileCompleted,
      this.subscriptionPlan});

  ProfileData.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    postCode = json['postCode'];
    photo = json['photo'];
    profileCompleted = json['profileCompleted'];
    subscriptionPlan = json['subscriptionPlan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['creationDate'] = creationDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['postCode'] = postCode;
    data['photo'] = photo;
    data['profileCompleted'] = profileCompleted;
    data['subscriptionPlan'] = subscriptionPlan;
    return data;
  }
}
