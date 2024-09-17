class GetVehicleDataModel {
  Apiresponse? apiresponse;

  GetVehicleDataModel({this.apiresponse});

  GetVehicleDataModel.fromJson(Map<String, dynamic> json) {
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
  List<VehicleData>? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    if (json['data'] != null) {
      data = <VehicleData>[];
      json['data'].forEach((v) {
        data!.add(new VehicleData.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataArray'] = this.dataArray;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class VehicleData {
  int? creationDate;
  int? lastModifiedDate;
  int? id;
  String? photo;
  String? vehicleNumber;
  String? vehicleYear;
  String? vehicleMake;
  String? vehicleModel;
  String? transmissionType;
  String? fuelType;
  UserId? userId;

  VehicleData(
      {this.creationDate,
        this.lastModifiedDate,
        this.id,
        this.photo,
        this.vehicleNumber,
        this.vehicleYear,
        this.vehicleMake,
        this.vehicleModel,
        this.transmissionType,
        this.fuelType,
        this.userId});

  VehicleData.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    photo = json['photo'];
    vehicleNumber = json['vehicleNumber'];
    vehicleYear = json['vehicleYear'];
    vehicleMake = json['vehicleMake'];
    vehicleModel = json['vehicleModel'];
    transmissionType = json['transmissionType'];
    fuelType = json['fuelType'];
    userId =
    json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creationDate'] = this.creationDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['vehicleNumber'] = this.vehicleNumber;
    data['vehicleYear'] = this.vehicleYear;
    data['vehicleMake'] = this.vehicleMake;
    data['vehicleModel'] = this.vehicleModel;
    data['transmissionType'] = this.transmissionType;
    data['fuelType'] = this.fuelType;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    return data;
  }
}

class UserId {
  int? creationDate;
  int? lastModifiedDate;
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? postCode;
  bool? profileCompleted;

  UserId(
      {this.creationDate,
        this.lastModifiedDate,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.postCode,
        this.profileCompleted});

  UserId.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    postCode = json['postCode'];
    profileCompleted = json['profileCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creationDate'] = this.creationDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['postCode'] = this.postCode;
    data['profileCompleted'] = this.profileCompleted;
    return data;
  }
}