import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/utils/api_constants.dart';

import '../models/vehicle_information_step_model.dart';


class VehicleInformationService {

  static Future<VehicleInformationModel> getVehicleInformation() async {
    try {
      var result = await Api().get(
        ApiConstants.getVehicleQue,
      );
      await ResponseHandler.checkResponseError(result);
      return VehicleInformationModel.fromJson(
        jsonDecode(
          utf8.decode(result.bodyBytes),
        ),
      );
    } catch (e,st) {
      log("error : E $e,$st");
      rethrow;
    }
  }
}
