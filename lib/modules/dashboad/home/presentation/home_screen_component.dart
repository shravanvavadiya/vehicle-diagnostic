import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/navigation_utils/navigation.dart';
import '../../../../utils/navigation_utils/routes.dart';
import '../models/get_vehicle_data_model.dart';

class HomeScreenComponent extends StatelessWidget {
  final Vehicle? getVehicleData;

  const HomeScreenComponent({super.key, required this.getVehicleData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.pushNamed(Routes.vehicleDetailScreen,arg: getVehicleData);
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 210.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor,width: 0.2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: getVehicleData?.photo != null &&
                        getVehicleData!.photo!.isNotEmpty
                    ? NetworkImage("${getVehicleData?.photo}")
                    : const AssetImage(ImagesAsset.imgPlaceholder),
              ),
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          Container(
            height: 210.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "${getVehicleData?.vehicleNumber}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                AppText(
                        text: "${getVehicleData?.vehicleMake}",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)
                    .paddingOnly(top: 4.h),
              ],
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 8.h),
    );
  }
}
