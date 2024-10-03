import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
import '../controller/forgot_password_controller.dart';
import '../controller/create_new_password_controller.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: Colors.white,
        child: GetX<ForgotPasswordController>(
          init: ForgotPasswordController(),
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
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InfoTextWidget(
                        title: controller.screenName.value,
                        titleFontSize: 24.sp,
                        titleFontWeight: FontWeight.w600,
                        description: controller.subText.value,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ).paddingOnly(bottom: 32.h),
                      customTextFormField(
                        onChanged: (p0) {},
                        text: AppString.email,
                        hintText: AppString.emailEx,
                        validator: AppValidation.emailValidator,
                        textCapitalization: TextCapitalization.none,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ).paddingOnly(top: 24.h, bottom: 16.h),
                      Container(
                        height: 68.h,
                        child: Center(
                          child: CustomButton(
                            height: 50.h,
                            onTap: () {
                              controller.formKey.currentState!.validate() ? {controller.forgotPasswordOtpFunction(email: controller.emailController.text)} : {};
                            },
                            text: controller.buttonName.value,
                          ),
                        ),
                      ).paddingOnly(top: 8.h),
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        ),
      ),
    );
  }
}
