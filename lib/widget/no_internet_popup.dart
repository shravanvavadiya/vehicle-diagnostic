import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:get/get_utils/get_utils.dart';
import '../utils/assets.dart';

Future commonNoInternetDialog(context) {
  return showCupertinoDialog(
      context: (context),
      builder: (context) {
        return Dialog(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadiusDirectional.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    IconAsset.offLineIcon,
                    height: 40.h,
                    width: 40.w,
                  ),
                ).paddingOnly(
                  left: 16.w,
                  top: 25.h,
                  right: 16.w,
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    AppString.noInternetYet,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                      overflow: TextOverflow.clip,
                      fontSize: 16.sp,
                    ),
                  ).paddingOnly(
                    left: 16.w,
                    top: 17.h,
                    right: 16.w,
                  ),
                ),
                Center(
                  child: Text(
                    AppString.checkInternet,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey60,
                      overflow: TextOverflow.clip,
                      fontSize: 14.sp,
                    ),
                  ).paddingOnly(
                    left: 16.w,
                    right: 16.w,
                    bottom: 25.h,
                    top: 17.h,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
