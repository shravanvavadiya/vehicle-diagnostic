import 'dart:developer';

import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';
import '../../../api/preferences/shared_preferences_helper.dart';

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
    String? token = SharedPreferencesHelper.instance.getUserToken();
    if (token != null && token.isNotEmpty) {
      if (SharedPreferencesHelper.instance
              .getUser()
              ?.apiresponse
              ?.data
              ?.profileCompleted ??
          false) {
        log("profile completed ::${SharedPreferencesHelper.instance
            .getUser()
            ?.apiresponse
            ?.data
            ?.profileCompleted}");
        Navigation.replaceAll(Routes.signIn);
      } else {
        Navigation.replaceAll(Routes.signIn);
      }
    } else {
      Navigation.replaceAll(Routes.signIn);
    }
  }
}
