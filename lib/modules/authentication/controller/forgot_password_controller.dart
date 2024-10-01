import 'dart:async';
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
import '../models/create_new_account_model.dart';
import '../presentation/otp_screen.dart';
import '../service/auth_service.dart';
import '../service/social_service.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.forgotPassword.obs;
  RxString subText = AppString.forgotSubText.obs;
  RxString buttonName = AppString.verify.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  Future<CreateNewAccountModel?> resendOtp({required String email}) async {
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "email": email,
    };
    await processApi(() => AuthService.resendOtp(mapData), error: (error, stack) {
      log("forgot password error ---> $error --- $stack");
      handleLoading(false);
    }, result: (result) async {
      print("forgot password $result");
      Get.to(
        OtpScreen(
          screenNameFlag: AppString.forgotPasswordFlag,
          userEmailId: email,
          password: "",
          confirmPassword: "",
        ),
        transition: Transition.rightToLeft,
      );
      handleLoading(false);
    });
    handleLoading(false);
    return null;
  }
}
