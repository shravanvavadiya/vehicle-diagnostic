import 'dart:convert';
import 'dart:developer';

import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/exception/app_exception.dart';
import 'package:flutter_template/modules/personal_information_view/model/personal_information_model.dart';
import 'package:flutter_template/utils/api_constants.dart';

/// Personal Information ::
class PersonalInformationService {
  // static Future<PersonalInformationModel> personalInformation(
  //     {required Map<String, dynamic> bodyData}) async {
  //   try {
  //     var result = await Api().post(bodyData: bodyData, url: ApiConstants.user);
  //     await ResponseHandler.checkResponseError(result);
  //     return PersonalInformationModel.fromJson(jsonDecode(result.body));
  //   } catch (exception, s) {
  //     log("exception in personalInformation : E $exception , $s");
  //     throw AppException.exceptionHandler(exception);
  //   }
  // }
  static Future<PersonalInformationModel> personalInformation({
     String? imagePath,
    required String email,
    required String firstName,
    required String lastName,
    required String postCode,
  }) async {
    try {
      var result = await Api().multiPartRequestUserData(
        endPoint: ApiConstants.user,
        email: email,
        firstName: firstName,
        lastName: lastName,
        postCode: postCode,
        imagePath: imagePath,
      );
      // log("result $result");
      return PersonalInformationModel.fromJson(jsonDecode(result));
    } catch (exception, s) {
      log("exception in personalInformation : E $exception , $s");
      throw AppException.exceptionHandler(exception);
    }
  }
}
