import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:get/get.dart';

import '../../../utils/app_text.dart';
import '../../../utils/assets.dart';

class SubscriptionsPlanComponent extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelected;

  SubscriptionsPlanComponent(
      {super.key,
      required this.index,
      required this.isSelected,
      required this.onSelected});

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(12.h),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.04)
              : AppColors.transparent,
          border: Border.all(
              color:
                  isSelected ? AppColors.primaryColor : AppColors.borderColor,
              width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: SvgPicture.asset(
                    IconAsset.light,
                  ).paddingSymmetric(
                    vertical: 10.h,
                    horizontal: 9.w,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: AppString.freePlan,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        fontSize: 16.sp,
                      ),
                      AppText(
                        text: AppString.basicDiagnostics,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey60,
                        fontSize: 12.sp,
                      ).paddingOnly(top: 6.h),
                    ],
                  ).paddingOnly(left: 12.w),
                ),
                Row(
                  children: [
                    AppText(
                      text: "£00.00",
                      fontWeight: FontWeight.w600,
                      color: AppColors.highlightedColor,
                      fontSize: 22.sp,
                    ),
                    AppText(
                      text: " /${AppString.month}",
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                      fontSize: 12.sp,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              height: 15.h,
              thickness: 0.5.h,
              color: AppColors.borderColor,
            ).paddingOnly(top: 20.h, bottom: 10.h,),
            SizedBox(
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "${AppString.credit} :",
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                    fontSize: 15.sp,
                  ),
                  AppText(
                    text: "\u2022  3 credits per month (1 credit = 1 search)",
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    fontSize: 15.sp,
                  ).paddingOnly(top: 8.h),
                ],
              ),
            ),
            SizedBox(
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "${AppString.feature} :",
                        fontWeight: FontWeight.w500,
                        color: AppColors.titleColor,
                        fontSize: 15.sp,
                      ),
                      const Icon(Icons.info_outline)
                    ],
                  ),
                  AppText(
                    text: "\u2022  Unlimited Diagnostics",
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    fontSize: 15.sp,
                  ).paddingOnly(top: 8.h),
                  AppText(
                    text: "\u2022  Detailed Reports",
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    fontSize: 15.sp,
                  ).paddingOnly(top: 8.h),
                ],
              ),
            ).paddingOnly(top: 16.h),
          ],
        ),
      ),
    );
  }
}
