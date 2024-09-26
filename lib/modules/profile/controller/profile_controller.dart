import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
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

import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../authentication/models/authapi_res.dart';
import '../../personal_information_view/model/personal_information_model.dart';

class ProfileController extends GetxController
    with LoadingMixin, LoadingApiMixin {
  RxString screenName = AppString.accountInformation.obs;
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  Rx<GetUserProfileModel> getUserProfileModel = GetUserProfileModel().obs;
  Rx<PersonalInformationModel> updateUserProfileModel =
      PersonalInformationModel().obs;
  RxBool isValidateName = false.obs;
  RxBool isValidateLastName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePostCode = false.obs;
  RxBool isValidateImage = false.obs;
  XFile? imagePath;
  RxString image = "".obs;

  clearData() {
    firstname.clear();
    lastname.clear();
    email.clear();
    postCode.clear();
  }

  final List<ProfileModel> profileDataList = [
    ProfileModel(
      title: AppString.accountInfo,
      icon: IconAsset.profile,
    ),
    ProfileModel(
      title: AppString.subscription,
      icon: IconAsset.crown,
    ),
    ProfileModel(
      title: AppString.privacyPolicy,
      icon: IconAsset.security,
    ),
    ProfileModel(
      title: AppString.termsCondition,
      icon: IconAsset.document,
    ),
  ];

  /// GetUserAPI ::

  Future<void> getUserProfileAPI() async {
    int userId = SharedPreferencesHelper.instance.getInt(Constants.keyUserId);
    processApi(
      () => ProfileService.getUserAPI(userId: userId),
      loading: handleLoading,
      result: (data) {
        log("profile image ::${data.profileResponse?.profileData?.photo}");
        getUserProfileModel.value = data;
        final profileData =
            getUserProfileModel.value.profileResponse?.profileData;
        firstname.text = profileData?.firstName.toString() ?? "";
        lastname.text = profileData?.lastName.toString() ?? "";
        email.text = profileData?.email.toString() ?? "";
        postCode.text = profileData?.postCode.toString() ?? "";
        image.value = profileData?.photo ?? "";
      },
    );
  }

  /// Update User API::

  Future<void> updateUserProfileAPI({
    required String firstname,
    required String lastname,
    required String postCode,
    required String imagePath,
  }) async {
    int userId = SharedPreferencesHelper.instance.getInt(Constants.keyUserId);
    processApi(
      () => ProfileService.updateUserAPI(
          id: "$userId",
          email: email.text,
          firstName: firstname,
          lastName: lastname,
          postCode: postCode,
          imagePath: imagePath),
      loading: handleLoading,
      result: (data) {
        updateUserProfileModel.value = data;
        SharedPreferencesHelper.instance.setUserInfo(data);
        Navigation.pushNamed(Routes.homeScreen);
      },
    );
  }
}
