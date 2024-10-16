import 'dart:convert';
import 'dart:developer';

import 'package:flutter_template/modules/vehicle_details_view/model/my_vehicle_model.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/vehicle_make_model.dart';
import 'package:get/get.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;
import '../../../api/api.dart';
import '../../../utils/api_constants.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../model/vehicle_number_model.dart';

/// Vehicle Information ::

class VehicleService {
  static Future<String?> createVehicle({required MyVehicleData setUpProfileFormData, String? imagePath}) async {
    try {
      var response = await Api().multiPartRequestAddVehicle(
        ApiConstants.addVehicle,
        addProfileFormData: setUpProfileFormData,
        imagePath: imagePath,
      );
      return response;
    } catch (e, st) {
      log("add vehicle error : E $e ---- $st");
      rethrow;
    }
  }

  static Future<String?> editVehicle({required MyVehicleData setUpProfileFormData, String? imagePath}) async {
    try {
      var response = await Api().multiPartRequestEditVehicle(
        ApiConstants.addVehicle,
        editProfileFormData: setUpProfileFormData,
        imagePath: imagePath,
      );
      return response;
    } catch (e, st) {
      log("add vehicle error : E $e ---- $st");
      rethrow;
    }
  }

  // static Future<VehicleNumberModel> vehicleNumber({required Map<String, dynamic>? vehicleNumber}) async {
  //   try {
  //     var response = await Api().post(url: "https://driver-vehicle-licensing.api.gov.uk/vehicle-enquiry/v1/vehicles", bodyData: vehicleNumber);
  //     log("response ----------- >> $response");
  //     return VehicleNumberModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  //   } catch (e, st) {
  //     log("add vehicle error : E $e ---- $st");
  //     rethrow;
  //   }
  //
  //
  //
  // }

  static Future vehicleNumber({required String vehicleNumber}) async {
    var headers = {'x-api-key': 'Ia7AmkDmUI5UKQZjVaYiJ4Ipga9TpoBt7ANB4NCJ', 'Content-Type': 'application/json'};
    final body = json.encode({"registrationNumber": vehicleNumber});
    final forComplainDepartment =
        await http.post(Uri.parse("https://driver-vehicle-licensing.api.gov.uk/vehicle-enquiry/v1/vehicles"), body: body, headers: headers);
    log("status code ${forComplainDepartment.statusCode}");
    var response = jsonDecode(forComplainDepartment.body);
    if (forComplainDepartment.statusCode == 200) {
      VehicleNumberModel complainDepartmentModel = VehicleNumberModel.fromJson(response);
      return complainDepartmentModel;
    } else {
      throw "null";
      return null;
    }
  }

  static Future<VehicleMakeModel> vehicleMake() async {
    try {
      var response = await Api().get(
        ApiConstants.vehicleMake,
      );
      log("response ----------- >> $response");
      return VehicleMakeModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e, st) {
      log("add vehicle error : E $e ---- $st");
      rethrow;
    }
  }

  static Future<VehicleMakeModel> vehicleModel({required String selectedVehicleMake}) async {
    try {
      var response = await Api().get(
        "${ApiConstants.vehicleModel}/$selectedVehicleMake",
      );
      log("response ----------- >> ${response.body}");
      return VehicleMakeModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e, st) {
      log("add vehicle error : E $e ---- $st");
      rethrow;
    }
  }

  static Future<VehicleMakeModel> vehicleFuel({required String selectedVehicleMake, required String selectedVehicleModel}) async {
    try {
      var response = await Api().get(ApiConstants.vehicleFuel, queryData: {"make": selectedVehicleMake, "model": selectedVehicleModel});
      log("response ----------- >> $response");
      return VehicleMakeModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e, st) {
      log("add vehicle error : E $e ---- $st");
      rethrow;
    }
  }

  static Future<VehicleMakeModel> vehicleTransmission(
      {required String selectedVehicleMake, required String selectedVehicleModel, required String selectedVehicleFuel}) async {
    try {
      var response = await Api().get(ApiConstants.vehicleTransmission,
          queryData: {"fuelType": selectedVehicleFuel, "make": selectedVehicleMake, "model": selectedVehicleModel});
      log("response ----------- >> $response");
      return VehicleMakeModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e, st) {
      log("add vehicle error : E $e ---- $st");
      rethrow;
    }
  }
}
