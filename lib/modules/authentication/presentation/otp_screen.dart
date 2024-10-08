import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/behaviour_glow.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/info_text_widget.dart';
import '../controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final String screenNameFlag;
  final String userEmailId;
  final String password;
  final String confirmPassword;

  const OtpScreen({
    super.key,
    required this.screenNameFlag,
    required this.userEmailId,
    required this.password,
    required this.confirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: Colors.white,
        child: GetX<OtpController>(
          init: OtpController(flag: screenNameFlag),
          builder: (controller) => Scaffold(
            appBar: _buildAppbar(),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildInfoText(controller),
                    _buildPinField(controller),
                    _buildResendCodeRow(controller),
                    _buildVerifyBtn(controller),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyBtn(OtpController controller) {
    return Center(
      child: CustomButton(
        height: 52.h,
        onTap: () {
          controller.formKey.currentState!.validate()
              ? screenNameFlag == AppString.forgotPasswordFlag
                  ? {
                      controller.forgotPasswordOtpVerifyFunction(
                          email: userEmailId,
                          otp: controller.pinController.text)
                    }
                  : {
                      controller.accountOtpVerifyFunction(
                          email: userEmailId,
                          otp: controller.pinController.text)
                    }
              : {};
        },
        disableTextColor: AppColors.whiteColor,
        isDisabled: (controller.isValidateOtp.value)
            ? false
            : true,
        text: controller.buttonName.value,
      ),
    ).paddingOnly(top: 8.h);
  }

  Widget _buildResendCodeRow(OtpController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          controller.didNotReceivedTheCode.value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
        ),
        controller.formatTime(controller.secondsRemaining.value).value ==
                "00:00"
            ? GestureDetector(
                onTap: () {
                  controller.resendOtp(
                    email: userEmailId,
                  );
                },
                child: AppText(
                  text: AppString.resendOtp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                  fontSize: 13.sp,
                ).paddingOnly(right: 7.w),
              )
            : Row(
                children: [
                  AppText(
                    text: AppString.resendIn,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ).paddingOnly(right: 7.w),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.watch_later,
                          color: Colors.black,
                        ).paddingOnly(right: 7.w),
                        AppText(
                          text: controller
                              .formatTime(controller.secondsRemaining.value)
                              .value,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                          fontSize: 13.sp,
                        )
                      ],
                    ),
                  )
                ],
              )
      ],
    ).paddingOnly(
      bottom: 24.h,
      top: 8.h,
    );
  }

  Widget _buildPinField(OtpController controller) {
    return Form(
      key: controller.formKey,
      child: Center(
        child: Pinput(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          length: 6,
          keyboardType: TextInputType.number,
          controller: controller.pinController,
          onChanged: (val){
            controller.isValidateOtp.value =
                controller.pinController.text.isNotEmpty;
          },
          autofocus: false,
          defaultPinTheme: PinTheme(
            width: 49.w,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.backgroundColor,
            ),
          ),
          focusedPinTheme: PinTheme(
            width: 49.w,
            height: 56.h,
            textStyle: TextStyle(
                fontSize: 24.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontFamily: AppString.fontName),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.backgroundColor,
            ),
          ),
          pinputAutovalidateMode: PinputAutovalidateMode.disabled,
          validator: (value) {
            log(value!.length.toString());
            if (value.isEmpty) {
              return AppString.pleaseEnterTheOTP;
            }

            return null;
          },
          errorPinTheme: PinTheme(
            width: 49.w,
            height: 56.h,
            textStyle: TextStyle(
                fontSize: 24.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontFamily: AppString.fontName),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.backgroundColor,
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 49.w,
            height: 56.h,
            textStyle: TextStyle(
                fontSize: 24.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontFamily: AppString.fontName),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.backgroundColor,
            ),
          ),
          textInputAction: TextInputAction.next,
          cursor: Container(
            height: 30.h,
            color: AppColors.highlightedColor,
            width: 2,
          ),
          showCursor: true,
          onCompleted: (value) {
            controller.textFieldValidation.value = true;
          },
        ),
      ),
    ).paddingOnly(bottom: 24.h);
  }

  Widget _buildInfoText(OtpController controller) {
    return InfoTextWidget(
      title: controller.screenName.value,
      titleFontSize: 24.sp,
      titleFontWeight: FontWeight.w600,
      description: controller.subText.value,
      fontSize: 14.sp,
      height: 1.5.h,
      fontWeight: FontWeight.w500,
    ).paddingOnly(
      bottom: 32.h,
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
