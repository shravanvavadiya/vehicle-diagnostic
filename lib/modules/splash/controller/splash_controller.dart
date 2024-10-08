import 'dart:developer';

import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../widget/no_internet_popup.dart';
import '../../authentication/presentation/google_login_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    try {
      Future.delayed(const Duration(seconds: 2), () {
        navigateFurther();
      });
    } on Exception catch (e) {}
    checkNetwork();
    super.onInit();
  }

  bool isInternet = false;

  void checkNetwork() async {
    isInternet = await InternetConnectionChecker().hasConnection;
    InternetConnectionChecker().onStatusChange.listen(
          (InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (!isInternet) {
              Navigation.pop();
            }
            isInternet = true;
            break;
          case InternetConnectionStatus.disconnected:
            isInternet = false;
            commonNoInternetDialog(Get.context!);
            break;
        }
      },
    );
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
      Get.offAll(const GoogleLogInScreen());
    }
  }
}
