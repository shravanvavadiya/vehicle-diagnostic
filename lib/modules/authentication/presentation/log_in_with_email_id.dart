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
import '../controller/create_new_password_controller.dart';
import '../controller/log_in_with_email_id_controller.dart';
import 'forgot_password_screen.dart';

class LogInWithEmailIdScreen extends StatelessWidget {
  const LogInWithEmailIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: Colors.white,
        child: GetX<LogInWithEmailIdController>(
          init: LogInWithEmailIdController(),
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
                      description: AppString.signInWithTheInformationYouUsedToMakeYourAccount,
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
                            keyboardType: TextInputType.emailAddress)
                        .paddingOnly(top: 24.h, bottom: 16.h),
                    customTextFormField(
                      onChanged: (p0) {},
                      text: AppString.password,
                      hintText: AppString.enterPassword,
                      textCapitalization: TextCapitalization.words,
                      validator: AppValidation.lastNameValidator,
                      controller: controller.passwordController,
                      keyboardType: TextInputType.text,
                      showPassword: controller.showPassword.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.showPassword.value = !controller.showPassword.value;
                          Utils.hideKeyboardInApp(context);
                        },
                        icon: SvgPicture.asset(!controller.showPassword.value ? IconAsset.openEyes : IconAsset.closeEyes),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(const ForgotPasswordScreen(), transition: Transition.rightToLeft);
                        },
                        child: Text(
                          AppString.forgotPassword,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ).paddingOnly(top: 8.h, bottom: 24.h),
                    Container(
                      height: 68.h,
                      child: Center(
                        child: CustomButton(
                          height: 50.h,
                          onTap: () {},
                          text: AppString.login,
                        ),
                      ),
                    ).paddingOnly(bottom: 42.h),
                    Container(
                      width: Get.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.dividerColor,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            AppString.or,
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: AppColors.secondaryColor),
                          ).paddingOnly(left: 8.w, right: 8.w),
                          Expanded(
                            child: Divider(
                              color: AppColors.dividerColor,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ).paddingOnly(bottom: 32.h + 26.h),
                    Platform.isAndroid
                        ? CustomButton(
                            height: 52.h,
                            onTap: controller.continueWithGoogle,
                            buttonColor: AppColors.backgroundColor,
                            text: controller.buttonName.value,
                            textColor: AppColors.primaryColor,
                            svg: IconAsset.googleIcon,
                          )
                        : Platform.isIOS
                            ? CustomButton(
                                height: 52.h,
                                onTap: controller.continueWithApple,
                                buttonColor: AppColors.backgroundColor,
                                text: controller.buttonName.value,
                                textColor: AppColors.primaryColor,
                                svg: IconAsset.appleIcon,
                              )
                            : Container(),
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
