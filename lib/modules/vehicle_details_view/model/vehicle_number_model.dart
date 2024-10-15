class VehicleNumberModel {
  String? registrationNumber;
  String? taxStatus;
  String? taxDueDate;
  String? motStatus;
  String? make;
  int? yearOfManufacture;
  int? engineCapacity;
  int? co2Emissions;
  String? fuelType;
  bool? markedForExport;
  String? colour;
  String? typeApproval;
  int? revenueWeight;
  String? dateOfLastV5CIssued;
  String? motExpiryDate;
  String? wheelplan;
  String? monthOfFirstRegistration;

  VehicleNumberModel(
      {this.registrationNumber,
        this.taxStatus,
        this.taxDueDate,
        this.motStatus,
        this.make,
        this.yearOfManufacture,
        this.engineCapacity,
        this.co2Emissions,
        this.fuelType,
        this.markedForExport,
        this.colour,
        this.typeApproval,
        this.revenueWeight,
        this.dateOfLastV5CIssued,
        this.motExpiryDate,
        this.wheelplan,
        this.monthOfFirstRegistration});

  VehicleNumberModel.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registrationNumber'];
    taxStatus = json['taxStatus'];
    taxDueDate = json['taxDueDate'];
    motStatus = json['motStatus'];
    make = json['make'];
    yearOfManufacture = json['yearOfManufacture'];
    engineCapacity = json['engineCapacity'];
    co2Emissions = json['co2Emissions'];
    fuelType = json['fuelType'];
    markedForExport = json['markedForExport'];
    colour = json['colour'];
    typeApproval = json['typeApproval'];
    revenueWeight = json['revenueWeight'];
    dateOfLastV5CIssued = json['dateOfLastV5CIssued'];
    motExpiryDate = json['motExpiryDate'];
    wheelplan = json['wheelplan'];
    monthOfFirstRegistration = json['monthOfFirstRegistration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrationNumber'] = this.registrationNumber;
    data['taxStatus'] = this.taxStatus;
    data['taxDueDate'] = this.taxDueDate;
    data['motStatus'] = this.motStatus;
    data['make'] = this.make;
    data['yearOfManufacture'] = this.yearOfManufacture;
    data['engineCapacity'] = this.engineCapacity;
    data['co2Emissions'] = this.co2Emissions;
    data['fuelType'] = this.fuelType;
    data['markedForExport'] = this.markedForExport;
    data['colour'] = this.colour;
    data['typeApproval'] = this.typeApproval;
    data['revenueWeight'] = this.revenueWeight;
    data['dateOfLastV5CIssued'] = this.dateOfLastV5CIssued;
    data['motExpiryDate'] = this.motExpiryDate;
    data['wheelplan'] = this.wheelplan;
    data['monthOfFirstRegistration'] = this.monthOfFirstRegistration;
    return data;
  }
}
