import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/modules/profile/models/get_user_model.dart';
import 'package:flutter_template/modules/profile/service/profile_service.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_preferences.dart';
import '../../authentication/presentation/google_login_screen.dart';
import '../../personal_information_view/model/personal_information_model.dart';

class ProfileController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.accountInformation.obs;
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  Rx<GetUserProfileModel> getUserProfileModel = GetUserProfileModel().obs;
  Rx<PersonalInformationModel> updateUserProfileModel = PersonalInformationModel().obs;
  RxBool isValidateName = false.obs;
  RxBool isValidateLastName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePostCode = false.obs;
  RxBool isValidateImage = false.obs;
  XFile? imagePath;
  RxString? image = "".obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getUserProfileModel.value = SharedPreferencesHelper().getUserInfo()!;
        firstname.text = getUserProfileModel.value.profileResponse!.profileData!.firstName!;
        lastname.text = getUserProfileModel.value.profileResponse!.profileData!.lastName!;
        email.text = getUserProfileModel.value.profileResponse!.profileData!.email!;
        postCode.text = getUserProfileModel.value.profileResponse!.profileData!.postCode!;
        image?.value = getUserProfileModel.value.profileResponse?.profileData?.photo != null
            ? getUserProfileModel.value.profileResponse!.profileData!.photo!
            : "";

        isValidateName.value = true;
        isValidateLastName.value = true;
        isValidateEmail.value = true;
        isValidatePostCode.value = true;
        isValidateImage.value = true;

        firstname.addListener(checkIfModified);
        lastname.addListener(checkIfModified);
        email.addListener(checkIfModified);
        postCode.addListener(checkIfModified);
      },
    );
    super.onInit();
  }

  RxBool isModified = false.obs;

  clearData() {
    firstname.clear();
    lastname.clear();
    email.clear();
    postCode.clear();
  }

  void checkIfModified() {
    isModified.value = firstname.text != getUserProfileModel.value.profileResponse?.profileData?.firstName ||
        lastname.text != getUserProfileModel.value.profileResponse?.profileData?.lastName ||
        email.text != getUserProfileModel.value.profileResponse?.profileData?.email ||
        postCode.text != getUserProfileModel.value.profileResponse?.profileData?.postCode ||
        image!.value != getUserProfileModel.value.profileResponse?.profileData?.photo;
  }

  /// Update User API::
  Future<void> updateUserProfileAPI({
    required String email,
    required String firstname,
    required String lastname,
    required String postCode,
    required String? imagePath,
  }) async {
    print("imagePath :: ===$imagePath");
   await processApi(
      () => ProfileService.updateUserAPI(
          id: AppPreference.getInt("UserId"),
          email: email,
          firstName: firstname,
          lastName: lastname,
          postCode: postCode,
          imagePath: imagePath ?? null),
      loading: handleLoading,
      result: (data) async {
        log("Controller Data :: ${data?.apiresponse?.data?.photo}");
        updateUserProfileModel.value = data!;
        SharedPreferencesHelper().setUserInfo(getUserProfileModel.value);
        Get.offAll(HomeScreen());
      },
    );
  }

  Future<void> deleteAccount({required int userId}) async {
    log("user Id ::$userId");
    handleLoading(true);
    await processApi(
      () => ProfileService.deleteUserAccount(userId: userId),
      error: (error, stack) {
        handleLoading(false);
      },
      result: (data) {
        SharedPreferencesHelper.instance.clearSharedPreferences();
        SharedPreferencesHelper.instance.setLogInUser(value: false);
        clearData();
        Get.offAll(const GoogleLogInScreen());
        log("User with ID $userId deleted successfully.");
      },
    );
    handleLoading(false);
  }
}
