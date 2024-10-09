import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/utils/api_constants.dart';
import '../models/get_ans_by_vehicle_id_model.dart';
import '../models/submit_vehicle_request.dart';
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
    } catch (e, st) {
      log("error : E $e,$st");
      rethrow;
    }
  }

  //Add ans for the question
  static Future<VehicleQuestionAndAns> submitVehicleRequest(Map<String, dynamic> requestBody) async {
    print("requestBodyrequestBody ${requestBody}");
    try {
      var result = await Api().post(url: ApiConstants.submitVehicleRequest, bodyData: requestBody);
      log("resultresult ${result.body}");
      await ResponseHandler.checkResponseError(result);
      return VehicleQuestionAndAns.fromJson(
        jsonDecode(
          utf8.decode(result.bodyBytes),
        ),
      );
    } catch (e, st) {
      log("error : $e, $st");
      rethrow;
    }
  }

  static Future<GetAnsByVehicleIdModel> getAnsByVehicleId({required int vehicleId}) async {
    print("requestBodyrequestBody ${vehicleId}");
    try {
      var result = await Api().get(
        "${ApiConstants.submitVehicleRequest}$vehicleId",
      );

      await ResponseHandler.checkResponseError(result);
      return GetAnsByVehicleIdModel.fromJson(
        jsonDecode(
          utf8.decode(result.bodyBytes),
        ),
      );
    } catch (e, st) {
      log("error : $e, $st");
      rethrow;
    }
  }

  static Future<VehicleQuestionAndAns> editVehicleRequest(Map<String, dynamic> requestBody) async {
    try {
      var result = await Api().put(ApiConstants.editVehicleRequest, bodyData: requestBody);
      await ResponseHandler.checkResponseError(result);
      log("result.bodyBytes ${result.bodyBytes}");
      return VehicleQuestionAndAns.fromJson(
        jsonDecode(
          utf8.decode(result.bodyBytes),
        ),
      );
    } catch (e, st) {
      log("error : $e, $st");
      rethrow;
    }
  }
}
