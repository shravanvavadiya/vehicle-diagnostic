import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/modules/authentication/controller/video_detail_controller.dart';
import 'package:flutter_template/modules/personal_information_view/personal_information_screen.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/widget/custom_backarrow_widget.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';

class VehicleDetailsScreen extends StatefulWidget {
  VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final VehicleDetailController vehicleDetailController = Get.put(VehicleDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackArrowWidget().paddingOnly(top: 50.h),
            InfoTextWidget(
              title: AppString.addYourVehicleDetails,
              titleFontSize: 24.sp,
              titleFontWeight: FontWeight.w600,
              description: AppString.addYourVehicleInformationForBetterSearch,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            Obx(
              () => vehicleDetailController.image.value.isNotEmpty
                  ? Container(
                      height: 195.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(4.r),
                        image: DecorationImage(
                            image: FileImage(
                              File(
                                vehicleDetailController.image.value,
                              ),
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          await Utils().imagePickerModel(selectImage: vehicleDetailController.imagePath, image: vehicleDetailController.image);
                        },
                        child: Container(
                          height: 195.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.blackColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: SvgPicture.asset(IconAsset.editIcon).paddingAll(85.h),
                        ),
                      ),
                    ).paddingOnly(top: 24.h, bottom: 8.h)
                  : GestureDetector(
                      onTap: () async {
                        await Utils().imagePickerModel(selectImage: vehicleDetailController.imagePath, image: vehicleDetailController.image);
                      },
                      child: Container(
                        height: 195.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconAsset.uploadIcon).paddingOnly(bottom: 6.h),
                            AppText(
                              text: AppString.tapToAddACoverImageForVehicle,
                              textAlign: TextAlign.center,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )
                          ],
                        ),
                      ).paddingOnly(top: 24.h, bottom: 8.h),
                    ),
            ),
            customTextFormField(
              text: AppString.vehicleNumber,
              hintText: AppString.vehicleNumber,
              controller: vehicleDetailController.vehicleNumber,
            ).paddingSymmetric(vertical: 16.h),
            customTextFormField(
              text: AppString.vehicleYear,
              hintText: AppString.vehicleYear,
              controller: vehicleDetailController.vehicleYear,
            ),
            genderTextField(context, text: "Vehicle Make").paddingSymmetric(vertical: 16.h),
            genderTextField(context, text: "Vehicle Model"),
            genderTextField(context, text: "Transmission Type").paddingSymmetric(vertical: 16.h),
            genderTextField(context, text: "Fuel Type"),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                onTap: () {},
                height: 56.h,
                width: 131.w,
                endSvg: IconAsset.forwardArrow,
                text: "Submit",
                borderRadius: BorderRadius.circular(46),
              ).paddingOnly(bottom: 16.h),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }

  Widget genderTextField(context, {required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: text,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ).paddingOnly(bottom: 8.h),
        DropdownButtonFormField2<String>(
          customButton: Row(
            children: [
              AppText(
                text: vehicleDetailController.selectedValue.value,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: vehicleDetailController.selectedValue.value != "selectGender" ? AppColors.blackColor : AppColors.backgroundColor,
              ),
              const Spacer(),
              SvgPicture.asset(
                IconAsset.downArrow,
              ),
            ],
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
            fillColor: AppColors.backgroundColor,
            filled: true,
            isCollapsed: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.backgroundColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.backgroundColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.backgroundColor),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 45.h,
          ),
          items: vehicleDetailController.genderItems
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: vehicleDetailController.genderItems.indexOf(item) == 0 ? Colors.transparent : AppColors.backgroundColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: AppText(
                        text: item,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ))
              .toList(),
          // value: vehicleDetailController.selectedValue.value.isEmpty ? AppString.selectGender : AppString.male,
          onChanged: (value) {
            setState(() {
              vehicleDetailController.selectedValue.value = value.toString();
            });
          },
          onSaved: (value) {
            vehicleDetailController.selectedValue.value = value.toString();
          },
          dropdownStyleData: DropdownStyleData(
            offset: Offset(0, -5.w),
            padding: EdgeInsets.zero,
            scrollPadding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
          ),
        ),
      ],
    ).paddingOnly(bottom: 12.h);
  }
}
