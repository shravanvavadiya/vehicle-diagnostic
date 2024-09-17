import 'dart:async';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
import 'package:flutter_template/modules/authentication/models/signin_form_data.dart';
import 'package:flutter_template/modules/authentication/service/auth_service.dart';
import 'package:flutter_template/modules/authentication/service/social_service.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/utils/api_constants.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/utils/validation_utils.dart';
import 'package:get/get.dart';

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

/*  Future<void> appleLogin() async {
    try {
      isLoading.value = true;

      final token = await SocialLoginService.appleLogin();

      AuthService.googleTokenVerify({
        ApiKeyConstants.deviceType: Constants.android,
        ApiKeyConstants.token: token
      });

      Navigation.push(const GetStartedScreen());
    } catch (e) {
      isLoading.value = false;
    } finally {
      if (isLoading.value) isLoading.value = false;
    }
  }*/
}
