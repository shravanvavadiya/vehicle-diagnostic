import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/behaviour_glow.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/validation_utils.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/info_text_widget.dart';
import '../../dashboad/home/presentation/home_screen.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/forgot_password_controller.dart';

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
            appBar: _buildAppbar(),
            body: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    _buildInfoText(controller),
                    _buildEmailTextFormField(controller),
                    _buildVerifyBtn(controller),
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: 16.w),
          ),
        ),
      ),
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

  Widget _buildVerifyBtn(ForgotPasswordController controller) {
    return Center(
      child: CustomButton(
        height: 52.h,
        disableTextColor: AppColors.whiteColor,
        isDisabled: (controller.isValidateEmail.value) ? false : true,
        onTap: () {
          controller.formKey.currentState!.validate() ? {controller.forgotPasswordOtpFunction(email: controller.emailController.text)} : {};
        },
        text: controller.buttonName.value,
      ),
    ).paddingOnly(top: 16.h);
  }

  Widget _buildEmailTextFormField(ForgotPasswordController controller) {
    return customTextFormField(
      onChanged: (p0) {
        controller.isValidateEmail.value = controller.emailController.text.isNotEmpty;
      },
      text: AppString.email,
      hintText: AppString.emailEx,
      validator: AppValidation.emailValidator,
      textCapitalization: TextCapitalization.none,
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
    ).paddingOnly(
      top: 24.h,
      bottom: 16.h,
    );
  }

  Widget _buildInfoText(ForgotPasswordController controller) {
    return InfoTextWidget(
      title: controller.screenName.value,
      titleFontSize: 24.sp,
      titleFontWeight: FontWeight.w600,
      description: controller.subText.value,
      fontSize: 14.sp,
      height: 1.6.h,
      fontWeight: FontWeight.w500,
    ).paddingOnly(bottom: 32.h);
  }
}
