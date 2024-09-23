import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/utils/api_constants.dart';

import '../models/vehicle_information_step_model.dart';


class VehicleInformationService {

 //Get all question
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

  //Add ans for the question
  static Future<void> submitVehicleRequest(Map<String, dynamic> requestBody) async {
    try {
      var result = await Api().post(
        url: ApiConstants.submitVehicleRequest,
        bodyData: requestBody
      );
      await ResponseHandler.checkResponseError(result);
    } catch (e, st) {
      log("error : $e, $st");
      rethrow;
    }
  }
 /* static Future<VehicleInformationModel> getVehicleInformation() async {
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
  }*/
}
