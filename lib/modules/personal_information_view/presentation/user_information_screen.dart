import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/modules/personal_information_view/controller/user_information_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_backarrow_widget.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/custom_textfeild.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';
import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../utils/utils.dart';
import '../../../utils/validation_utils.dart';

class UserInformationScreen extends StatelessWidget {
  UserInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<UserInformationController>(
      init: UserInformationController(),
      builder: (personalInformationController) => SafeArea(
        child: CustomAnnotatedRegions(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(0, 45.h),
              child: AppBar(
                leading: const CustomBackArrowWidget().paddingAll(6.r),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            body:ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Form(
                  key: personalInformationController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoTextWidget(
                        title: personalInformationController.screenName.value,
                        titleFontSize: 24.sp,
                        titleFontWeight: FontWeight.w600,
                        description: AppString.iLoveToKnowWhatToCallYou,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      (personalInformationController.image.value.isNotEmpty)
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 150.h,
                                width: 150.h,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(150.r),
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          personalInformationController.image.value,
                                        ),
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: GestureDetector(
                                  onTap: () async {
              
                                    await Utils().imagePickerModel(
                                        selectImage: personalInformationController.imagePath,
                                        image: personalInformationController.image
                                    );
                                    personalInformationController.isValidateImage.value = true;
                                  },
                                  child: Container(
                                    height: 150.h,
                                    width: 150.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.blackColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(150.r),
                                    ),
                                    child: SvgPicture.asset(IconAsset.editIcon).paddingAll(85.h),
                                  ),
                                ),
                              ).paddingOnly(
                                top: 24.h,
                                bottom: 8.h,
                              ),
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () async {
                                  await Utils().imagePickerModel(
                                      selectImage: personalInformationController.imagePath, image: personalInformationController.image);
                                  if (personalInformationController.image.value.isNotEmpty) {
                                    personalInformationController.isValidateImage.value = true;
                                  } else {
                                    personalInformationController.isValidateImage.value = false;
                                  }
                                },
                                child: Container(
                                  height: 150.h,
                                  width: 150.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundColor,
                                    borderRadius: BorderRadius.circular(150.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(IconAsset.uploadIcon).paddingOnly(bottom: 6.h),
                                      AppText(
                                        text: AppString.tapToAdd,
                                        textAlign: TextAlign.center,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ).paddingOnly(top: 5.h)
                                    ],
                                  ),
                                ).paddingOnly(top: 24.h, bottom: 8.h),
                              ),
                            ),
                      customTextFormField(
                        onChanged: (p0) {
                          personalInformationController.isValidateName.value = personalInformationController.firstname.text.isNotEmpty;
                        },
                        text: AppString.firstName,
                        hintText: AppString.firstName,
                        validator: AppValidation.nameValidator,
                        textCapitalization: TextCapitalization.words,
                        controller: personalInformationController.firstname,
                      ).paddingOnly(top: 24.h, bottom: 16.h),
                      customTextFormField(
                        onChanged: (p0) {
                          personalInformationController.isValidateLastName.value = personalInformationController.lastname.text.isNotEmpty;
                        },
                        text: AppString.lastName,
                        hintText: AppString.lastName,
                        textCapitalization: TextCapitalization.words,
                        validator: AppValidation.lastNameValidator,
                        controller: personalInformationController.lastname,
                      ),
                      customTextFormField(
                        readOnly: true,
                        /*  onChanged: (p0) {
                          personalInformationController.isValidateEmail.value = personalInformationController.email.text.isNotEmpty;
                        },*/
                        text: AppString.email,
                        hintText: AppString.emailEx,
                        controller: personalInformationController.email,
                        keyboardType: TextInputType.emailAddress,
                        // validator: AppValidation.emailValidator,
                      ).paddingSymmetric(vertical: 16.h),
                      customTextFormField(
                        onChanged: (p0) {
                          personalInformationController.isValidatePostCode.value = personalInformationController.postCode.text.isNotEmpty;
                        },
                        text: AppString.postCode,
                        keyboardType: TextInputType.number,
                        hintText: AppString.postCode,
                        maxLength: 6,
                        validator: AppValidation.postCode,
                        controller: personalInformationController.postCode,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
            floatingActionButton: CustomButton(
              onTap: () async {
                log("image path ${personalInformationController.image.value}");
                if (personalInformationController.formKey.currentState?.validate() ?? false) {
                  await personalInformationController.personalInformationAPI(
                      email: personalInformationController.email.text,
                      firstname: personalInformationController.firstname.text,
                      lastname: personalInformationController.lastname.text,
                      postCode: personalInformationController.postCode.text,
                      imagePath: personalInformationController.image.value);
                }
              },
              isLoader: personalInformationController.isPersonalInformation.value,
              isDisabled: (personalInformationController.isValidateName.value &&
                      personalInformationController.isValidateLastName.value &&
                      personalInformationController.isValidatePostCode.value &&
                      personalInformationController.image.value.isNotEmpty)
                  ? false
                  : true,
              buttonColor: AppColors.highlightedColor,
              disableTextColor: AppColors.whiteColor,
              height: 52.h,
              width: 113.w,
              endSvgHeight: 16.h,
              fontSize: 15.h,
              endSvg: IconAsset.forwardArrow,
              text: AppString.next,
              borderRadius: BorderRadius.circular(46),
            ).paddingOnly(bottom: 25.h),
          ),
        ),
      ),
    );
  }
}

Widget customTextFormField({
  String? Function(String?)? validator,
  required String text,
  required String hintText,
   int? maxLength,
  TextCapitalization? textCapitalization,
  bool? readOnly,
  Function(String)? onChanged,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(
        text: text,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ).paddingOnly(bottom: 6.h),
      CustomTextField(
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        controller: controller,
        hintText: hintText,
        validator: validator,
        keyboardType: keyboardType,
      ),
    ],
  );
}
