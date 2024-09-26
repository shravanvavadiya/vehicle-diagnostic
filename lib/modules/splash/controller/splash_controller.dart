import 'dart:developer';
import 'package:flutter_template/modules/authentication/models/authapi_res.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';
import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/app_preferences.dart';
import '../../authentication/presentation/google_login_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    try {
      Future.delayed(const Duration(seconds: 2), () {
        navigateFurther();
      });
    } on Exception catch (e) {}
    super.onInit();
  }

  Future<void> navigateFurther() async {
    log("get user token ---->${SharedPreferencesHelper.instance.getLogInUser()}");
    bool token = SharedPreferencesHelper.instance.getLogInUser();
    // if (token != null && token.isNotEmpty) {
    //   AuthApiRes? authApiRes;
    //   authApiRes = SharedPreferencesHelper.instance.getUser();
    //   log("authApiRes :: ${authApiRes?.toJson()}");
    //   if (authApiRes?.apiresponse?.data?.profileCompleted ?? false) {
    //     Navigation.replaceAll(Routes.homeScreen);
    //   } else {
    //     Navigation.replaceAll(Routes.signIn);
    //   }
    // } else {
    //   Navigation.replaceAll(Routes.signIn);
    // }
    // bool userAccountAccess = personalInformationModel.value.apiresponse?.data?.profileCompleted ?? false;

    if (token == true) {
      Get.offAll(HomeScreen());
    } else {
      Get.offAll(GoogleLogInScreen());
    }
  }
}
