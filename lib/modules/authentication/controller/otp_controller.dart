import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../custome_package/lib/otp_field.dart';
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

class OtpController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.codeHasBeenSen.obs;
  RxString subText = AppString.otpSubText.obs;
  RxString buttonName = AppString.verify.obs;
  RxString didNotReceivedTheCode = AppString.didNotReceivedTheCode.obs;

  OtpFieldController otpController = OtpFieldController();
  static const maxSeconds = 60; // 1 minute
  RxInt secondsRemaining = maxSeconds.obs;
  Timer? timer;

  void startTimer() {
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
