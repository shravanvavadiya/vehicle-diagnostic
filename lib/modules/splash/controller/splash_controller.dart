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
    bool? isProfileCompleted = SharedPreferencesHelper.instance
        .getUser()
        .apiresponse
        ?.data
        ?.profileCompleted;
    if (token != null && token.isNotEmpty) {
      if (isProfileCompleted == false) {
        Navigation.replaceAll(Routes.getStarted);
      } else {
        Navigation.replaceAll(Routes.homeScreen);
      }
    } else {
      Navigation.replaceAll(Routes.signIn);
    }
  }
}
