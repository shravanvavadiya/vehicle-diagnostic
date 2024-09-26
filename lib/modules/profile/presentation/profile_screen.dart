import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/modules/personal_information_view/controller/user_information_controller.dart';
import 'package:flutter_template/modules/profile/controller/profile_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';

import 'logout_pop_up.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: AppColors.backgroundColor,
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            leadingWidth: 30,
            elevation: 0,
            title: AppText(
              text: AppString.profile,
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
                Expanded(
                  child: AlignedGridView.count(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
                    itemCount: profileController.profileDataList.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    itemBuilder: (context, index) {
                      return ProfileComponent(index: index);
                    },
                  ),
                ),
                CustomButton(
                  buttonBorderColor: AppColors.secondaryColor.withOpacity(0.4),
                  borderWidth: 0.3,
                  buttonColor: AppColors.transparent,
                  needBorderColor: true,
                  textColor: AppColors.logoutColor,
                  onTap: () {
                    showCustomDialog();
                  },
                  height: 52.h,
                  fontSize: 15.h,
                  text: AppString.logout,
                  borderRadius: BorderRadius.circular(8.r),
                ).paddingSymmetric(horizontal: 16.w, vertical: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileComponent extends StatelessWidget {
  final int index;

  ProfileComponent({super.key, required this.index});

  final ProfileController profileController = Get.find();
  final UserInformationController personalInformationController =
      Get.put(UserInformationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          //personalInformationController.clearData();
          Navigation.pushNamed(Routes.accountInformation);
        } else if (index == 1) {
          Navigation.pushNamed(Routes.subscriptionsPlanScreen);
          // Navigation.pushNamed(Routes.subscriptionsSummeryScreen);
        } else if (index == 2) {
         // Navigation.pushNamed(Routes.homeScreen);
        } else {
          //Navigation.pushNamed(Routes.accountInformation);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
              color: AppColors.secondaryColor.withOpacity(0.4), width: 0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              profileController.profileDataList[index].icon,
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                profileController.profileDataList[index].title,
                style: TextStyle(
                    color: AppColors.grey60,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp),
              ),
            )
          ],
        ).paddingSymmetric(
          horizontal: 8.w,
          vertical: 12.h,
        ),
      ),
    );
  }
}
