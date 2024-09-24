class GetVehicleDataModel {
  Apiresponse? apiresponse;

  GetVehicleDataModel({this.apiresponse});

  GetVehicleDataModel.fromJson(Map<String, dynamic> json) {
    apiresponse = json['apiresponse'] != null
        ?  Apiresponse.fromJson(json['apiresponse'])
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
  List<MoreAboutVehicle>? moreAboutVehicle;
  int? userId;

  Vehicle(
      {this.id,
        this.photo,
        this.vehicleNumber,
        this.vehicleYear,
        this.vehicleMake,
        this.vehicleModel,
        this.transmissionType,
        this.fuelType,
        this.moreAboutVehicle,
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
    if (json['moreAboutVehicle'] != null) {
      moreAboutVehicle = <MoreAboutVehicle>[];
      json['moreAboutVehicle'].forEach((v) {
        moreAboutVehicle!.add(new MoreAboutVehicle.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['vehicleNumber'] = this.vehicleNumber;
    data['vehicleYear'] = this.vehicleYear;
    data['vehicleMake'] = this.vehicleMake;
    data['vehicleModel'] = this.vehicleModel;
    if (this.moreAboutVehicle != null) {
      data['moreAboutVehicle'] =
          this.moreAboutVehicle!.map((v) => v.toJson()).toList();
    }
    data['transmissionType'] = this.transmissionType;
    data['fuelType'] = this.fuelType;
    data['userId'] = this.userId;
    return data;
  }
}

class MoreAboutVehicle {
  int? id;
  String? question;
  String? answer;

  MoreAboutVehicle({this.id, this.question, this.answer});

  MoreAboutVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}