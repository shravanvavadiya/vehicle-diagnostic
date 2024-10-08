import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/authentication/presentation/log_in_with_email_screen.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';

import '../../../utils/app_string.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../service/auth_service.dart';

class CreateNewPasswordController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.createANewPassword.obs;
  RxString buttonName = AppString.save.obs;

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool password = true.obs;
  RxBool confirmPassword = true.obs;
  RxBool isValidateNewPassword = false.obs;
  RxBool isValidConfirmPassword = false.obs;
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
      Get.offAll(const LogInWithEmailScreen());
      handleLoading(false);
    });
    handleLoading(false);
    return null;
  }
}
