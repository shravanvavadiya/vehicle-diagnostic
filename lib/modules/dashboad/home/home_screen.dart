import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/modules/dashboad/home/home_screen_component.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:get/get.dart';
import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/annotated_region.dart';
import '../../../widget/custom_button.dart';
import '../../authentication/controller/video_detail_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final VehicleDetailController vehicleDetailController = Get.put(VehicleDetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.highlightedColor.withOpacity(0.08),
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: PreferredSize(
            preferredSize: Size(0, 72.h),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.highlightedColor.withOpacity(0.1),
                gradient: LinearGradient(
                  colors: [
                    AppColors.highlightedColor.withOpacity(0.7),
                    AppColors.highlightedColor.withOpacity(0.5),
                    AppColors.whiteColor
                  ],
                  stops: const [0.3, 0.5, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                /*boxShadow: [
                     BoxShadow(
                      color: AppColors.highlightedColor,
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: AppColors.grey50,
                      blurRadius: 20.0,
                      spreadRadius: 0.5,
                    ),
                    BoxShadow(
                      color: AppColors.whiteColor,
                      blurRadius: 20.0,
                      spreadRadius: 0.5,
                    )
                  ]*/
              ),
              child: AppBar(
                toolbarHeight: 72,
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                  preferredSize: Size(0, 6.h),
                  child: Container(
                    height: 4.h,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                backgroundColor: AppColors.transparent,
                leadingWidth: 0,
                elevation: 0,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppString.goodMorning,
                          color: AppColors.grey60,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                        AppText(
                          text: "John Doe",
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp,
                        ).paddingOnly(top: 2.sp),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigation.pushNamed(Routes.profileScreen);
                      },
                      child: Container(
                        height: 44.h,
                        width: 44.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.r),
                          border: Border.all(
                            color: AppColors.whiteColor,
                            width: 2.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(65.r),
                          child:
                          Image.asset(
                            ImagesAsset.user,
                            height: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ).paddingSymmetric(horizontal: 16.h),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      text: "${AppString.myVehicle} (3)",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    CustomButton(
                      onTap: () {
                        vehicleDetailController.clearController();
                        Navigation.pushNamed(Routes.addVehicleDetail);
                      },
                      height: 38.h,
                      fontSize: 15.sp,
                      endSvgHeight: 16.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      svg: IconAsset.add,
                      text: AppString.newVehicle,
                      svgPadding: 5.w,
                      borderRadius: BorderRadius.circular(46),
                    )
                  ],
                ).paddingSymmetric(vertical: 16.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 8.h),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const HomeScreenComponent();
                  },
                )
              ],
            ).paddingSymmetric(horizontal: 16.w),
          ),
        ),
      ),
    );
  }
}
