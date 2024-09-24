import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
import 'package:flutter_template/modules/personal_information_view/model/personal_information_model.dart';
import 'package:flutter_template/modules/personal_information_view/service/personal_information_service.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';

class PersonalInformationController extends GetxController with LoadingMixin, LoadingApiMixin {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<PersonalInformationModel> personalInformationModel = PersonalInformationModel().obs;
  RxBool isValidateName = false.obs;
  RxBool isPersonalInformation = false.obs;
  RxBool isValidateLastName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePostCode = false.obs;
  XFile? imagePath;
  RxString image = "".obs;
  RxBool isValidateImage = false.obs;

  RxBool isButtonEnabled = false.obs;

  void updateButtonState() {
    isButtonEnabled.value = firstname.text.isNotEmpty && lastname.text.isNotEmpty && email.text.isNotEmpty && postCode.text.isNotEmpty;
  }

  clearData() {
    firstname.clear();
    lastname.clear();
    email.clear();
    postCode.clear();
  }

  /// Personal Information API::
  Future<void> personalInformationAPI({
    required String email,
    required String firstname,
    required String lastname,
    required String postCode,
    required String imagePath,
  }) async {
    handleLoading(true);
    if (formKey.currentState!.validate()) {
      await processApi(
        () => PersonalInformationService.personalInformation(
            email: email, firstName: firstname, lastName: lastname, postCode: postCode, imagePath: imagePath),
        error: (error, stack) {
          log("Exception in personalInformationAPI---->$error");
          AppSnackBar.showErrorSnackBar(message: "Something went wrong", title: "Error");
          handleLoading(false);
        },
        result: (data) async {
          personalInformationModel.value = data;
          log("result ${personalInformationModel.value.apiresponse?.data?.email??""}");
          await SharedPreferencesHelper.instance.setInt(Constants.keyUserId, personalInformationModel.value.apiresponse?.data?.id ?? 0);
          //  await SharedPreferencesHelper.instance.setUser(data);
          Navigation.pushNamed(Routes.addVehicle);
        },
      );
    }
    handleLoading(false);
  }

/* Future<void> personalInformationAPI({
    required String email,
    required String firstname,
    required String lastname,
    required String postCode,
  }) async {
    try {
      isPersonalInformation.value = true;
      if (formKey.currentState!.validate()) {
        personalInformationModel.value =
        await PersonalInformationService.personalInformation(
          bodyData: {
            'email': email,
            'firstName': firstname,
            'lastName': lastname,
            'postCode': postCode,
          },
        );
      }
    } catch (e) {
      log("Exception in personalInformationAPI---->$e");
      isPersonalInformation.value = false;
      AppSnackBar.showErrorSnackBar(
          message: "Something went wrong", title: "Error");
    } finally {
      isPersonalInformation.value = false;
    }
  }
*/
}
