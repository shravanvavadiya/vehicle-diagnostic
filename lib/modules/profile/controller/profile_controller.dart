import 'package:flutter/material.dart';
import 'package:flutter_template/modules/profile/models/profile_model.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';

class ProfileController extends GetxController {

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isValidateName = false.obs;
  RxBool isValidateLastName = false.obs;
  RxBool isValidateEmail = false.obs;
  RxBool isValidatePostCode = false.obs;


  clearData(){
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
        title: AppString.accountInfo,
        icon: IconAsset.document,
       ),
  ];
}
