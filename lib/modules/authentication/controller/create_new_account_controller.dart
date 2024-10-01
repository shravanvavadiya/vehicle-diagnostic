import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/authentication/models/create_new_account_model.dart';
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
import '../../../widget/app_snackbar.dart';
import '../../personal_information_view/get_started_screen.dart';
import '../../vehicle_details_view/service/add_vehicle_service.dart';
import '../presentation/otp_screen.dart';
import '../service/auth_service.dart';
import '../service/social_service.dart';
import 'package:get/get.dart';

class CreateNewAccountController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.createAccountWithEmail.obs;
  RxString buttonName = AppString.save.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool createPassword = true.obs;
  RxBool confirmPassword = true.obs;

  Future<CreateNewAccountModel?> createNewAccountFunction(
      {required String email, required String createPassword, required String confirmPassword}) async {
    handleLoading(true);
    Map<String, dynamic> mapData = {
      "confirmPassword": confirmPassword,
      "createPassword": createPassword,
      "email": email,
    };
    await processApi(
      () => AuthService.createNewAccountByEmail(mapData),
      error: (error, stack) {
        log("create Account error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        print("result $result");
        AppSnackBar.showErrorSnackBar(message: result.apiresponse!.data!.message ?? "", title: 'success');
        await Get.to(
            OtpScreen(
              screenNameFlag: AppString.createNewAccountFlag,
              userEmailId: email,
              confirmPassword: confirmPassword,
              password: createPassword,
            ),
            transition: Transition.rightToLeft);
      },
    );

    handleLoading(false);
    return null;
  }
}
