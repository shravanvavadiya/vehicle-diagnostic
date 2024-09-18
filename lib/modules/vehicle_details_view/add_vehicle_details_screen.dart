import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/modules/authentication/controller/video_detail_controller.dart';
import 'package:flutter_template/modules/personal_information_view/presentation/personal_information_screen.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/utils/validation_utils.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_backarrow_widget.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/custom_dropdown_field.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';

import '../../utils/navigation_utils/navigation.dart';
import '../../utils/navigation_utils/routes.dart';

class AddVehicleDetailsScreen extends StatefulWidget {
  const AddVehicleDetailsScreen({super.key});

  @override
  State<AddVehicleDetailsScreen> createState() =>
      _AddVehicleDetailsScreenState();
}

class _AddVehicleDetailsScreenState extends State<AddVehicleDetailsScreen> {
  final VehicleDetailController vehicleDetailController =
      Get.put(VehicleDetailController());

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });*/
    return CustomAnnotatedRegions(
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackArrowWidget().paddingAll(11.w),
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: vehicleDetailController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoTextWidget(
                  title: AppString.addYourVehicleDetails,
                  titleFontSize: 24.sp,
                  titleFontWeight: FontWeight.w600,
                  description: AppString.addYourVehicleInformationForBetterSearch,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                Obx(
                  () => (vehicleDetailController.image.value.isNotEmpty)
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
                              await Utils().imagePickerModel(
                                  selectImage: vehicleDetailController.imagePath,
                                  image: vehicleDetailController.image);
                              setState(() {
                                vehicleDetailController.isValidateImage.value =
                                true;
                              });

                            },
                            child: Container(
                              height: 195.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.blackColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: SvgPicture.asset(IconAsset.editIcon)
                                  .paddingAll(85.h),
                            ),
                          ),
                        ).paddingOnly(top: 24.h, bottom: 8.h)
                      : GestureDetector(
                          onTap: () async {
                            await Utils().imagePickerModel(
                                selectImage: vehicleDetailController.imagePath,
                                image: vehicleDetailController.image);
                            setState(() {
                              if (vehicleDetailController.image.value.isNotEmpty) {
                                vehicleDetailController.isValidateImage.value =
                                true;
                              } else {
                                // Set validation to false if no image is selected
                                vehicleDetailController.isValidateImage.value =
                                false;
                              }
                            });

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
                                SvgPicture.asset(IconAsset.uploadIcon)
                                    .paddingOnly(bottom: 6.h),
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
                  validator: AppValidation.vehicleNumberValidator,
                  onChanged: (String) {
                    vehicleDetailController.isValidateVName.value =
                        vehicleDetailController.vehicleNumber.text.isNotEmpty;
                  },
                ).paddingSymmetric(vertical: 16.h),
                customTextFormField(
                  text: AppString.vehicleYear,
                  keyboardType: TextInputType.number,
                  hintText: AppString.vehicleYear,
                  validator: AppValidation.vehicleYearValidator,
                  controller: vehicleDetailController.vehicleYear,
                  onChanged: (String) {
                    vehicleDetailController.isValidateVYear.value =
                        vehicleDetailController.vehicleYear.text.isNotEmpty;
                  },
                ),
                /*  CustomDropDownField(
                    label: 'Vehicle Make',
                    hintText: 'Select vehicle make',
                    selectedValue: ,
                    list: vehicleDetailController.genderItems),*/
                selectionTextField(
                  context,
                  text: "Vehicle Make",
                  validator: AppValidation.vehicleMakeValidator,
                  list: vehicleDetailController.vehicleMake,
                  selectedVal: vehicleDetailController.selectedValueMake,
                  onChanged: (String) {
                    vehicleDetailController.isValidateVMake.value =
                        vehicleDetailController.selectedValueMake.isNotEmpty;
                  },
                ).paddingSymmetric(vertical: 16.h),
                selectionTextField(
                  context,
                  validator: AppValidation.vehicleModelValidator,
                  text: "Vehicle Model",
                  list: vehicleDetailController.vehicleModel,
                  selectedVal: vehicleDetailController.selectedValueModel,
                  onChanged: (String) {
                    vehicleDetailController.isValidateVModel.value =
                        vehicleDetailController.selectedValueModel.isNotEmpty;
                  },
                ),
                selectionTextField(
                  context,
                  validator: AppValidation.transMissionTypeValidator,
                  text: "Transmission Type",
                  list: vehicleDetailController.transmissionType,
                  selectedVal: vehicleDetailController.selectedValueTType,
                  onChanged: (String) {
                    vehicleDetailController.isValidateVType.value =
                        vehicleDetailController.selectedValueTType.isNotEmpty;
                  },
                ).paddingSymmetric(vertical: 16.h),
                selectionTextField(
                  context,
                  validator: AppValidation.fuelType,
                  text: "Fuel Type",
                  list: vehicleDetailController.fuelType,
                  selectedVal: vehicleDetailController.selectedValueFType,
                  onChanged: (String) {
                    vehicleDetailController.isValidateVFuelT.value =
                        vehicleDetailController.selectedValueFType.isNotEmpty;
                  },
                ),
                SizedBox(
                  height: 110.h,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Obx(
                    () => CustomButton(
                      onTap: () async {
                        if (vehicleDetailController.formKey.currentState?.validate() ?? false) {
                          Navigation.pushNamed(Routes.vehicleDiagnosisScreen);

                        }
                      },
                      isDisabled: (vehicleDetailController
                                  .isValidateVName.value &&
                              vehicleDetailController.isValidateVYear.value &&
                              vehicleDetailController.isValidateVMake.value &&
                              vehicleDetailController.isValidateVModel.value &&
                              vehicleDetailController.isValidateVType.value &&
                              vehicleDetailController.isValidateVType.value &&
                              vehicleDetailController.isValidateVFuelT.value
                             /* vehicleDetailController.isValidateImage.value*/
                      )
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
                ),
              ],
            ).paddingSymmetric(horizontal: 16.w),
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
              Obx(
                () => AppText(
                  // text: vehicleDetailController.selectedValue.value,
                  text: selectedVal.value.isNotEmpty
                      ? selectedVal.value
                      : 'Select $text',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
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
                            /*color: vehicleDetailController.genderItems
                                        .indexOf(item) ==
                                    0
                                ? Colors.transparent
                                :*/
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
