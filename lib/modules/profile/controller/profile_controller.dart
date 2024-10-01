import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/modules/profile/models/get_user_model.dart';
import 'package:flutter_template/modules/profile/models/profile_model.dart';
import 'package:flutter_template/modules/profile/service/profile_service.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_preferences.dart';
import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../widget/app_snackbar.dart';
import '../../authentication/models/authapi_res.dart';
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
        getUserProfileAPI();
      },
    );
    super.onInit();
  }

  clearData() {
    firstname.clear();
    lastname.clear();
    email.clear();
    postCode.clear();
  }

  /// GetUserAPI ::

  Future<void> getUserProfileAPI() async {
    processApi(
      () => ProfileService.getUserAPI(userId: AppPreference.getInt("UserId")),
      loading: handleLoading,
      result: (data) {
        log("profile image ::${data.profileResponse?.profileData?.photo}");
        getUserProfileModel.value = data;
        final profileData = getUserProfileModel.value.profileResponse?.profileData;
        firstname.text = profileData?.firstName.toString() ?? "";
        lastname.text = profileData?.lastName.toString() ?? "";
        email.text = profileData?.email.toString() ?? "";
        postCode.text = profileData?.postCode.toString() ?? "";
        image?.value = profileData?.photo ?? "";
        log("image.value ::${image?.value}");
      },
    );
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
    processApi(
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
        // Navigation.pushNamed(Routes.homeScreen);
        Get.offAll(HomeScreen());
      },
    );
  }
}
