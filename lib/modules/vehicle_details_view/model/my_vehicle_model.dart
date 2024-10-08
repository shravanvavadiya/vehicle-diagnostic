class MyVehicleData {
  int? id;
  String? vehicleNumber;
  String? vehicleYear;
  String? vehicleMake;
  String? vehicleModel;
  String? transmissionType;
  String? fuelType;
  int? userId;

  MyVehicleData(
      {this.id,
        this.vehicleNumber,
        this.vehicleYear,
        this.vehicleMake,
        this.vehicleModel,
        this.transmissionType,
        this.fuelType,
        this.userId});

  MyVehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    vehicleNumber = json['vehicleNumber'];
    vehicleYear = json['vehicleYear'];
    vehicleMake = json['vehicleMake'];
    vehicleModel = json['vehicleModel'];
    transmissionType = json['transmissionType'];
    fuelType = json['fuelType'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
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