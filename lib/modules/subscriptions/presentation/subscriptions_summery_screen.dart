import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../utils/assets.dart';

class SubscriptionsSummeryScreen extends StatefulWidget {
  const SubscriptionsSummeryScreen({super.key});

  @override
  State<SubscriptionsSummeryScreen> createState() => _SubscriptionsPlanSSummeryScreen();
}

class _SubscriptionsPlanSSummeryScreen extends State<SubscriptionsSummeryScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leadingWidth: 30,
          elevation: 0,
          title: AppText(
            text: AppString.subscriptionsPlan,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600,
            fontSize: 17.sp,
          ),
          leading: GestureDetector(
            onTap: () {
              Navigation.pop();
            },
            child: SvgPicture.asset(
              IconAsset.leftArrow,
              height: 18.h,
            ),
          ).paddingOnly(left: 16.w),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.all(16.h),
                margin: EdgeInsets.all(16.h),
                decoration: BoxDecoration(color: AppColors.backgroundColor, borderRadius: BorderRadius.circular(4.r)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: AppString.yourSubscriptionPlan,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                          fontSize: 16.sp,
                        ),
                      ],
                    ).paddingOnly(bottom: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: AppString.subscription,
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                          fontSize: 14.sp,
                        ),
                        AppText(
                          text: "1-month plan",
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Price",
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                          fontSize: 14.sp,
                        ),
                        AppText(
                          text: "₹490.00",
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                          fontSize: 16.sp,
                        ),
                      ],
                    ).paddingOnly(top: 12.h, bottom: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Next billing date",
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                          fontSize: 14.sp,
                        ),
                        AppText(
                          text: "November 21, 2023",
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                          fontSize: 16.sp,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CustomButton(
                buttonColor: AppColors.highlightedColor,
                onTap: () {
                  //Navigation.pushNamed(Routes.accountInformation);
                  Get.back();
                },
                height: 52.h,
                fontSize: 15.h,
                text: AppString.changeSubscriptionPlan,
                borderRadius: BorderRadius.circular(8.r),
              ).paddingSymmetric(horizontal: 16.w, vertical: 25.h),
              SizedBox(
                height: 54.h,
                width: Get.width,
                child: TextButton(
                  onPressed: () {},
                  child: AppText(
                    text: AppString.cancelSubscription,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
