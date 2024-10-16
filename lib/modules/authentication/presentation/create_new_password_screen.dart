import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/behaviour_glow.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/assets.dart';
import '../../../utils/utils.dart';
import '../../../utils/validation_utils.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/info_text_widget.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/create_new_password_controller.dart';

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
                    _buildInfoTextWidget(controller),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          _buildNewPasswordField(controller, context),
                          _buildConfirmPasswordField(controller, context),
                        ],
                      ),
                    ),
                    _buildSaveBtn(controller),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveBtn(CreateNewPasswordController controller) {
    return SizedBox(
      height: 68.h,
      child: Center(
        child: CustomButton(
          height: 52.h,
          onTap: () {
            controller.formKey.currentState!.validate()
                ? {
                    controller.newPasswordFunction(
                      confirmPassword:
                          controller.confirmPasswordController.text,
                      email: userEmail,
                      newPassword: controller.passwordController.text,
                    )
                  }
                : {};
          },
          isDisabled: (controller.isValidateNewPassword.value &&
              controller.isValidConfirmPassword.value)
              ? false
              : true,
          disableTextColor: AppColors.whiteColor,
          text: AppString.save,
        ),
      ),
    ).paddingOnly(top: 25.h);
  }

  Widget _buildConfirmPasswordField(
      CreateNewPasswordController controller, BuildContext context) {
    return customTextFormField(
      onChanged: (p0) {
        controller.isValidConfirmPassword.value =
            controller.confirmPasswordController.text.isNotEmpty;
      },
      text: AppString.confirmPassword,
      hintText: AppString.password,
      textCapitalization: TextCapitalization.words,
      validator: (p0) {
        if (controller.confirmPasswordController.text.isEmpty) {
          return AppString.pleaseEnterPassword;
        } else if (controller.confirmPasswordController.text.length < 6) {
          return AppString.passwordCodeMustBeDigits;
        } else if (controller.confirmPasswordController.text !=
            controller.passwordController.text) {
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
        icon: SvgPicture.asset(!controller.confirmPassword.value
            ? IconAsset.openEyes
            : IconAsset.closeEyes),
      ),
    );
  }

  Widget _buildNewPasswordField(
      CreateNewPasswordController controller, BuildContext context) {
    return customTextFormField(
      onChanged: (p0) {
        controller.isValidateNewPassword.value =
            controller.passwordController.text.isNotEmpty;
      },
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
        icon: SvgPicture.asset(!controller.password.value
            ? IconAsset.openEyes
            : IconAsset.closeEyes),
      ),
    ).paddingOnly(top: 24.h, bottom: 16.h);
  }

  Widget _buildInfoTextWidget(CreateNewPasswordController controller) {
    return InfoTextWidget(
      title: controller.screenName.value,
      titleFontSize: 24.sp,
      titleFontWeight: FontWeight.w600,
      description: AppString.createNewPasswordSubText,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ).paddingOnly(bottom: 32.h);
  }
}
