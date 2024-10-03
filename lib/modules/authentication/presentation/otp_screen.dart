import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../custome_package/lib/otp_field.dart';
import '../../../custome_package/lib/otp_field_style.dart';
import '../../../custome_package/lib/style.dart';
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
import '../controller/otp_controller.dart';
import 'create_new_password_screen.dart';

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InfoTextWidget(
                      title: controller.screenName.value,
                      titleFontSize: 24.sp,
                      titleFontWeight: FontWeight.w600,
                      description: controller.subText.value,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ).paddingOnly(bottom: 32.h),
                    /*Align(
                      alignment: Alignment.bottomLeft,
                      child: Center(
                        child: OTPTextField(
                            controller: controller.otpController,
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 49.w,
                            fieldHeigth: 60.h,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 4.r,
                            otpFieldStyle: OtpFieldStyle(
                              backgroundColor: AppColors.backgroundColor,
                              borderColor: Colors.transparent,
                              disabledBorderColor: Colors.transparent,
                              enabledBorderColor: Colors.transparent,
                              errorBorderColor: Colors.transparent,
                              focusBorderColor: Colors.transparent,
                            ),
                            obscureText: false,
                            style:
                                TextStyle(fontSize: 24.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600, fontFamily: AppString.fontName),
                            onChanged: (pin) {
                              pin.length == 6
                                  ? {
                                      controller.textFieldValidation.value = true,
                                    }
                                  : {
                                      controller.textFieldValidation.value = false,
                                    };
                            },
                            onCompleted: (pin) {
                              controller.filledOtp.value = pin;
                              controller.textFieldValidation.value = true;
                            }),
                      ).paddingOnly(top: 24.h, bottom: 16.h),
                    ),*/

                    Form(
                      key: controller.formKey,
                      child: Center(
                        child: Pinput(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          length: 6,
                          keyboardType: TextInputType.number,
                          controller: controller.pinController,
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
                            textStyle:
                                TextStyle(fontSize: 24.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600, fontFamily: AppString.fontName),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColors.backgroundColor,
                            ),
                          ),
                          pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                          validator: (value) {
                            log(value!.length.toString());
                            if (value.isEmpty) {
                              return 'Please enter the OTP';
                            }

                            return null;
                          },
                          errorPinTheme: PinTheme(
                            width: 49.w,
                            height: 56.h,
                            textStyle:
                                TextStyle(fontSize: 24.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600, fontFamily: AppString.fontName),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.redColor),
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColors.backgroundColor,
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: 49.w,
                            height: 56.h,
                            textStyle:
                                TextStyle(fontSize: 24.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600, fontFamily: AppString.fontName),
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
                            print("onCompleted value $value");
                            controller.textFieldValidation.value = true;
                          },
                        ),
                      ),
                    ).paddingOnly(bottom: 24.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.didNotReceivedTheCode.value,
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.primaryColor),
                        ),
                        controller.formatTime(controller.secondsRemaining.value).value == "00:00"
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
                                        Icon(
                                          Icons.watch_later,
                                          color: Colors.black,
                                        ).paddingOnly(right: 7.w),
                                        AppText(
                                          text: controller.formatTime(controller.secondsRemaining.value).value,
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
                    ).paddingOnly(bottom: 24.h, top: 8.h),
                    Container(
                      height: 68.h,
                      child: Center(
                        child: CustomButton(
                          height: 50.h,
                          buttonColor: AppColors.highlightedColor,
                          onTap: () {
                            controller.formKey.currentState!.validate()
                                ? screenNameFlag == AppString.forgotPasswordFlag
                                    ? {controller.forgotPasswordOtpVerifyFunction(email: userEmailId, otp: controller.pinController.text)}
                                    : {controller.accountOtpVerifyFunction(email: userEmailId, otp: controller.pinController.text)}
                                : {};
                          },
                          text: controller.buttonName.value,
                        ),
                      ),
                    ).paddingOnly(top: 8.h),
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
