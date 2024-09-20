import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/exception/app_exception.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/modules/personal_information_view/model/personal_information_model.dart';
import 'package:flutter_template/modules/profile/models/get_user_model.dart';
import 'package:flutter_template/utils/api_constants.dart';


class ProfileService {

  /// User profile ::
  static Future<GetUserProfileModel> getUserAPI({required int userId}) async {
    try {
      var result = await Api().get("${ApiConstants.user}$userId");
      await ResponseHandler.checkResponseError(result);
      return GetUserProfileModel.fromJson(jsonDecode(result.body));
    } catch (exception, s) {
      log("exception in rewardHistoryAPI : E $exception , $s");
      throw AppException.exceptionHandler(exception);
    }
  }
}
