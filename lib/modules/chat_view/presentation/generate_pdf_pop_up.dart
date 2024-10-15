import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/profile/controller/profile_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/app_preferences.dart';
import '../../../utils/app_string.dart';
import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../controller/chat_controller.dart';
import '../controller/pdf_view_controller.dart';

void showGeneratePdfDialog({required int vehicleId, required ChatController controller}) async {
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
              AppText(
                text: AppString.doYouWantToGenerate,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
                fontSize: 18.sp,
                textAlign: TextAlign.center,
              ).paddingOnly(left: 14.w, right: 14.w, top: 5.h, bottom: 20.h),
              // AppText(
              //   text: AppString.downloadSubText,
              //   fontWeight: FontWeight.w400,
              //   fontSize: 12.sp,
              //   textAlign: TextAlign.center,
              // ).paddingOnly(left: 16.w, right: 16.w, bottom: 20, top: 15),
              GestureDetector(
                onTap: () {
                  Get.back();
                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(
                        Duration(seconds: 2),
                        () {
                          controller.downloadUserReport(vehicle: vehicleId);
                        },
                      );
                      return WillPopScope(
                        onWillPop: () async {
                          return await false;
                        },
                        child: Dialog(
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
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border(
                      top: BorderSide(color: AppColors.borderColor.withOpacity(0.6), width: 0.5.w),
                      bottom: BorderSide(color: AppColors.borderColor.withOpacity(0.6), width: 0.5.w),
                    ),
                  ),
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: AppString.generate,
                    color: AppColors.highlightedColor,
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
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: AppString.cancel,
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
