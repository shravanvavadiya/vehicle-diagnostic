import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/assets.dart';
import '../../../utils/behaviour_glow.dart';
import '../../../utils/utils.dart';
import '../../../utils/validation_utils.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/info_text_widget.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/create_new_account_controller.dart';

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
            appBar: _buildAppbar(),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInfoText(controller),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          _buildEmailTextFormField(controller),
                          _buildCreatePasswordTextFormField(
                              controller, context),
                          _buildConfirmPasswordTextFormField(
                              controller, context),
                        ],
                      ),
                    ),
                    _buildCreateAccountBtn(controller, context),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountBtn(
      CreateNewAccountController controller, BuildContext context) {
    return Center(
      child: CustomButton(
        height: 52.h,
        disableTextColor: AppColors.whiteColor,
        isDisabled: (controller.isValidateEmail.value &&
                controller.isValidateCreatePassword.value &&
                controller.isValidateConfirmPassword.value)
            ? false
            : true,
        onTap: () {
          controller.formKey.currentState!.validate()
              ? {
                  controller.createNewAccountFunction(
                    email: controller.emailController.text,
                    confirmPassword: controller.confirmPasswordController.text,
                    createPassword: controller.createPasswordController.text,
                  ),
                }
              : {};
          Utils.hideKeyboardInApp(context);
        },
        text: AppString.createAccount,
      ),
    ).paddingOnly(top: 32.h);
  }

  Widget _buildConfirmPasswordTextFormField(
      CreateNewAccountController controller, BuildContext context) {
    return customTextFormField(
      onChanged: (p0) {
        controller.isValidateConfirmPassword.value =
            controller.confirmPasswordController.text.isNotEmpty;
      },
      text: AppString.confirmPassword,
      hintText: AppString.confirmPassword,
      textCapitalization: TextCapitalization.words,
      controller: controller.confirmPasswordController,
      validator: (p0) {
        if (controller.confirmPasswordController.text.isEmpty) {
          return AppString.pleaseEnterPassword;
        } else if (controller.confirmPasswordController.text.length <= 6) {
          return AppString.passwordCodeMustBeDigits;
        } else if (controller.confirmPasswordController.text !=
            controller.createPasswordController.text) {
          return AppString.bothPasswordNotMatch;
        }
      },
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

  Widget _buildInfoText(CreateNewAccountController controller) {
    return InfoTextWidget(
      title: controller.screenName.value,
      titleFontSize: 24.sp,
      titleFontWeight: FontWeight.w600,
      description: AppString.createNewAccountSubText,
      fontSize: 14.sp,
      height: 1.5.h,
      fontWeight: FontWeight.w500,
    ).paddingOnly(bottom: 32.h);
  }

  Widget _buildCreatePasswordTextFormField(
      CreateNewAccountController controller, BuildContext context) {
    return customTextFormField(
      onChanged: (p0) {
        controller.isValidateCreatePassword.value =
            controller.createPasswordController.text.isNotEmpty;
      },
      text: AppString.createPassword,
      hintText: AppString.createPassword,
      validator: AppValidation.password,
      textCapitalization: TextCapitalization.words,
      controller: controller.createPasswordController,
      showPassword: controller.createPassword.value,
      keyboardType: TextInputType.text,
      suffixIcon: IconButton(
        onPressed: () {
          controller.createPassword.value = !controller.createPassword.value;
          Utils.hideKeyboardInApp(context);
        },
        icon: SvgPicture.asset(!controller.createPassword.value
            ? IconAsset.openEyes
            : IconAsset.closeEyes),
      ),
    ).paddingOnly(
      top: 16.h,
      bottom: 16.h,
    );
  }

  Widget _buildEmailTextFormField(CreateNewAccountController controller) {
    return customTextFormField(
      onChanged: (p0) {
        controller.isValidateEmail.value= controller.emailController.text.isNotEmpty;
      },
      text: AppString.email,
      hintText: AppString.emailEx,
      validator: AppValidation.emailValidator,
      textCapitalization: TextCapitalization.none,
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  PreferredSize _buildAppbar() {
    return PreferredSize(
      preferredSize: Size(0, 45.h),
      child: AppBar(
        leading: const CustomBackArrowWidget().paddingAll(6.r),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
