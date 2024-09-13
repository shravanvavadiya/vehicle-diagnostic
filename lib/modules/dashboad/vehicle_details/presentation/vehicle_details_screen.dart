import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/modules/dashboad/vehicle_details/controller/vehicle_detail_screen_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';
import '../../../../widget/custom_listtile.dart';

class VehicleDetailScreen extends StatelessWidget {
  VehicleDetailScreen({super.key});

  final VehicleDetailScreenController vehicleDetailScreenController =
      Get.put(VehicleDetailScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        statusBarColor: AppColors.backgroundColor,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            leadingWidth: 30,
            elevation: 0,
            title: AppText(
              text: "VU69 TDE",
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
              ),
            ).paddingOnly(left: 16.w),
            actions: [
              PopupMenuButton<int>(
                position: PopupMenuPosition.under,
                elevation: 1,
                icon: SvgPicture.asset(
                  IconAsset.moreIcon,
                  color: AppColors.blackColor,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    value: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconAsset.edit,
                          color: AppColors.primaryColor,
                          height: 23.h,
                        ),
                        AppText(
                          text: AppString.edit,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ).paddingOnly(left: 12.w),
                      ],
                    ).paddingOnly(left: 3.w),
                  ),
                  PopupMenuItem(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    value: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconAsset.download,
                          color: AppColors.primaryColor,
                          height: 24.h,
                        ),
                        AppText(
                          text: AppString.downloadPDF,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ).paddingOnly(left: 12.w),
                      ],
                    ).paddingOnly(left: 6.w),
                  ),
                  PopupMenuItem(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    value: 3,
                    onTap: () {
                      vehicleDetailScreenController.idDisplayErrorBox.value =
                          true;
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconAsset.delete,
                          color: AppColors.logoutColor,
                          height: 25.h,
                        ),
                        AppText(
                          text: AppString.delete,
                          color: AppColors.logoutColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ).paddingOnly(left: 12.w),
                      ],
                    ).paddingOnly(left: 6.w),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    // _homeController.productsModel.sort((a, b) => a.title.toString().toLowerCase().compareTo(b.title.toString().toLowerCase()));
                  } else if (value == 2) {
                    //  _homeController.productsModel.sort((a, b) => b.title.toString().toLowerCase().compareTo(a.title.toString().toLowerCase()));
                  } else if (value == 3) {
                    // _homeController.productsModel.sort((a, b) => int.parse(b.price.toString()).compareTo(int.parse(a.price.toString())));
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 210.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImagesAsset.car),
                        ),
                      ),
                    ),
                    Container(
                      height: 210.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blackColor,
                            AppColors.blackColor.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          stops: const [0, 0.15, 0.3],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15.w,
                      bottom: 15.h,
                      child: AppText(
                        text: "VU69 YDE",
                        fontSize: 19.sp,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Vehicle information",
                      color: AppColors.secondaryColor.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ).paddingOnly(top: 16.h, left: 16.w),
                    ListView.separated(
                      itemCount: vehicleDetailScreenController
                          .vehicleDetailsList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                          title:
                              "${vehicleDetailScreenController.vehicleDetailsList[index]["title"]}",
                          trailingText:
                              "${vehicleDetailScreenController.vehicleDetailsList[index]["subTitle"]}",
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 2.h,
                          color: AppColors.backgroundColor,
                        );
                      },
                    ).paddingOnly(top: 16.h, left: 16.w, right: 16.w),
                    Container(
                      height: 7.h,
                      color: AppColors.backgroundColor,
                    ).paddingOnly(top: 8.h, bottom: 20.h),
                    AppText(
                      text: "More about your vehicle",
                      color: AppColors.secondaryColor.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ).paddingOnly(left: 16.w),
                    ListView.separated(
                      itemCount:
                          vehicleDetailScreenController.vehicleMoreInfo.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                          title:
                              "${vehicleDetailScreenController.vehicleMoreInfo[index]["title"]}",
                          trailingText:
                              "${vehicleDetailScreenController.vehicleMoreInfo[index]["subTitle"]}",
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 2.h,
                          color: AppColors.backgroundColor,
                        );
                      },
                    ).paddingOnly(
                      top: 4.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                  ],
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Obx(
            () =>  vehicleDetailScreenController
                        .idDisplayErrorBox.value ==
                    true
                ? Container(
                        height: 58.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: AppColors.logoutColor,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: AppColors.borderColor),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.w, 0.5.h),
                                color: AppColors.blackColor.withOpacity(0.4),
                                blurRadius: 80,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: "Is there a problem with your \nvehicle?",
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              height: 1.3.h,
                              letterSpacing: 0.4,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    vehicleDetailScreenController
                                        .idDisplayErrorBox.value=false;
                                  },
                                  child: Container(
                                    height: 30.h,
                                    width: 55.w,
                                    decoration: BoxDecoration(
                                        color:
                                            AppColors.whiteColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20.r),
                                        border: Border.all(
                                            color: AppColors.whiteColor, width: 1)),
                                    child: Center(
                                        child: AppText(
                                      text: "No",
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    vehicleDetailScreenController
                                        .idDisplayErrorBox.value=false;
                                  },
                                  child: Container(
                                    height: 30.h,
                                    width: 55.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(20.r),
                                        border: Border.all(
                                            color: AppColors.whiteColor, width: 1)),
                                    child: Center(
                                      child: AppText(
                                        text: "Yes",
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ).paddingOnly(left: 10.w),

                                ),
                              ],
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 10.w))
                    .paddingSymmetric(horizontal: 16.w)
                : const SizedBox(),
          ),
          /* floatingActionButton: FloatingActionButton.extended(

            backgroundColor: AppColors.logoutColor,
            onPressed: () {},
            label: Row(
              children: [
                AppText(
                  text: "Is there a problem with your \nvehicle?",
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  height: 1.3.h,
                  letterSpacing: 0.4,
                ),
                CustomButton(
                  onTap: () {
                  },
                  height: 30.h,
                  width: 60.w,
                  endSvgHeight: 16.h,
                  endSvg: IconAsset.forwardArrow,
                  text: "No",
                  borderRadius: BorderRadius.circular(46.r),
                )
              ],
            ),
          ),*/
        ),
      ),
    );
  }
}
