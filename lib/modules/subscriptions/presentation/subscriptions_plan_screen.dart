import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/modules/subscriptions/widget/subscriptions_plan_component.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../utils/assets.dart';

class SubscriptionsPlanScreen extends StatefulWidget {
  const SubscriptionsPlanScreen({super.key});

  @override
  State<SubscriptionsPlanScreen> createState() =>
      _SubscriptionsPlanScreenState();
}

class _SubscriptionsPlanScreenState extends State<SubscriptionsPlanScreen> {
  int selectedIndex = 0;

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
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(30.r)),
              child: AppText(
                text: AppString.restore,
                color: AppColors.primaryColor,
                textDecoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ).paddingSymmetric(
                vertical: 5.h,
                horizontal: 12.w,
              ),
            ).paddingSymmetric(
              vertical: 12.h,
              horizontal: 16.w,
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 8.h),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return SubscriptionsPlanComponent(
                      index: index,
                      isSelected: selectedIndex == index,
                      // Check if this plan is selected
                      onSelected: () {
                        setState(() {
                          selectedIndex = index; // Update the selected plan
                        });
                      },
                    );
                  },
                ),
              ),
              CustomButton(
                buttonColor: AppColors.highlightedColor,
                onTap: () {
                  Navigation.pushNamed(Routes.subscriptionsSummeryScreen);
                },
                height: 52.h,
                fontSize: 15.h,
                text: AppString.buyNow,
                borderRadius: BorderRadius.circular(8.r),
              ).paddingSymmetric(vertical: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: AppString.privacyAndTerms,
                    color: AppColors.grey60,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.underline,
                    fontSize: 14.sp,
                  ),
                  AppText(
                    text: AppString.cancelAnytime,
                    color: AppColors.grey60,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    textDecoration: TextDecoration.underline,
                  ),
                ],
              )
            ],
          ).paddingSymmetric(
            horizontal: 16.w,
            vertical: 25.h,
          ),
        ),
      ),
    );
  }
}
