import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/authentication/widget/story_view.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: StoryView(),
            ),
            CustomButton(
              onTap: () {
                Navigation.replaceAll(Routes.getStarted);
              },
              buttonColor: AppColors.backgroundColor,
              text: AppString.continueWithGoogle,
              textColor: AppColors.primaryColor,
              svg: IconAsset.googleIcon,
            ).paddingSymmetric(horizontal: 16.w),
            CustomButton(
              onTap: () {
                Navigation.replaceAll(Routes.getStarted);
              },
              buttonColor: AppColors.backgroundColor,
              text: AppString.continueWithApple,
              textColor: AppColors.primaryColor,
              svg: IconAsset.appleIcon,
            ).paddingSymmetric(horizontal: 16.w, vertical: 12.h),
          ],
        ).paddingOnly(bottom: 16.h),
      ),
    );
  }
}
