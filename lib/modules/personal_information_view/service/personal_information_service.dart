import 'dart:convert';
import 'dart:developer';
import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/exception/app_exception.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/modules/personal_information_view/model/personal_information_model.dart';
import 'package:flutter_template/utils/api_constants.dart';

/// Personal Information ::
class PersonalInformationService {
  static Future<PersonalInformation> personalInformation(
      {required Map<String, dynamic> bodyData}) async {
    try {
      var result = await Api().post(ApiConstants.user, bodyData: bodyData);
      await ResponseHandler.checkResponseError(result);
      return PersonalInformation.fromJson(jsonDecode(result.body));
    } catch (exception, s) {
      log("exception in personalInformation : E $exception , $s");
      throw AppException.exceptionHandler(exception);
    }
  }
}
