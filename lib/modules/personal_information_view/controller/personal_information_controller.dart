import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
import 'package:flutter_template/modules/personal_information_view/service/personal_information_service.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';

import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';

class PersonalInformationController extends GetxController {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isValidateName = false.obs;
  RxBool isValidateLastName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePostCode = false.obs;

  RxBool isButtonEnabled = false.obs;

  void updateButtonState() {
    isButtonEnabled.value =
        firstname.text.isNotEmpty && lastname.text.isNotEmpty && email.text.isNotEmpty && postCode.text.isNotEmpty;
  }

  clearData() {
    firstname.clear();
    lastname.clear();
    email.clear();
    postCode.clear();
  }

  /// Personal Information API::

  Future<void> personalInformationAPI({required String gender}) async {
    try {
      if (formKey.currentState!.validate()) {
        final response = await PersonalInformationService.personalInformation(
          bodyData: {
            'email': email.text,
            'firstName': firstname.text,
            'lastName': lastname.text,
            'postCode': postCode.text,
          },
        );
        //  if (response.statusCode == 201 || response.statusCode == 200) {
        // await SharedPreferencesHelper.instance.setString(AppString.cookie, response.cookie![3].toString());
        // await SharedPreferencesHelper.instance.setBoolean(AppString.isCustomer, value: true);
        // await SharedPreferencesHelper.instance.setString(AppString.customerID, response.data?.id.toString() ?? "");
        //  AppSnackBar.showErrorSnackBar(message: "${response.message}", title: "${response.message}");
        //Navigator.pushReplacementNamed(Get.context!, Routes.bottombarScreen);
        //  }
        //debugPrint("response-personalInformationAPI-->${response.statusCode} // ${response.message}");
      }
    } catch (e) {
      log("Exception in personalInformationAPI---->$e");
      AppSnackBar.showErrorSnackBar(message: "Something went wrong", title: "Error");
    } finally {}
  }

  Future<void> nextBtn() async {
    // Navigation.pushNamed(Routes.addVehicle);
    if (formKey.currentState?.validate() ?? false) {
      Navigation.pushNamed(Routes.addVehicle);
    }
  }
}
