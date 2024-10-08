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
      rethrow;
    }
  }

  /// User profile Update::
  static Future<PersonalInformationModel?> updateUserAPI({
    required String? imagePath,
    required String email,
    required int id,
    required String firstName,
    required String lastName,
    required String postCode,
  }) async {
    try {
      log("imagePath :: 111 :$imagePath");

      var result = await Api().multiPartRequestUpdateUserData(
          email: email,
          firstName: firstName,
          lastName: lastName,
          postCode: postCode,
          imagePath: imagePath,
          id: id);
      log("result data  ::$result");

     if( result!=null) {

       return PersonalInformationModel.fromJson(jsonDecode(result));
     }
    } catch (exception, st) {
      log("exception in profile service : E $exception , $st");

      throw AppException.exceptionHandler(exception);

    }
  }

  static Future<void> deleteUserAccount({
    required int userId,
  }) async {
    try {
      var result = await Api().delete(
        "${ApiConstants.deleteUserAccount}$userId",
      );
      await ResponseHandler.checkResponseError(result);
      if (result.statusCode == 200) {
        log("User deleted successfully");
      } else {
        log("Failed to delete user: ${result.statusCode}");
      }
    } catch (e, st) {
      log("Error: $e, $st");
      rethrow;
    }
  }




/* static Future<UpdateUserModel> updateUserAPI({required Map<String, dynamic> bodyData}) async {
    try {
      var result = await Api().put(ApiConstants.user,bodyData: bodyData);
      await ResponseHandler.checkResponseError(result);
      return UpdateUserModel.fromJson(jsonDecode(result.body));
    } catch (exception, s) {
      log("exception in updateUserAPI : E $exception , $s");
      rethrow;
    }
  }*/
}
