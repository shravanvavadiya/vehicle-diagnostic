import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/modules/personal_information_view/presentation/user_information_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/api_constants.dart';
import '../../../utils/app_preferences.dart';
import '../../../utils/app_string.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/constants.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/app_snackbar.dart';
import '../../personal_information_view/get_started_screen.dart';
import '../models/create_new_account_model.dart';
import '../service/auth_service.dart';
import '../service/social_service.dart';
import 'package:get/get.dart';

class LogInWithEmailIdController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.loginWithEmailID.obs;
  RxString buttonName = Platform.isAndroid ? AppString.continueWithGoogle.obs : AppString.continueWithApple.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showPassword = true.obs;

  Future<CreateNewAccountModel?> logInUserFunction({
    required String email,
    required String password,
  }) async {
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "email": email,
      "password": password,
    };
    await processApi(
      () => AuthService.logInByEmail(mapData),
      error: (error, stack) {
        log("logInByEmail error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        print("logInByEmail  ${result.apiresponse!.data!.toJson()}");

        // AppSnackBar.showErrorSnackBar(message: result.apiresponse!.data!.message ?? "", title: 'success');
        await SharedPreferencesHelper.instance.setUserToken(result.apiresponse?.data?.token ?? "");
        AppPreference.setInt("UserId", result.apiresponse!.data!.id!);
        print("user id ${AppPreference.getInt("UserId")}");
        SharedPreferencesHelper.instance.setLogInUser(value: result.apiresponse!.data!.profileCompleted!);
        result.apiresponse!.data!.profileCompleted == true ? Get.offAll(HomeScreen()) : Get.offAll(UserInformationScreen());
      },
    );

    handleLoading(false);
    return null;
  }

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
            log("user email id :${data.apiresponse!.data!.email}");
            SharedPreferencesHelper.instance.setString("email", data.apiresponse!.data!.email!);
            log("user profile status :${data.apiresponse!.data!.profileCompleted}");
            data.apiresponse!.data!.profileCompleted == true
                ? {
                    print("user id ${data.apiresponse!.data!.id!}"),
                    AppPreference.setInt("UserId", data.apiresponse!.data!.id!),
                    print("user id ${AppPreference.getInt("UserId")}"),
                    SharedPreferencesHelper.instance.setLogInUser(value: data.apiresponse!.data!.profileCompleted!),
                    await Get.offAll(HomeScreen())
                  }
                : Get.offAll(
                    GetStartedScreen(),
                  );
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
            log("user email id :${data.apiresponse!.data!.email}");
            log("user profile status :${data.apiresponse!.data!.profileCompleted}");
            data.apiresponse!.data!.profileCompleted == true
                ? {
                    print("user id ${data.apiresponse!.data!.id!}"),
                    AppPreference.setInt("UserId", data.apiresponse!.data!.id!),
                    print("user id ${AppPreference.getInt("UserId")}"),
                    SharedPreferencesHelper.instance.setLogInUser(value: data.apiresponse!.data!.profileCompleted!),
                    await Get.offAll(HomeScreen())
                  }
                : Get.offAll(
                    GetStartedScreen(),
                  );
          },
          loading: handleLoading,
        );
      },
    );
  }
}
