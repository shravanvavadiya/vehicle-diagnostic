class VehicleNumberModel {
  Response? response;

  VehicleNumberModel({this.response});

  VehicleNumberModel.fromJson(Map<String, dynamic> json) {
    response = json['Response'] != null ? new Response.fromJson(json['Response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? statusCode;
  String? statusMessage;
  DataItems? dataItems;

  Response({this.statusCode, this.statusMessage, this.dataItems});

  Response.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    statusMessage = json['StatusMessage'];
    dataItems = json['DataItems'] != null ? new DataItems.fromJson(json['DataItems']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['StatusMessage'] = this.statusMessage;
    if (this.dataItems != null) {
      data['DataItems'] = this.dataItems!.toJson();
    }
    return data;
  }
}

class DataItems {
  VehicleRegistration? vehicleRegistration;

  DataItems({this.vehicleRegistration});

  DataItems.fromJson(Map<String, dynamic> json) {
    vehicleRegistration = json['VehicleRegistration'] != null ? new VehicleRegistration.fromJson(json['VehicleRegistration']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicleRegistration != null) {
      data['VehicleRegistration'] = this.vehicleRegistration!.toJson();
    }
    return data;
  }
}

class VehicleRegistration {
  String? dateOfLastUpdate;
  String? colour;
  String? vehicleClass;
  bool? certificateOfDestructionIssued;
  String? engineNumber;
  String? engineCapacity;
  String? transmissionCode;
  bool? exported;
  String? yearOfManufacture;
  String? wheelPlan;
  Null? dateExported;
  bool? scrapped;
  String? transmission;
  String? dateFirstRegisteredUk;
  String? model;
  int? gearCount;
  bool? importNonEu;
  Null? previousVrmGb;
  dynamic? grossWeight;
  String? doorPlanLiteral;
  Null? mvrisModelCode;
  String? vin;
  String? vrm;
  String? dateFirstRegistered;
  Null? dateScrapped;
  String? doorPlan;
  String? yearMonthFirstRegistered;
  String? vinLast5;
  bool? vehicleUsedBeforeFirstRegistration;
  dynamic? maxPermissibleMass;
  String? make;
  String? makeModel;
  String? transmissionType;
  dynamic? seatingCapacity;
  String? fuelType;
  dynamic? co2Emissions;
  bool? imported;
  Null? mvrisMakeCode;
  Null? previousVrmNi;
  Null? vinConfirmationFlag;
  String? dtpMakeCode;
  String? dtpModelCode;

  VehicleRegistration(
      {this.dateOfLastUpdate,
      this.colour,
      this.vehicleClass,
      this.certificateOfDestructionIssued,
      this.engineNumber,
      this.engineCapacity,
      this.transmissionCode,
      this.exported,
      this.yearOfManufacture,
      this.wheelPlan,
      this.dateExported,
      this.scrapped,
      this.transmission,
      this.dateFirstRegisteredUk,
      this.model,
      this.gearCount,
      this.importNonEu,
      this.previousVrmGb,
      this.grossWeight,
      this.doorPlanLiteral,
      this.mvrisModelCode,
      this.vin,
      this.vrm,
      this.dateFirstRegistered,
      this.dateScrapped,
      this.doorPlan,
      this.yearMonthFirstRegistered,
      this.vinLast5,
      this.vehicleUsedBeforeFirstRegistration,
      this.maxPermissibleMass,
      this.make,
      this.makeModel,
      this.transmissionType,
      this.seatingCapacity,
      this.fuelType,
      this.co2Emissions,
      this.imported,
      this.mvrisMakeCode,
      this.previousVrmNi,
      this.vinConfirmationFlag,
      this.dtpMakeCode,
      this.dtpModelCode});

  VehicleRegistration.fromJson(Map<String, dynamic> json) {
    dateOfLastUpdate = json['DateOfLastUpdate'];
    colour = json['Colour'];
    vehicleClass = json['VehicleClass'];
    certificateOfDestructionIssued = json['CertificateOfDestructionIssued'];
    engineNumber = json['EngineNumber'];
    engineCapacity = json['EngineCapacity'];
    transmissionCode = json['TransmissionCode'];
    exported = json['Exported'];
    yearOfManufacture = json['YearOfManufacture'];
    wheelPlan = json['WheelPlan'];
    dateExported = json['DateExported'];
    scrapped = json['Scrapped'];
    transmission = json['Transmission'];
    dateFirstRegisteredUk = json['DateFirstRegisteredUk'];
    model = json['Model'];
    gearCount = json['GearCount'];
    importNonEu = json['ImportNonEu'];
    previousVrmGb = json['PreviousVrmGb'];
    grossWeight = json['GrossWeight'];
    doorPlanLiteral = json['DoorPlanLiteral'];
    mvrisModelCode = json['MvrisModelCode'];
    vin = json['Vin'];
    vrm = json['Vrm'];
    dateFirstRegistered = json['DateFirstRegistered'];
    dateScrapped = json['DateScrapped'];
    doorPlan = json['DoorPlan'];
    yearMonthFirstRegistered = json['YearMonthFirstRegistered'];
    vinLast5 = json['VinLast5'];
    vehicleUsedBeforeFirstRegistration = json['VehicleUsedBeforeFirstRegistration'];
    maxPermissibleMass = json['MaxPermissibleMass'];
    make = json['Make'];
    makeModel = json['MakeModel'];
    transmissionType = json['TransmissionType'];
    seatingCapacity = json['SeatingCapacity'];
    fuelType = json['FuelType'];
    co2Emissions = json['Co2Emissions'];
    imported = json['Imported'];
    mvrisMakeCode = json['MvrisMakeCode'];
    previousVrmNi = json['PreviousVrmNi'];
    vinConfirmationFlag = json['VinConfirmationFlag'];
    dtpMakeCode = json['DtpMakeCode'];
    dtpModelCode = json['DtpModelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DateOfLastUpdate'] = this.dateOfLastUpdate;
    data['Colour'] = this.colour;
    data['VehicleClass'] = this.vehicleClass;
    data['CertificateOfDestructionIssued'] = this.certificateOfDestructionIssued;
    data['EngineNumber'] = this.engineNumber;
    data['EngineCapacity'] = this.engineCapacity;
    data['TransmissionCode'] = this.transmissionCode;
    data['Exported'] = this.exported;
    data['YearOfManufacture'] = this.yearOfManufacture;
    data['WheelPlan'] = this.wheelPlan;
    data['DateExported'] = this.dateExported;
    data['Scrapped'] = this.scrapped;
    data['Transmission'] = this.transmission;
    data['DateFirstRegisteredUk'] = this.dateFirstRegisteredUk;
    data['Model'] = this.model;
    data['GearCount'] = this.gearCount;
    data['ImportNonEu'] = this.importNonEu;
    data['PreviousVrmGb'] = this.previousVrmGb;
    data['GrossWeight'] = this.grossWeight;
    data['DoorPlanLiteral'] = this.doorPlanLiteral;
    data['MvrisModelCode'] = this.mvrisModelCode;
    data['Vin'] = this.vin;
    data['Vrm'] = this.vrm;
    data['DateFirstRegistered'] = this.dateFirstRegistered;
    data['DateScrapped'] = this.dateScrapped;
    data['DoorPlan'] = this.doorPlan;
    data['YearMonthFirstRegistered'] = this.yearMonthFirstRegistered;
    data['VinLast5'] = this.vinLast5;
    data['VehicleUsedBeforeFirstRegistration'] = this.vehicleUsedBeforeFirstRegistration;
    data['MaxPermissibleMass'] = this.maxPermissibleMass;
    data['Make'] = this.make;
    data['MakeModel'] = this.makeModel;
    data['TransmissionType'] = this.transmissionType;
    data['SeatingCapacity'] = this.seatingCapacity;
    data['FuelType'] = this.fuelType;
    data['Co2Emissions'] = this.co2Emissions;
    data['Imported'] = this.imported;
    data['MvrisMakeCode'] = this.mvrisMakeCode;
    data['PreviousVrmNi'] = this.previousVrmNi;
    data['VinConfirmationFlag'] = this.vinConfirmationFlag;
    data['DtpMakeCode'] = this.dtpMakeCode;
    data['DtpModelCode'] = this.dtpModelCode;
    return data;
  }
}
