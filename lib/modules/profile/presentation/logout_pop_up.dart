import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/navigation_utils/routes.dart';

void showCustomDialog(
    /*BuildContext context, String title, String subTitle, String cancelButtonText, String acceptButtonText,
    {Function()? onTap}*/
    ) async {
  return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 55.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                //  text: title,
                text: "Do you want to logout the\naccount?",
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
                fontSize: 18.sp,
                textAlign: TextAlign.center,
              ).paddingOnly(left: 14.w, right: 14.w, top: 5.h,bottom: 20.h),
              /*AppText(
                // text: subTitle,
                text: "Ready to say goodbye? Deleting your account will remove all your data from our Car Fixer app.",
                fontWeight: FontWeight.w400,
                fontSize: 12.5.sp,
                color: AppColors.grey60,
                letterSpacing: 0.3,
                height: 1.4.h,
                textAlign: TextAlign.center,
              ).paddingOnly(
                top: 20.h,
                bottom: 20.h,
                left: 16.w,
                right: 16.w,
              ),*/
              GestureDetector(
                onTap: () {
                  SharedPreferencesHelper.instance.clearSharedPreferences();
                  Navigation.replaceAll(Routes.signIn);
                  GoogleSignIn().signOut();
                  SharedPreferencesHelper.instance.setLogInUser(value: false);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border(
                      top: BorderSide(color: AppColors.borderColor.withOpacity(0.6), width: 0.5),
                      bottom: BorderSide(color: AppColors.borderColor.withOpacity(0.6), width: 0.5),
                    ),
                  ),
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: "Logout",
                    color: AppColors.logoutColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ).paddingSymmetric(vertical: 12.h),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: "Cancel",
                    color: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ).paddingSymmetric(vertical: 12.h),
                ),
              ),
            ],
          ).paddingOnly(top: 20.h),
        );
      });
}
