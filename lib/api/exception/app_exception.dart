import 'dart:io';

import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/widget/app_snackbar.dart';

class AppException implements Exception {
  //un_known error code -> 0

  late final String message;
  final String? tag;
  final int errorCode;

  AppException({required this.message, required this.errorCode, this.tag});

  int getErrorCode() => errorCode;

  String getMessage() => message;

  String getMessageWithTag() => "${tag ?? 'No Tag'} : $message";

  String? getTag() => tag;

  @override
  String toString() {
    return "${errorCode.toString()} : ${tag ?? 'No Tag'} : $message";
  }

  static showException(dynamic exception, [dynamic stackTrace]) {
    if (exception is AppException) {
      AppException(
        errorCode: exception.errorCode,
        message: exception.message,
      ).show();
    } else if (exception is SocketException) {
      AppException(
        errorCode: exception.osError?.errorCode ?? 0,
        message: exception.osError?.message ?? AppString.internetIsNotAvailable,
      ).show();
    } else if (exception is HttpException) {
      AppException(message: AppString.couldFindTheRequestedData, errorCode: 0).show();
    } else if (exception is FormatException) {
      AppException(message: exception.message, errorCode: 0).show();
    } else {
      AppException(message: AppString.somethingWentWrong, errorCode: 0).show();
    }
  }
  static dynamic exceptionHandler(exception, [stackTrace]) {
    if (exception is AppException) {
      throw exception;
    } else if (exception is SocketException) {
      throw AppException(message:AppString.noInternetYet, errorCode: exception.osError?.errorCode ?? 0);
    } else if (exception is HttpException) {
      throw AppException(message: AppString.couldFindTheRequestedData, errorCode: 0);
    } else if (exception is FormatException) {
      throw AppException(message: AppString.badResponseFormat, errorCode: 0);
    }
    throw AppException(message: AppString.unknownError, errorCode: 0);
  }
  void show() {
    AppSnackBar.showErrorSnackBar(message: message, title: AppString.error);
  }
}
