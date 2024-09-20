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
import 'package:get/get.dart';

import '../../../utils/assets.dart';

class ProfileController extends GetxController with LoadingMixin, LoadingApiMixin {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<GetUserProfileModel> getUserProfileModel = GetUserProfileModel().obs;
  RxBool isValidateName = false.obs;
  RxBool isValidateLastName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePostCode = false.obs;

  clearData() {
    firstname.clear();
    lastname.clear();
    email.clear();
    postCode.clear();
  }

  @override
  void onInit() {
    getUserProfileAPI();
    super.onInit();
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
      title: AppString.accountInfo,
      icon: IconAsset.document,
    ),
  ];

  /// GetUserAPI ::

  Future<void> getUserProfileAPI() async {
    int userId = SharedPreferencesHelper.instance.getInt(Constants.keyUserId);
    handleLoading(true);
    processApi(
          () => ProfileService.getUserAPI(userId: userId),
      error: (error, stack) => handleLoading(false),
      loading: handleLoading,
      result: (data) {
        getUserProfileModel.value = data;
        firstname.text = getUserProfileModel.value.profileResponse?.profileData?.firstName.toString() ?? "";
        lastname.text = getUserProfileModel.value.profileResponse?.profileData?.lastName.toString() ?? "";
        email.text = getUserProfileModel.value.profileResponse?.profileData?.email.toString() ?? "";
        postCode.text = getUserProfileModel.value.profileResponse?.profileData?.postCode.toString() ?? "";
      },
    );
   handleLoading(false);
  }
}
