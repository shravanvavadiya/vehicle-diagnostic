import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/utils/api_constants.dart';

import '../models/get_vehicle_data_model.dart';

class HomeService {

  static Future<GetVehicleDataModel> getAllVehicle() async {
    try {
      var result = await Api().get(
        ApiConstants.getAllVehicle,
      );
      await ResponseHandler.checkResponseError(result);
      return GetVehicleDataModel.fromJson(
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
