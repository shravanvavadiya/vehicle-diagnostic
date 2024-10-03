import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/modules/authentication/presentation/log_in_with_email_id.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';

import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/utils.dart';
import '../../../utils/validation_utils.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/info_text_widget.dart';
import '../../dashboad/home/presentation/home_screen.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/create_new_password_controller.dart';
import 'forgot_password_screen.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final String userEmail;

  const CreateNewPasswordScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: Colors.white,
        child: GetX<CreateNewPasswordController>(
          init: CreateNewPasswordController(),
          builder: (controller) => Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(0, 45.h),
              child: AppBar(
                leading: const CustomBackArrowWidget().paddingAll(6.r),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InfoTextWidget(
                      title: controller.screenName.value,
                      titleFontSize: 24.sp,
                      titleFontWeight: FontWeight.w600,
                      description: AppString.createNewPasswordSubText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ).paddingOnly(bottom: 32.h),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          customTextFormField(
                            onChanged: (p0) {},
                            text: AppString.newPassword,
                            hintText: AppString.password,
                            validator: AppValidation.password,
                            textCapitalization: TextCapitalization.words,
                            controller: controller.passwordController,
                            showPassword: controller.password.value,
                            keyboardType: TextInputType.text,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.password.value = !controller.password.value;
                                Utils.hideKeyboardInApp(context);
                              },
                              icon: SvgPicture.asset(!controller.password.value ? IconAsset.openEyes : IconAsset.closeEyes),
                            ),
                          ).paddingOnly(top: 24.h, bottom: 16.h),
                          customTextFormField(
                            onChanged: (p0) {},
                            text: AppString.confirmPassword,
                            hintText: AppString.password,
                            textCapitalization: TextCapitalization.words,
                            validator: (p0) {
                              if (controller.confirmPasswordController.text.isEmpty) {
                                return AppString.pleaseEnterPassword;
                              } else if (controller.confirmPasswordController.text.length <= 6) {
                                return AppString.passwordCodeMustBeDigits;
                              } else if (controller.confirmPasswordController.text != controller.passwordController.text) {
                                return AppString.bothPasswordNotMatch;
                              }
                            },
                            controller: controller.confirmPasswordController,
                            keyboardType: TextInputType.text,
                            showPassword: controller.confirmPassword.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.confirmPassword.value = !controller.confirmPassword.value;
                                Utils.hideKeyboardInApp(context);
                              },
                              icon: SvgPicture.asset(!controller.confirmPassword.value ? IconAsset.openEyes : IconAsset.closeEyes),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 68.h,
                      child: Center(
                        child: CustomButton(
                          height: 50.h,
                          onTap: () {
                            controller.formKey.currentState!.validate()
                                ? {
                                    controller.newPasswordFunction(
                                      confirmPassword: controller.confirmPasswordController.text,
                                      email: userEmail,
                                      newPassword: controller.passwordController.text,
                                    )
                                  }
                                : {};
                          },
                          text: AppString.save,
                        ),
                      ),
                    ).paddingOnly(top: 25.h),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        ),
      ),
    );
  }
}
