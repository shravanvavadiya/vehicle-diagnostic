import 'dart:developer';

import 'package:flutter_template/modules/authentication/models/authapi_res.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';
import '../../../api/preferences/shared_preferences_helper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      navigateFurther();
    });
    super.onInit();
  }

  Future<void> navigateFurther() async {
    String? token = SharedPreferencesHelper.instance.getUserToken();
    if (token != null && token.isNotEmpty) {
      if (SharedPreferencesHelper.instance
              .getUser()
              ?.apiresponse
              ?.data
              ?.profileCompleted ??
          false) {
        Navigation.replaceAll(Routes.homeScreen);
      } else {
        Navigation.replaceAll(Routes.homeScreen);
      }
    } else {
      Navigation.replaceAll(Routes.signIn);
    }
  }
}
