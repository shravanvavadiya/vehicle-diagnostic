import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
import 'package:flutter_template/modules/personal_information_view/model/personal_information_model.dart';
import 'package:flutter_template/modules/personal_information_view/service/personal_information_service.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_string.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../vehicle_details_view/presentation/add_vehicle_screen.dart';

class UserInformationController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.mayIInquireAboutYourName.obs;
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
          log("user Data ${data}");
          bool userAccountAccess = personalInformationModel.value.apiresponse?.data?.profileCompleted ?? false;
          log("userAccountAccess $userAccountAccess");
          await SharedPreferencesHelper.instance.setInt(Constants.keyUserId, personalInformationModel.value.apiresponse?.data?.id ?? 0);
          // await SharedPreferencesHelper.instance.setUser(data);
          SharedPreferencesHelper.instance.setLogInUser(value: userAccountAccess);
          Get.offAll(const AddVehicleScreen());
        },
      );
    }
    handleLoading(false);
  }

  @override
  void onInit() {
    email.text = SharedPreferencesHelper.instance.getString("email");
    // TODO: implement onInit
    super.onInit();
  }
}
