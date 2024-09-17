import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/utils/api_constants.dart';

import '../models/get_vehicle_data_model.dart';

class HomeService {
  /*static Future<PostModel> getPostList(
      {required int page, required int limit}) async {
    try {
      var result = await Api()
          .get("${ApiConstants.getPostsList}?page=$page&limit=$limit");
      log("getPostsList status: ${result.statusCode} body:${result.body}");
      await ResponseHandler.checkResponseError(result);
      return PostModel.fromJson(
        jsonDecode(result.body),
      );
    } catch (e) {
      log("getPostsList error : E $e");
      rethrow;
    }
  }*/

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
    } catch (e) {
      log("error : E $e");
      rethrow;
    }
  }
}
