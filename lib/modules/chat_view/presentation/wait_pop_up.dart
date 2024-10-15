import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/profile/controller/profile_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/app_preferences.dart';
import '../../../utils/app_string.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../controller/chat_controller.dart';
import '../controller/pdf_view_controller.dart';

void shoWaitDialog() async {
  return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 55.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 70.h, child: Lottie.asset(JsonAnimation.carJson)),
              AppText(
                text: AppString.waitSubText,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                textAlign: TextAlign.center,
                color: AppColors.blackColor,
              ).paddingOnly(left: 16.w, right: 16.w, bottom: 20, top: 15),
            ],
          ).paddingOnly(top: 20.h),
        );
      });
}
