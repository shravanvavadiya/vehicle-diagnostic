import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_template/modules/authentication/service/auth_service.dart';
import 'package:flutter_template/modules/authentication/service/social_service.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/utils/api_constants.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/app_string.dart';

class SignInController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString buttonName = AppString.createAccount.obs;
}
