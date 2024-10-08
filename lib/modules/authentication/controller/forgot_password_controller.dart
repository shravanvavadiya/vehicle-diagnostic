import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';
import '../../../utils/app_string.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../models/create_new_account_model.dart';
import '../presentation/otp_screen.dart';
import '../service/auth_service.dart';

class ForgotPasswordController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.forgotPassword.obs;
  RxString subText = AppString.forgotSubText.obs;
  RxString buttonName = AppString.verify.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  RxBool isValidateEmail = false.obs;

  Future<CreateNewAccountModel?> forgotPasswordOtpFunction({required String email}) async {
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "email": email,
    };
    await processApi(() => AuthService.resendOtp(mapData), error: (error, stack) {
      log("forgot password error ---> $error --- $stack");
      handleLoading(false);
    }, result: (result) async {
      print("forgot password $result");
      AppSnackBar.showErrorSnackBar(message: result!.apiresponse!.data!.message ?? "", title: "success");
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
