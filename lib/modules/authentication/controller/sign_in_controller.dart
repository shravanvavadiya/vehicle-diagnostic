import 'dart:async';
import 'dart:developer';
import 'package:flutter_template/modules/authentication/service/auth_service.dart';
import 'package:flutter_template/modules/authentication/service/social_service.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/utils/api_constants.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInController extends GetxController
    with LoadingMixin, LoadingApiMixin {

  RxString appleEmail = ''.obs;
  RxString appleId = ''.obs;
  RxBool appleLoading= false.obs;

  Future<void> continueWithGoogle() async {
    handleLoading(true);
    processApi(
      () => SocialLoginService.signInWithGoogle(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        processApi(
          () {
           return  AuthService.googleTokenVerify({
              ApiKeyConstants.deviceType: Constants.android,
              ApiKeyConstants.token: data
            });
          },
          result: (data) async {
            await SharedPreferencesHelper.instance.setString(AppString.authToken, "");
            Navigation.push(const GetStartedScreen());
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
              AuthService.appleTokenVerify({
                ApiKeyConstants.appleToken: data
              }),
          result: (data) {
            Navigation.push(const GetStartedScreen());
          },
          loading: handleLoading,
        );
      },
    );
  }
}
