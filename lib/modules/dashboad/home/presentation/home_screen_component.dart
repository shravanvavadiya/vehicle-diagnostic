import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/dashboad/home/controller/home_controller.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/custom_catch_image.dart';
import '../../../../utils/navigation_utils/navigation.dart';
import '../../../../utils/navigation_utils/routes.dart';
import '../models/get_vehicle_data_model.dart';

class HomeScreenComponent extends StatelessWidget {
  final Vehicle? getVehicleData;

  HomeScreenComponent({super.key, required this.getVehicleData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.pushNamed(Routes.vehicleDetailScreen, arg: getVehicleData);

      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          /*  CustomCachedImage(imageUrl:"${getVehicleData?.photo}",height: 210.h, width: Get.width),*/
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor, width: 0.2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: getVehicleData?.photo != null && getVehicleData!.photo!.isNotEmpty
                    ? NetworkImage("${getVehicleData?.photo}")
                    : const AssetImage(ImagesAsset.imgPlaceholder),
              ),
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.blackColor.withOpacity(0.1),
            ),
          ),
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.blackColor.withOpacity(0.5),
              gradient: LinearGradient(
                colors: [
                  AppColors.blackColor,
                  AppColors.blackColor.withOpacity(0.5),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "${getVehicleData?.vehicleNumber}",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: Colors.white,
                ),
                AppText(text: "${getVehicleData?.vehicleMake}", fontSize: 13.sp, letterSpacing: 0.3, fontWeight: FontWeight.w500, color: Colors.white)
                    .paddingOnly(top: 4.h),
              ],
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 8.h),
    );
  }
}
