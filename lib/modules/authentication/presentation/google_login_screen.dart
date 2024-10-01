import 'dart:ffi';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/authentication/controller/google_log_in_controller.dart';
import 'package:flutter_template/modules/authentication/presentation/log_in_with_email_id.dart';
import 'package:flutter_template/modules/authentication/widget/story_view_screen.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/utils/social_authentication/apple_auth.dart';
import 'package:flutter_template/utils/social_authentication/google_auth.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';

import '../service/social_service.dart';
import 'create_new_account_screen.dart';

class GoogleLogInScreen extends StatelessWidget {
  GoogleLogInScreen({super.key});

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
                Expanded(
                  child: StoryViewScreen(),
                ),
                CustomButton(
                  height: 50.h,
                  onTap: () {
                    Get.to(const CreateNewAccountScreen(), transition: Transition.rightToLeft);
                  },
                  text: signInController.buttonName.value,
                ).paddingSymmetric(horizontal: 16),
                RichText(
                  text: TextSpan(
                      text: AppString.alreadyWithUs,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.introHintColor,
                      ),
                      children: [
                        TextSpan(
                          text: " ${AppString.signIn}",
                          style: TextStyle(
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(const LogInWithEmailIdScreen(), transition: Transition.rightToLeft);
                            },
                        ),
                      ]),
                ).paddingOnly(top: 16.sp)
              ],
            ).paddingOnly(bottom: 16.h),
          ),
        ),
      ),
    );
  }
}
