import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/dashboad/home/controller/home_controller.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen_component.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:get/get.dart';
import '../../../../api/preferences/shared_preferences_helper.dart';
import '../../../../utils/assets.dart';
import '../../../../utils/behaviour_glow.dart';
import '../../../../utils/navigation_utils/navigation.dart';
import '../../../../utils/navigation_utils/routes.dart';
import '../../../../widget/custom_button.dart';
import '../../../personal_information_view/controller/user_information_controller.dart';
import '../../../profile/presentation/profile_screen.dart';
import '../../../vehicle_details_view/presentation/add_vehicle_details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final UserInformationController userInformationController = Get.put(UserInformationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => homeController.onWillPop(),
        child: SafeArea(
          child: AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColors.highlightedColor.withOpacity(0.07),
              statusBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              backgroundColor: AppColors.whiteColor,
              appBar: PreferredSize(
                preferredSize: Size(0, 72.h),
                child: Container(
                  width: Get.width,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImagesAsset.homeBg), fit: BoxFit.cover)),
                  child: AppBar(
                    toolbarHeight: 72,
                    titleSpacing: 0,
                    automaticallyImplyLeading: false,
                    bottom: PreferredSize(
                      preferredSize: Size(0, 6.h),
                      child: Container(
                        height: 6.h,
                        color: Colors.grey.withOpacity(0.2),
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
                            SizedBox(
                              width: Get.width / 1.8.w,
                              child: AppText(
                                // text: "${SharedPreferencesHelper.instance.getUserInfo()?.apiresponse?.data?.firstName ?? "demo"}"
                                //     " ${SharedPreferencesHelper.instance.getUserInfo()?.apiresponse?.data?.lastName ?? "demo"}",
                                text: "${homeController.getUserProfileModel.value.profileResponse?.profileData?.firstName ?? ""} "
                                    "${homeController.getUserProfileModel.value.profileResponse?.profileData?.lastName ?? ""}",
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600,
                                maxLines: 2,
                                fontSize: 17.sp,
                              ).paddingOnly(
                                top: 2.sp,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ProfileScreen());
                          },
                          child: Container(
                              height: 45.h,
                              width: 45.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.r),
                                border: Border.all(
                                  color: AppColors.whiteColor,
                                  width: 2.5.w,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(65.r),
                                child: CachedNetworkImage(
                                  maxHeightDiskCache: 150,
                                  maxWidthDiskCache: 150,
                                  color: Colors.transparent,
                                  // imageUrl: SharedPreferencesHelper.instance.getUserInfo()?.profileResponse?.profileData?.photo ?? "",
                                  //
                                  imageUrl: homeController.getUserProfileModel.value.profileResponse?.profileData!.photo ?? "",
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(9.r),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.highlightedColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => ClipRRect(
                                    borderRadius: BorderRadius.circular(65.r),
                                    child: Image.asset(
                                      ImagesAsset.user,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ).paddingSymmetric(horizontal: 16.h),
                  ),
                ),
              ),
              body: CustomScrollView(
                controller: homeController.scrollController,
                scrollBehavior: MyBehavior(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          verticalDirection: VerticalDirection.up,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              text: "${AppString.myVehicle} (${homeController.getAllVehicleList?.apiresponse?.data?.totalCount ?? 0})",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                            CustomButton(
                              onTap: () {
                                Get.to(const AddVehicleDetailsScreen(
                                  // screenName: AppString.newVehicleAdd,
                                  screenName: AppString.newVehicleAddFlag,
                                ));
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
                        homeController.isResponseData.value == true
                            ? homeController.getAllVehicleList!.apiresponse!.data!.vehicle!.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Text("No data found"),
                                    ))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    itemCount: homeController.getAllVehicleList!.apiresponse!.data!.vehicle!.length,
                                    itemBuilder: (context, index) {
                                      return HomeScreenComponent(
                                          getVehicleData: homeController.getAllVehicleList!.apiresponse!.data!.vehicle![index]);
                                    },
                                  )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.highlightedColor,
                                ),
                              )
                      ],
                    ).paddingSymmetric(horizontal: 16.w),
                  ),
                  SliverToBoxAdapter(
                    child: !homeController.paginationLoading.value
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.highlightedColor,
                              ),
                            ).paddingOnly(bottom: 24, top: 12),
                          )
                        : const SizedBox(
                            height: 50,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
/*
Widget _buildLoaderIndicator() {
  return SliverToBoxAdapter(
    child: !homeController.paginationLoading.value
        ? Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          color: AppColors.highlightedColor,
        ),
      ).paddingOnly(
        bottom: 24.h,
        top: 12.h,
      ),
    )
        : SizedBox(
      height: 50.h,
    ),
  );
}

Widget _buildListview() {
  return homeController.isResponseData.value == true
      ? homeController.getAllVehicleList!.apiresponse!.data!.vehicle!.isEmpty
      ? Center(
    child: Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: const Text(AppString.noDataFound),
    ),
  )
      : ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.only(bottom: 8.h),
    itemCount: homeController.getAllVehicleList!.apiresponse!.data!.vehicle!.length,
    itemBuilder: (context, index) {
      return HomeScreenComponent(getVehicleData: homeController.getAllVehicleList!.apiresponse!.data!.vehicle![index]);
    },
  )
      : Center(
    child: CircularProgressIndicator(
      color: AppColors.highlightedColor,
    ),
  );
}

Widget _buildTitleRow() {
  return Row(
    verticalDirection: VerticalDirection.up,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AppText(
        text: "${AppString.myVehicle} (${homeController.getAllVehicleList?.apiresponse?.data?.totalCount ?? 0})",
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
      ),
      CustomButton(
        onTap: () {
          Get.to(const AddVehicleDetailsScreen(
            screenName: AppString.newVehicleAddFlag,
          ));
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
  ).paddingSymmetric(vertical: 16.h);
}

PreferredSize _buildAppbar() {
  return PreferredSize(
    preferredSize: Size(0, 72.h),
    child: Container(
      width: Get.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagesAsset.homeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: AppBar(
        toolbarHeight: 72,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size(0, 6.h),
          child: Container(
            height: 6.h,
            color: Colors.grey.withOpacity(0.2),
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
                SizedBox(
                  width: Get.width / 1.8.w,
                  child: AppText(
                    text: "${homeController.getUserProfileModel.value.profileResponse?.profileData?.firstName ?? ""} "
                        "${homeController.getUserProfileModel.value.profileResponse?.profileData?.lastName ?? ""}",
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    fontSize: 17.sp,
                  ).paddingOnly(
                    top: 2.sp,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.to(ProfileScreen());
              },
              child: Container(
                  height: 45.h,
                  width: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.r),
                    border: Border.all(
                      color: AppColors.whiteColor,
                      width: 3.5.w,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(65.r),
                    child: CachedNetworkImage(
                      maxHeightDiskCache: 150,
                      maxWidthDiskCache: 150,
                      color: Colors.transparent,

                      /// TODO : image Change
                      imageUrl: homeController.getUserProfileModel.value.profileResponse?.profileData!.photo ?? "",
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9.r),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: AppColors.highlightedColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(65.r),
                        child: Image.asset(
                          ImagesAsset.user,
                          height: 20,
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ).paddingSymmetric(horizontal: 16.h),
      ),
    ),
  );
}*/
