import 'dart:async';

import 'package:flutter_template/modules/authentication/service/auth_service.dart';
import 'package:flutter_template/modules/authentication/service/social_service.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/utils/api_constants.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';

import '../../../api/preferences/shared_preferences_helper.dart';

class SignInController extends GetxController
    with LoadingMixin, LoadingApiMixin {

  Future<void> continueWithGoogle() async {
    handleLoading(true);
    processApi(
      () => SocialLoginService.signInWithGoogle(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        processApi(
          () {
            return AuthService.googleTokenVerify({
              ApiKeyConstants.deviceType: Constants.android,
              ApiKeyConstants.token: data
            });
          },
          result: (data) async {
            await SharedPreferencesHelper.instance
                .setUserToken(data.apiresponse?.data?.token ?? "");
            await SharedPreferencesHelper.instance
                .setString("email", data.apiresponse?.data?.email ?? "");
            await SharedPreferencesHelper.instance.setUser(data);
            Navigation.replaceAll(Routes.getStarted);
          },
          loading: handleLoading,
        );
      },
    );
  }

  Future<void> continueWithApple() async {
    handleLoading(true);
    processApi(
      () => SocialLoginService.signInWithApple(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        processApi(
          () =>
              AuthService.appleTokenVerify({ApiKeyConstants.appleToken: data}),
          result: (data) async {
            await SharedPreferencesHelper.instance
                .setUserToken(data.apiresponse?.data?.token ?? "");
            await SharedPreferencesHelper.instance
                .setString("email", data.apiresponse?.data?.email ?? "");
            await SharedPreferencesHelper.instance.setUser(data);
            Navigation.replaceAll(Routes.getStarted);
          },
          loading: handleLoading,
        );
      },
    );
  }
}
