import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/modules/dashboad/home/models/get_vehicle_data_model.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/modules/vehicle_details_view/controller/vehicle_detail_controller.dart';
import 'package:flutter_template/modules/personal_information_view/presentation/user_information_screen.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/utils/validation_utils.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_backarrow_widget.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';

import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';

class AddVehicleDetailsScreen extends StatelessWidget {
  final String screenName;
  final Vehicle? vehicleData;

  const AddVehicleDetailsScreen({
    super.key,
    required this.screenName,
    this.vehicleData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
      statusBarColor: AppColors.whiteColor,
      child: GetX<VehicleDetailController>(
        init: VehicleDetailController(name: screenName, fetchData: screenName == "Edit Screen" ? vehicleData! : Vehicle()),
        builder: (vehicleDetailController) => Scaffold(
          appBar: AppBar(
            leading: const CustomBackArrowWidget().paddingAll(11.w),
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
          ),
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Form(
                key: vehicleDetailController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoTextWidget(
                      title: vehicleDetailController.screenName.value,
                      titleFontSize: 24.sp,
                      titleFontWeight: FontWeight.w600,
                      description: AppString.addYourVehicleInformationForBetterSearch,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    (vehicleDetailController.image.value.isNotEmpty)
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

                                vehicleDetailController.isValidateImage.value = true;
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
                        : screenName == "Edit Screen"
                            ? Container(
                                height: 195.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        vehicleDetailController.networkImage.value,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    await Utils()
                                        .imagePickerModel(selectImage: vehicleDetailController.imagePath, image: vehicleDetailController.image);

                                    vehicleDetailController.isValidateImage.value = true;
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
                                  await Utils()
                                      .imagePickerModel(selectImage: vehicleDetailController.imagePath, image: vehicleDetailController.image);

                                  if (vehicleDetailController.image.value.isNotEmpty) {
                                    vehicleDetailController.isValidateImage.value = true;
                                  } else {
                                    // Set validation to false if no image is selected
                                    vehicleDetailController.isValidateImage.value = false;
                                  }
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
                                      ),
                                    ],
                                  ),
                                ).paddingOnly(top: 24.h, bottom: 8.h),
                              ),
                    customTextFormField(
                      text: AppString.vehicleNumber,
                      hintText: AppString.vehicleNumber,
                      controller: vehicleDetailController.vehicleNumber,
                      validator: AppValidation.vehicleNumberValidator,
                      maxLength: 17,
                      onChanged: (String) {
                        vehicleDetailController.isValidateVName.value = vehicleDetailController.vehicleNumber.text.isNotEmpty;
                      },
                    ).paddingSymmetric(vertical: 16.h),
                    customTextFormField(
                      text: AppString.vehicleYear,
                      keyboardType: TextInputType.number,
                      hintText: AppString.vehicleYear,
                      maxLength: 4,
                      validator: AppValidation.vehicleYearValidator,
                      controller: vehicleDetailController.vehicleYear,
                      onChanged: (String) {
                        vehicleDetailController.isValidateVYear.value = vehicleDetailController.vehicleYear.text.isNotEmpty;
                      },
                    ),
                    selectionTextField(
                      context,
                      text: "Vehicle Make",
                      validator: AppValidation.vehicleMakeValidator,
                      list: vehicleDetailController.vehicleMake,
                      selectedVal: vehicleDetailController.selectedValueMake,
                      onChanged: (String) {
                        vehicleDetailController.isValidateVMake.value = vehicleDetailController.selectedValueMake.isNotEmpty;
                      },
                    ).paddingSymmetric(vertical: 16.h),
                    selectionTextField(
                      context,
                      validator: AppValidation.vehicleModelValidator,
                      text: "Vehicle Model",
                      list: vehicleDetailController.vehicleModel,
                      selectedVal: vehicleDetailController.selectedValueModel,
                      onChanged: (String) {
                        vehicleDetailController.isValidateVModel.value = vehicleDetailController.selectedValueModel.isNotEmpty;
                      },
                    ),
                    selectionTextField(
                      context,
                      validator: AppValidation.transMissionTypeValidator,
                      text: "Transmission Type",
                      list: vehicleDetailController.transmissionType,
                      selectedVal: vehicleDetailController.selectedValueTType,
                      onChanged: (String) {
                        vehicleDetailController.isValidateVType.value = vehicleDetailController.selectedValueTType.isNotEmpty;
                      },
                    ).paddingSymmetric(vertical: 16.h),
                    selectionTextField(
                      context,
                      validator: AppValidation.fuelType,
                      text: "Fuel Type",
                      list: vehicleDetailController.fuelType,
                      selectedVal: vehicleDetailController.selectedValueFType,
                      onChanged: (String) {
                        vehicleDetailController.isValidateVFuelT.value = vehicleDetailController.selectedValueFType.isNotEmpty;
                      },
                    ),
                    SizedBox(
                      height: 110.h,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        onTap: () async {
                          screenName == "Edit Screen"
                              ? await vehicleDetailController.editVehicleApi()
                              : await vehicleDetailController.addVehicleApi();
                        },
                        isDisabled: (vehicleDetailController.isValidateVName.value &&
                                vehicleDetailController.isValidateVYear.value &&
                                vehicleDetailController.isValidateVMake.value &&
                                vehicleDetailController.isValidateVModel.value &&
                                vehicleDetailController.isValidateVType.value &&
                                vehicleDetailController.isValidateVType.value &&
                                vehicleDetailController.isValidateVFuelT.value)
                            ? false
                            : true,
                        height: 52.h,
                        width: 131.w,
                        disableTextColor: AppColors.whiteColor,
                        endSvgHeight: 16.h,
                        endSvg: IconAsset.forwardArrow,
                        text: "Submit",
                        borderRadius: BorderRadius.circular(46),
                      ).paddingOnly(bottom: 25.h),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16.w),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget selectionTextField(BuildContext context,
      {required List list,
      required String text,
      required Function(String)? onChanged,
      required String? Function(String?)? validator,
      required RxString selectedVal}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: text,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ).paddingOnly(bottom: 8.h),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          customButton: Row(
            children: [
              AppText(
                text: selectedVal.value.isNotEmpty ? selectedVal.value : 'Select $text',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
              const Spacer(),
              SvgPicture.asset(
                IconAsset.downArrow,
              ),
            ],
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
              16.w,
              12.h,
              16.w,
              12.h,
            ),
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
          items: list
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.backgroundColor,
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
            onChanged!(text);
            log("val ::${value}");
            selectedVal.value = value!;
            log("val ::${selectedVal}");
          },
          validator: validator,
          onSaved: (value) {
            // log("val 1::${value}");
            selectedVal.value = value!;
          },

          dropdownStyleData: DropdownStyleData(
            maxHeight: 180.h,
            offset: const Offset(0, 10),
            // offset: Offset(0, -5.w),
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
