import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_template/generated/l10n.dart';
import 'package:http/src/response.dart';

import '../../../api/api.dart';
import '../../../api/responce_handler.dart';
import '../../../utils/api_constants.dart';
import '../model/chat_question_model.dart';
import '../model/user_ans_check_model.dart';

class ChatServices {
  static Future<GetChatQuestionModel> chatGptQuestionServices() async {
    try {
      var result = await Api().post(
        url: ApiConstants.chatGptQuestion,
      );
      log(result.toString());
      await ResponseHandler.checkResponseError(result);
      return GetChatQuestionModel.fromJson(
        jsonDecode(
          utf8.decode(result.bodyBytes),
        ),
      );
    } catch (e, st) {
      log("error : E $e,$st");
      rethrow;
    }
  }

  static Future<UserAnswerCheckModel> userSubmitAnswer({required Map<String, dynamic>? bodyData}) async {
    try {
      var result = await Api().post(url: ApiConstants.userSubmitAnswer, bodyData: bodyData);

      log(result.toString());
      await ResponseHandler.checkResponseError(result);
      return UserAnswerCheckModel.fromJson(
        jsonDecode(
          utf8.decode(result.bodyBytes),
        ),
      );
    } catch (e, st) {
      log("error : E $e,$st");
      rethrow;
    }
  }

  static Future<Uint8List> downloadReport({required int vehicle}) async {
    try {
      var result = await Api().get(
        "${ApiConstants.downloadReport}/$vehicle/download",
      );
      log(result.body);
      await ResponseHandler.checkResponseError(result);
      return Uint8List.fromList(result.bodyBytes);
    } catch (e, st) {
      log("error : E $e,$st");
      rethrow;
    }
  }
}
