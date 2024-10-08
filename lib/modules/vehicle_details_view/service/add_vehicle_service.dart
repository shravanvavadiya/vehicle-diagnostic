import 'dart:developer';

import 'package:flutter_template/modules/vehicle_details_view/model/my_vehicle_model.dart';

import '../../../api/api.dart';
import '../../../utils/api_constants.dart';

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
}
