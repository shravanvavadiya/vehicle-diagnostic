import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/authentication/controller/google_log_in_controller.dart';
import 'package:flutter_template/modules/authentication/presentation/log_in_with_email_screen.dart';
import 'package:flutter_template/modules/authentication/widget/story_view_screen.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';
import 'create_new_account_screen.dart';

class GoogleLogInScreen extends StatelessWidget {
  const GoogleLogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SignInController>(
      init: SignInController(),
      builder: (signInController) => CustomAnnotatedRegions(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SafeArea(
            child: Column(
              children: [
                const Expanded(
                  child: StoryViewScreen(),
                ),
                buildButtonWithSignIn(signInController)
                    .paddingSymmetric(horizontal: 16.w),
              ],
            ).paddingOnly(bottom: 25.h),
          ),
        ),
      ),
    );
  }

  Widget buildButtonWithSignIn(SignInController signInController) {
    return Column(
      children: [
        CustomButton(
          height: 50.h,
          onTap: () {
            Get.to(const CreateNewAccountScreen(),
                transition: Transition.rightToLeft);
          },
          text: signInController.buttonName.value,
        ),
        RichText(
          text: TextSpan(
              text: AppString.alreadyWithUs,
              style: TextStyle(
                fontFamily: AppString.fontName,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.introHintColor,
              ),
              children: [
                TextSpan(
                  text: " ${AppString.signIn}",
                  style: TextStyle(
                    fontFamily: AppString.fontName,
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(const LogInWithEmailScreen(),
                          transition: Transition.rightToLeft);
                    },
                ),
              ]),
        ).paddingOnly(top: 16.h)
      ],
    );
  }
}
