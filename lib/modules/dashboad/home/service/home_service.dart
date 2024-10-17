import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/utils/api_constants.dart';
import 'package:flutter_template/utils/app_preferences.dart';
import '../models/get_vehicle_data_model.dart';

class HomeService {
  static Future<GetVehicleDataModel> getAllVehicle({required int currentPage}) async {
    try {
      var result = await Api().get("${ApiConstants.getAllVehicleByUserId}/${AppPreference.getInt("UserId")}", queryData: {
        "page": currentPage,
        "size": 6,
      });
      print("home api ${result.request}");
      await ResponseHandler.checkResponseError(result);
      return GetVehicleDataModel.fromJson(
        jsonDecode(
          result.body,
        ),
      );
    } catch (e, st) {
      log("error : E $e,$st");
      rethrow;
    }
  }

  static Future deleteVehicle({
    required int vehicleId,
  }) async {
    try {
      var result = await Api().delete(
        "${ApiConstants.deleteVehicle}$vehicleId",
      );
      await ResponseHandler.checkResponseError(result);
      return GetVehicleDataModel.fromJson(
        jsonDecode(
          result.body,
        ),
      );
    } catch (e, st) {
      log("error : E $e,$st");
      rethrow;
    }
  }
}
