import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/authentication/presentation/log_in_with_email_id.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
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

class CreateNewPasswordController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.createANewPassword.obs;
  RxString buttonName = AppString.save.obs;

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool password = true.obs;
  RxBool confirmPassword = true.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future newPasswordFunction({
    required String confirmPassword,
    required String email,
    required String newPassword,
  }) async {
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "confirmPassword": confirmPassword,
      "email": email,
      "newPassword": newPassword,
    };
    await processApi(() => AuthService.resetPassword(mapData), error: (error, stack) {
      log("new password api error ---> $error --- $stack");
      handleLoading(false);
    }, result: (result) async {
      print("new password api  success $result");
      AppSnackBar.showErrorSnackBar(message: result?.apiresponse?.data?.message ?? "", title: "success");
      Get.offAll(LogInWithEmailIdScreen());
      handleLoading(false);
    });
    handleLoading(false);
    return null;
  }
}
