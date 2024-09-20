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
  VehicleData? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    data = json['data'] != null ? new VehicleData.fromJson(json['data']) : null;
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

class VehicleData {
  List<Vehicle>? vehicle;
  int? totalCount;

  VehicleData({this.vehicle, this.totalCount});

  VehicleData.fromJson(Map<String, dynamic> json) {
    if (json['vehicle'] != null) {
      vehicle = <Vehicle>[];
      json['vehicle'].forEach((v) {
        vehicle!.add(new Vehicle.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Vehicle {
  int? id;
  String? photo;
  String? vehicleNumber;
  String? vehicleYear;
  String? vehicleMake;
  String? vehicleModel;
  String? transmissionType;
  String? fuelType;
  UserId? userId;

  Vehicle(
      {this.id,
        this.photo,
        this.vehicleNumber,
        this.vehicleYear,
        this.vehicleMake,
        this.vehicleModel,
        this.transmissionType,
        this.fuelType,
        this.userId});

  Vehicle.fromJson(Map<String, dynamic> json) {
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
  Null? firstName;
  Null? lastName;
  String? email;
  Null? postCode;
  bool? profileCompleted;
  Null? subscriptionPlan;

  UserId(
      {this.creationDate,
        this.lastModifiedDate,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.postCode,
        this.profileCompleted,
        this.subscriptionPlan});

  UserId.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    postCode = json['postCode'];
    profileCompleted = json['profileCompleted'];
    subscriptionPlan = json['subscriptionPlan'];
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
    data['subscriptionPlan'] = this.subscriptionPlan;
    return data;
  }
}