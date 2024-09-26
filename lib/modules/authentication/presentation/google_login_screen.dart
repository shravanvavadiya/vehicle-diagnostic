import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/authentication/controller/google_log_in_controller.dart';
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
                Platform.isAndroid
                    ? CustomButton(
                        height: 52.h,
                        onTap: signInController.continueWithGoogle,
                        buttonColor: AppColors.backgroundColor,
                        text: signInController.buttonName.value,
                        textColor: AppColors.primaryColor,
                        svg: IconAsset.googleIcon,
                      ).paddingSymmetric(horizontal: 16.w)
                    : Platform.isIOS
                        ? CustomButton(
                            height: 52.h,
                            onTap: signInController.continueWithApple,
                            buttonColor: AppColors.backgroundColor,
                            text: signInController.buttonName.value,
                            textColor: AppColors.primaryColor,
                            svg: IconAsset.appleIcon,
                          ).paddingSymmetric(horizontal: 16.w, vertical: 12.h)
                        : Container(),
              ],
            ).paddingOnly(bottom: 50.h),
          ),
        ),
      ),
    );
  }
}
