import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../custome_package/lib/otp_field.dart';
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
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../models/create_new_account_model.dart';
import '../presentation/create_new_password_screen.dart';
import '../service/auth_service.dart';
import '../service/social_service.dart';
import 'package:get/get.dart';

class OtpController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.codeHasBeenSend.obs;
  RxString filledOtp = "".obs;
  RxString screenNameFlag = "".obs;
  RxString subText = AppString.otpSubText.obs;
  RxString buttonName = AppString.verify.obs;
  RxString didNotReceivedTheCode = AppString.didNotReceivedTheCode.obs;
  RxBool textFieldValidation = false.obs;
  TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  OtpController({required String flag}) {
    screenNameFlag.value = flag;
  }

  static const maxSeconds = 10; // 1 minute
  RxInt secondsRemaining = maxSeconds.obs;
  Timer? timer;

  void startTimer() {
    timer?.cancel(); // Cancel any previous timer

    secondsRemaining.value = maxSeconds; // Reset the timer to 60 seconds

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  RxString formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs'.obs;
  }

  Future<CreateNewAccountModel?> accountOtpVerifyFunction({required String email, required String otp}) async {
    print("$email ::: ${otp}");
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "email": email,
      "otp": otp,
    };
    await processApi(() => AuthService.accountOtpVerify(mapData), error: (error, stack) {
      log("otp verify error ---> $error --- $stack");
      handleLoading(false);
    }, result: (result) async {
      print("result  ${result.apiresponse!.data!.toJson()}");

      log("${result.apiresponse?.data?.token}");
      await SharedPreferencesHelper.instance.setUserToken(result.apiresponse?.data?.token ?? "");
      SharedPreferencesHelper.instance.setString("email", result.apiresponse!.data!.email!);
      print("user id ${AppPreference.getInt("UserId")}");
      log("user profile status :${result.apiresponse!.data!.profileCompleted}");
      Get.offAll(const UserInformationScreen(), transition: Transition.rightToLeft);
    });
    return null;
  }

  Future<CreateNewAccountModel?> resendOtp({required String email}) async {
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "email": email,
    };
    await processApi(() => AuthService.resendOtp(mapData), error: (error, stack) {
      log("resend otp verify error ---> $error --- $stack");
      handleLoading(false);
    }, result: (result) async {
      print("resend otp verify success $result");
      startTimer();
      AppSnackBar.showErrorSnackBar(message: "${result!.apiresponse!.data!.message}", title: "success");
      // Get.back();
      handleLoading(false);
    });
    handleLoading(false);
    return null;
  }

  Future<CreateNewAccountModel?> forgotPasswordOtpVerifyFunction({required String email, required String otp}) async {
    print("$email ::: ${otp}");
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "email": email,
      "otp": otp,
    };
    await processApi(() => AuthService.forgotPasswordVerify(mapData), error: (error, stack) {
      log("otp verify error ---> $error --- $stack");
      handleLoading(false);
    }, result: (result) async {
      handleLoading(true);

      Get.to(
          CreateNewPasswordScreen(
            userEmail: email,
          ),
          transition: Transition.rightToLeft);
    });
    return null;
  }

  @override
  void onInit() {
    startTimer();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
