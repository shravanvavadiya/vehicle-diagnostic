import 'dart:developer';
import 'package:flutter_template/modules/authentication/models/authapi_res.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';
import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/app_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    try {
      log("onInit===>call 00");
      Future.delayed(const Duration(seconds: 3), () {
        log("onInit===>call 01");
        navigateFurther();
      });
    } on Exception catch (e) {
      log("onInit===>call error::$e");
      // TODO
    }
    super.onInit();
  }

  Future<void> navigateFurther() async {
    log("get user token ---->${SharedPreferencesHelper.instance
        .getUserToken()}");
    String? token = SharedPreferencesHelper.instance.getUserToken();

    if (token != null && token.isNotEmpty) {
      AuthApiRes? authApiRes;
      authApiRes = SharedPreferencesHelper.instance.getUser();
      log("authApiRes :: ${authApiRes?.toJson()}");
      if (authApiRes?.apiresponse?.data?.profileCompleted ??
          false) {
        Navigation.replaceAll(Routes.homeScreen);
      } else {
        Navigation.replaceAll(Routes.signIn);
      }
    } else {
      Navigation.replaceAll(Routes.signIn);
    }
  }
}
