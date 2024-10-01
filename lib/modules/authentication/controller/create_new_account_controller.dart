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
import '../service/auth_service.dart';
import '../service/social_service.dart';
import 'package:get/get.dart';

class CreateNewAccountController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.createAccountWithEmail.obs;
  RxString buttonName = AppString.save.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool createPassword = false.obs;
  RxBool confirmPassword = false.obs;
}
