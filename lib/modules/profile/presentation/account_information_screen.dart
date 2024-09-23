import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';
import '../../../utils/validation_utils.dart';
import '../../personal_information_view/presentation/personal_information_screen.dart';
import '../controller/profile_controller.dart';

class AccountInformationScreen extends StatefulWidget {
  AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() => _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        profileController.getUserProfileAPI();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
      statusBarColor: AppColors.transparent,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leadingWidth: 30,
          elevation: 0,
          title: AppText(
            text: AppString.accountInformation,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600,
            fontSize: 17.sp,
          ),
          leading: GestureDetector(
            onTap: () {
              Navigation.pop();
            },
            child: SvgPicture.asset(
              IconAsset.leftArrow,
              height: 18.h,
            ),
          ).paddingOnly(left: 16.w),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: profileController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextFormField(
                        text: AppString.firstName,
                        hintText: AppString.firstName,
                        validator: AppValidation.nameValidator,
                        controller: profileController.firstname,
                        onChanged: (String) {
                          profileController.isValidateName.value = profileController.firstname.text.isNotEmpty;
                        },
                      ).paddingOnly(top: 24.h, bottom: 16.h),
                      customTextFormField(
                        text: AppString.lastName,
                        hintText: AppString.lastName,
                        validator: AppValidation.lastNameValidator,
                        controller: profileController.lastname,
                        onChanged: (String) {
                          profileController.isValidateLastName.value = profileController.lastname.text.isNotEmpty;
                        },
                      ),
                      customTextFormField(
                        text: AppString.email,
                        hintText: AppString.emailEx,
                        controller: profileController.email,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidation.emailValidator,
                        onChanged: (String) {
                          profileController.isValidateEmail.value = profileController.email.text.isNotEmpty;
                        },
                      ).paddingSymmetric(vertical: 16.h),
                      customTextFormField(
                        text: AppString.postCode,
                        hintText: AppString.postCode,
                        validator: AppValidation.postCode,
                        controller: profileController.postCode,
                        onChanged: (String) {
                          profileController.isValidatePostCode.value = profileController.postCode.text.isNotEmpty;
                        },
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                ),
              ),
            ),
            Obx(
              () => CustomButton(
                onTap: () async {
                  if (profileController.formKey.currentState?.validate() ?? false) {
                    profileController.updateUserProfileAPI(
                        postCode: profileController.postCode.text,
                        firstName: profileController.firstname.text,
                        lastName: profileController.lastname.text);
                  }
                },
                isDisabled: (profileController.isValidateName.value &&
                        profileController.isValidateLastName.value &&
                        profileController.isValidateEmail.value &&
                        profileController.isValidatePostCode.value)
                    ? false
                    : true,
                height: 52.h,
                buttonColor: AppColors.highlightedColor,
                fontSize: 15.h,
                disableTextColor: AppColors.whiteColor,
                text: AppString.updateProfile,
                borderRadius: BorderRadius.circular(8.r),
              ).paddingSymmetric(
                horizontal: 16.w,
                vertical: 25.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
