import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';

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
import '../controller/log_in_with_email_id_controller.dart';
import '../controller/otp_controller.dart';
import 'create_new_password_screen.dart';

class OtpScreen extends StatelessWidget {
  final String screenName;

  const OtpScreen({super.key, required this.screenName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: Colors.white,
        child: GetX<OtpController>(
          init: OtpController(),
          builder: (controller) => Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(0, 45.h),
              child: AppBar(
                leading: CustomBackArrowWidget(
                  onTap: () {
                    Get.back();
                  },
                ).paddingAll(6.r),
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
                  children: [
                    InfoTextWidget(
                      title: controller.screenName.value,
                      titleFontSize: 24.sp,
                      titleFontWeight: FontWeight.w600,
                      description: controller.subText.value,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ).paddingOnly(bottom: 32.h),
                    Align(
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
                                focusBorderColor: Colors.transparent),
                            obscureText: false,
                            style: TextStyle(fontSize: 24.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
                            onChanged: (pin) {
                              print("Changed: " + pin);
                            },
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                            }),
                      ).paddingOnly(top: 24.h, bottom: 16.h),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.didNotReceivedTheCode.value,
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.primaryColor),
                        ),
                        Row(
                          children: [
                            Text(
                              AppString.resendIn,
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.primaryColor),
                            ).paddingOnly(right: 7.w),
                            Icon(
                              Icons.watch_later,
                              color: Colors.black,
                            ).paddingOnly(right: 7.w),
                            Text(
                              controller.formatTime(controller.secondsRemaining.value).value,
                              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.blackColor, fontSize: 13.sp),
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
                          onTap: () {
                            screenName == "createNewAccount"
                                ? Get.back()
                                : Get.to(const CreateNewPasswordScreen(), transition: Transition.rightToLeft);
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
