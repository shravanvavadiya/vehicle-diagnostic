import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/modules/authentication/presentation/log_in_with_email_id.dart';
import 'package:flutter_template/modules/authentication/presentation/otp_screen.dart';
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
import '../controller/create_new_account_controller.dart';
import '../controller/log_in_with_email_id_controller.dart';
import 'forgot_password_screen.dart';

class CreateNewAccountScreen extends StatelessWidget {
  const CreateNewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: Colors.white,
        child: GetX<CreateNewAccountController>(
          init: CreateNewAccountController(),
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
                      description: AppString.createNewAccountSubText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ).paddingOnly(bottom: 32.h),
                    customTextFormField(
                        onChanged: (p0) {},
                        text: AppString.email,
                        hintText: AppString.emailEx,
                        validator: AppValidation.nameValidator,
                        textCapitalization: TextCapitalization.words,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress),
                    customTextFormField(
                      onChanged: (p0) {},
                      text: AppString.createPassword,
                      hintText: AppString.createPassword,
                      validator: AppValidation.nameValidator,
                      textCapitalization: TextCapitalization.words,
                      controller: controller.createPasswordController,
                      showPassword: controller.createPassword.value,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.createPassword.value = !controller.createPassword.value;
                          Utils.hideKeyboardInApp(context);
                        },
                        icon: SvgPicture.asset(!controller.createPassword.value ? IconAsset.openEyes : IconAsset.closeEyes),
                      ),
                    ).paddingOnly(top: 24.h, bottom: 16.h),
                    customTextFormField(
                      onChanged: (p0) {},
                      text: AppString.confirmPassword,
                      hintText: AppString.confirmPassword,
                      textCapitalization: TextCapitalization.words,
                      validator: AppValidation.lastNameValidator,
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
                    Container(
                      height: 68.h,
                      child: Center(
                        child: CustomButton(
                          height: 50.h,
                          onTap: () {
                            Get.to(
                                const OtpScreen(
                                  screenName: "createNewAccount",
                                ),
                                transition: Transition.rightToLeft);
                          },
                          text: AppString.createAccount,
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
