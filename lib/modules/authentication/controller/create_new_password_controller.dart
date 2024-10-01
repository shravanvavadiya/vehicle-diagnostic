import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/api_constants.dart';
import '../../../utils/app_string.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/constants.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../personal_information_view/get_started_screen.dart';
import '../service/auth_service.dart';
import '../service/social_service.dart';
import 'package:get/get.dart';

class LogInWithEmailIdController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.loginWithEmailID.obs;
  RxString buttonName = Platform.isAndroid ? AppString.continueWithGoogle.obs : AppString.continueWithApple.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showPassword = false.obs;

  continueWithGoogle() async {
    handleLoading(true);
    processApi(
      () => SocialLoginService.signInWithGoogle(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        processApi(
          () {
            print("data $data");
            return AuthService.googleTokenVerify({ApiKeyConstants.deviceType: Constants.android, ApiKeyConstants.token: data});
          },
          result: (data) async {
            log("${data.apiresponse?.data?.token}");
            await SharedPreferencesHelper.instance.setUserToken(data.apiresponse?.data?.token ?? "");
            await SharedPreferencesHelper.instance.setString("email", data.apiresponse?.data?.email ?? "");
            Get.offAll(const GetStartedScreen());
            await SharedPreferencesHelper.instance.setUser(data);
          },
          loading: handleLoading,
        );
      },
    );
  }

  continueWithApple() async {
    handleLoading(true);
    processApi(
      () => SocialLoginService.signInWithApple(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        processApi(
          () => AuthService.appleTokenVerify({ApiKeyConstants.appleToken: data}),
          result: (data) async {
            await SharedPreferencesHelper.instance.setUserToken(data.apiresponse?.data?.token ?? "");
            await SharedPreferencesHelper.instance.setString("email", data.apiresponse?.data?.email ?? "");
            await SharedPreferencesHelper.instance.setUser(data);
            Navigation.replaceAll(Routes.getStarted);
          },
          loading: handleLoading,
        );
      },
    );
  }
}
