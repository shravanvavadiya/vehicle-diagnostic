class AddVehicleModel {
  Apiresponse? apiresponse;

  AddVehicleModel({this.apiresponse});

  AddVehicleModel.fromJson(Map<String, dynamic> json) {
    apiresponse = json['apiresponse'] != null
        ?  Apiresponse.fromJson(json['apiresponse'])
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
  AddVehicleData? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    data = json['data'] != null ?  AddVehicleData.fromJson(json['data']) : null;
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

class AddVehicleData {
  int? id;
  String? photo;
  String? vehicleNumber;
  String? vehicleYear;
  String? vehicleMake;
  String? vehicleModel;
  String? transmissionType;
  String? fuelType;
  int? userId;

  AddVehicleData(
      {this.id,
        this.photo,
        this.vehicleNumber,
        this.vehicleYear,
        this.vehicleMake,
        this.vehicleModel,
        this.transmissionType,
        this.fuelType,
        this.userId});

  AddVehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    vehicleNumber = json['vehicleNumber'];
    vehicleYear = json['vehicleYear'];
    vehicleMake = json['vehicleMake'];
    vehicleModel = json['vehicleModel'];
    transmissionType = json['transmissionType'];
    fuelType = json['fuelType'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['vehicleNumber'] = vehicleNumber;
    data['vehicleYear'] = vehicleYear;
    data['vehicleMake'] = vehicleMake;
    data['vehicleModel'] = vehicleModel;
    data['transmissionType'] = transmissionType;
    data['fuelType'] = fuelType;
    data['userId'] = userId;
    return data;
  }
}


