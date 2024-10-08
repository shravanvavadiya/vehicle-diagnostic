import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/behaviour_glow.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../utils/assets.dart';
import '../../../utils/utils.dart';
import '../../../utils/validation_utils.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/info_text_widget.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/log_in_with_email_id_controller.dart';
import 'forgot_password_screen.dart';

class LogInWithEmailScreen extends StatelessWidget {
  const LogInWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: Colors.white,
        child: GetX<LogInWithEmailIdController>(
          init: LogInWithEmailIdController(),
          builder: (controller) => Scaffold(
            appBar: buildAppBar(),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      _buildInfoText(controller),
                      _buildEmailTextFormField(controller),
                      _buildPasswordTextFormField(controller, context),
                      _buildForgotPassword(),
                      _buildLoginButton(controller),
                      _buildDivider(),
                      _buildGoogleAppleBtn(controller),
                    ],
                  ),
                ),
              ).paddingSymmetric(
                horizontal: 16.w,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleAppleBtn(controller) {
    return Platform.isAndroid
        ? CustomButton(
            height: 52.h,
            onTap: controller.continueWithGoogle,
            buttonColor: AppColors.dividerColor,
            text: controller.buttonName.value,
            textColor: AppColors.blackColor,
            svg: IconAsset.googleIcon,
            fontWeight: FontWeight.w500,
          )
        : Platform.isIOS
            ? CustomButton(
                height: 52.h,
                onTap: controller.continueWithApple,
                buttonColor: AppColors.dividerColor,
                text: controller.buttonName.value,
                textColor: AppColors.blackColor,
                svg: IconAsset.appleIcon,
                fontWeight: FontWeight.w500,
              )
            : Container();
  }

  Widget _buildDivider() {
    return SizedBox(
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
          AppText(
            text: AppString.or,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.secondaryColor,
          ).paddingOnly(left: 8.w, right: 8.w),
          Expanded(
            child: Divider(
              color: AppColors.dividerColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    ).paddingOnly(bottom: 32.h + 26.h);
  }

  Widget _buildLoginButton(LogInWithEmailIdController controller) {
    return SizedBox(
      height: 68.h,
      child: Center(
        child: CustomButton(
          height: 50.h,
          isDisabled: (controller.isValidateEmail.value &&
                  controller.isValidPassword.value)
              ? false
              : true,
          disableTextColor: AppColors.whiteColor,
          onTap: () {
            controller.formKey.currentState!.validate()
                ? {
                    controller.logInUserFunction(
                        email: controller.emailController.text,
                        password: controller.passwordController.text),
                  }
                : {};
          },
          text: AppString.login,
        ),
      ),
    ).paddingOnly(bottom: 42.h);
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Get.to(const ForgotPasswordScreen(),
              transition: Transition.rightToLeft);
        },
        child: AppText(
          text: AppString.forgotPassword,
          textDecoration: TextDecoration.underline,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
      ),
    ).paddingOnly(
      top: 8.h,
      bottom: 24.h,
    );
  }

  Widget _buildInfoText(LogInWithEmailIdController controller) {
    return InfoTextWidget(
      title: controller.screenName.value,
      titleFontSize: 24.sp,
      titleFontWeight: FontWeight.w600,
      description: AppString.signInWithTheInformationYouUsedToMakeYourAccount,
      fontSize: 14.sp,
      height: 1.5.h,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _buildPasswordTextFormField(
      LogInWithEmailIdController controller, BuildContext context) {
    return customTextFormField(
      onChanged: (p0) {
        controller.isValidPassword.value =
            controller.passwordController.text.isNotEmpty;
      },
      text: AppString.password,
      hintText: AppString.enterPassword,
      textCapitalization: TextCapitalization.words,
      validator: AppValidation.password,
      controller: controller.passwordController,
      keyboardType: TextInputType.text,
      showPassword: controller.showPassword.value,
      suffixIcon: IconButton(
        onPressed: () {
          controller.showPassword.value = !controller.showPassword.value;
          Utils.hideKeyboardInApp(context);
        },
        icon: SvgPicture.asset(!controller.showPassword.value
            ? IconAsset.openEyes
            : IconAsset.closeEyes),
      ),
    );
  }

  Widget _buildEmailTextFormField(LogInWithEmailIdController controller) {
    return customTextFormField(
            onChanged: (p0) {
              controller.isValidateEmail.value =
                  controller.emailController.text.isNotEmpty;
            },
            text: AppString.email,
            hintText: AppString.emailEx,
            validator: AppValidation.emailValidator,
            textCapitalization: TextCapitalization.none,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress)
        .paddingOnly(
      top: 24.h,
      bottom: 16.h,
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size(0, 45.h),
      child: AppBar(
        leading: const CustomBackArrowWidget().paddingAll(6.w),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
    );
  }
}
