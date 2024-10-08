import 'dart:convert';
import 'dart:developer';

import 'package:flutter_template/api/api.dart';
import 'package:flutter_template/api/responce_handler.dart';
import 'package:flutter_template/modules/authentication/models/signup_form_data.dart';
import 'package:flutter_template/utils/api_constants.dart';

import '../models/authapi_res.dart';
import '../models/create_new_account_model.dart';

class AuthService {
  static Future signUp(SignUpFormData request) async {
    try {
      var result = await Api().post(
        url: ApiConstants.signUp,
        bodyData: request.toJson(),
      );
      log("status: ${result.statusCode} body:${result.body}");
      await ResponseHandler.checkResponseError(result);
      return AuthApiRes.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      log("error : E $e");
      rethrow;
    }
  }

  static Future<AuthApiRes> googleTokenVerify(Map<String, dynamic> request) async {
    try {
      print("request $request");
      var result = await Api().post(
        url: ApiConstants.googleTokenVerify,
        queryData: request,
      );
      await ResponseHandler.checkResponseError(result);
      return AuthApiRes.fromJson(
        jsonDecode(
          utf8.decode(result.bodyBytes),
        ),
      );
    } catch (e, st) {
      log("error : E $e $st");
      rethrow;
    }
  }

  static Future<AuthApiRes> appleTokenVerify(Map<String, dynamic> request) async {
    try {
      var result = await Api().post(
        bodyData: request,
        url: ApiConstants.appleTokenVerify,
      );
      log("status: ${result.statusCode} body:${result.body}");
      await ResponseHandler.checkResponseError(result);
      return AuthApiRes.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      log("error : E $e");
      rethrow;
    }
  }

  static Future<CreateNewAccountModel> createNewAccountByEmail(Map<String, dynamic> queryData) async {
    try {
      var result = await Api().post(url: ApiConstants.accountCreate, queryData: queryData);
      log('status: ${result.statusCode} body:${result.body}');
      await ResponseHandler.checkResponseError(result);
      return CreateNewAccountModel.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  static Future<CreateNewAccountModel> logInByEmail(Map<String, dynamic> queryData) async {
    try {
      var result = await Api().post(url: ApiConstants.accountLogin, queryData: queryData);
      log('status: ${result.statusCode} body:${result.body}');
      await ResponseHandler.checkResponseError(result);
      return CreateNewAccountModel.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  static Future<CreateNewAccountModel> accountOtpVerify(Map<String, dynamic> queryData) async {
    try {
      var result = await Api().post(url: ApiConstants.accountOtpVerify, queryData: queryData);
      log('status: ${result.statusCode} body:${result.body}');
      await ResponseHandler.checkResponseError(result);
      return CreateNewAccountModel.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }static Future<CreateNewAccountModel> forgotPasswordVerify(Map<String, dynamic> queryData) async {
    try {
      var result = await Api().post(url: ApiConstants.forgotPasswordVerify, queryData: queryData);
      log('status: ${result.statusCode} body:${result.body}');
      await ResponseHandler.checkResponseError(result);
      return CreateNewAccountModel.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  static Future<CreateNewAccountModel?> resendOtp(Map<String, dynamic> queryData) async {
    try {
      var result = await Api().post(url: ApiConstants.resendOtp, queryData: queryData);
      log('status: ${result.statusCode} body:${result.body}');
      await ResponseHandler.checkResponseError(result);
      return CreateNewAccountModel.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }static Future<CreateNewAccountModel?> resetPassword(Map<String, dynamic> queryData) async {
    try {
      var result = await Api().post(url: ApiConstants.resetPassword, queryData: queryData);
      log('status: ${result.statusCode} body:${result.body}');
      await ResponseHandler.checkResponseError(result);
      return CreateNewAccountModel.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }
}
