import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/profile/controller/profile_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/app_preferences.dart';
import '../../../utils/app_string.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../controller/pdf_view_controller.dart';

void showDownloadDialog(PdfViewController pdfViewController, pdfData) async {
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
                text: AppString.doYouWantToDownload,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
                fontSize: 18.sp,
                textAlign: TextAlign.center,
              ).paddingOnly(
                left: 14.w,
                right: 14.w,
                top: 5.h,
              ),
              AppText(
                text: AppString.downloadSubText,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                textAlign: TextAlign.center,
              ).paddingOnly(left: 16.w, right: 16.w, bottom: 20, top: 15),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(
                        Duration(seconds: 2),
                        () {
                          pdfViewController.downloadPdf(responseData: pdfData);
                          Get.back();
                          Get.back();
                        },
                      );
                      return WillPopScope(
                          onWillPop: () async {
                            return await false;
                          },
                          child: Center(
                              child: CircularProgressIndicator(
                            color: AppColors.highlightedColor,
                          )));
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
                    text: AppString.download,
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
