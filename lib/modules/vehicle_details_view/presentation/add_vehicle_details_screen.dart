import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/modules/dashboad/home/models/get_vehicle_data_model.dart';
import 'package:flutter_template/modules/personal_information_view/presentation/user_information_screen.dart';
import 'package:flutter_template/modules/vehicle_details_view/controller/vehicle_detail_controller.dart';
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

import '../../../utils/behaviour_glow.dart';

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
        init: VehicleDetailController(
          name: screenName,
          fetchData:
              screenName == AppString.editScreenFlag ? vehicleData! : Vehicle(),
        ),
        builder: (vehicleDetailController) => Scaffold(
          appBar: _buildAppBar(),
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Form(
                key: vehicleDetailController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoText(vehicleDetailController),
                    _buildCarImage(vehicleDetailController),
                    _buildVehicleNumberField(vehicleDetailController),
                    _buildVehicleYearField(vehicleDetailController),
                    _buildVehicleMakeField(context, vehicleDetailController),
                    _buildVehicleModelField(context, vehicleDetailController),
                    _buildTransmissionTypeField(
                        context, vehicleDetailController),
                    _buildFuelTypeField(context, vehicleDetailController),
                    _buildSizedBox(),
                    _buildSubmitBtn(vehicleDetailController),
                  ],
                ).paddingSymmetric(horizontal: 16.w),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitBtn(VehicleDetailController vehicleDetailController) {
    return Align(
      alignment: Alignment.bottomRight,
      child: CustomButton(
        onTap: () async {
          screenName == AppString.editScreenFlag
              ? await vehicleDetailController.editVehicleApi()
              : await vehicleDetailController.addVehicleApi();
        },
        isDisabled: (vehicleDetailController.isValidateVName.value &&
                vehicleDetailController.isValidateVYear.value &&
                vehicleDetailController.isValidateVMake.value &&
                vehicleDetailController.isValidateVModel.value &&
                vehicleDetailController.isValidateVType.value &&
                vehicleDetailController.isValidateVType.value &&
                vehicleDetailController.isValidateVFuelT.value &&
                (vehicleDetailController.image.value.isNotEmpty ||
                    vehicleDetailController.networkImage.value.isNotEmpty))
            ? false
            : true,
        height: 52.h,
        width: 131.w,
        disableTextColor: AppColors.whiteColor,
        endSvgHeight: 16.h,
        endSvg: IconAsset.forwardArrow,
        text: AppString.submit,
        borderRadius: BorderRadius.circular(46.r),
      ).paddingOnly(bottom: 25.h),
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 110.h,
    );
  }

  Widget _buildFuelTypeField(
      BuildContext context, VehicleDetailController vehicleDetailController) {
    return selectionTextField(
      context,
      validator: AppValidation.fuelType,
      text: AppString.fuelType,
      list: vehicleDetailController.fuelType,
      selectedVal: vehicleDetailController.selectedValueFType,
      onChanged: (val) {
        vehicleDetailController.isValidateVFuelT.value =
            vehicleDetailController.selectedValueFType.isNotEmpty;
      },
    );
  }

  Widget _buildTransmissionTypeField(
      BuildContext context, VehicleDetailController vehicleDetailController) {
    return selectionTextField(
      context,
      validator: AppValidation.transMissionTypeValidator,
      text: AppString.transmissionType,
      list: vehicleDetailController.transmissionType,
      selectedVal: vehicleDetailController.selectedValueTType,
      onChanged: (val) {
        vehicleDetailController.isValidateVType.value =
            vehicleDetailController.selectedValueTType.isNotEmpty;
      },
    ).paddingSymmetric(vertical: 16.h);
  }

  Widget _buildVehicleModelField(
      BuildContext context, VehicleDetailController vehicleDetailController) {
    return selectionTextField(
      context,
      validator: AppValidation.vehicleModelValidator,
      text: AppString.vehicleModel,
      list: vehicleDetailController.vehicleModel,
      selectedVal: vehicleDetailController.selectedValueModel,
      onChanged: (val) {
        vehicleDetailController.isValidateVModel.value =
            vehicleDetailController.selectedValueModel.isNotEmpty;
      },
    );
  }

  Widget _buildVehicleMakeField(
      BuildContext context, VehicleDetailController vehicleDetailController) {
    return selectionTextField(
      context,
      text: AppString.vehicleMake,
      validator: AppValidation.vehicleMakeValidator,
      list: vehicleDetailController.vehicleMake,
      selectedVal: vehicleDetailController.selectedValueMake,
      onChanged: (val) {
        vehicleDetailController.isValidateVMake.value =
            vehicleDetailController.selectedValueMake.isNotEmpty;
      },
    ).paddingSymmetric(vertical: 16.h);
  }

  Widget _buildVehicleYearField(
      VehicleDetailController vehicleDetailController) {
    return customTextFormField(
      text: AppString.vehicleYear,
      keyboardType: TextInputType.number,
      hintText: AppString.vehicleYear,
      readOnly: true,
      onTap: () {
        Get.bottomSheet(
            isDismissible: false,
            isScrollControlled: false,
            backgroundColor: AppColors.transparent,
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r)),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: AppString.vehicleYear,
                          color: AppColors.blackColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(150.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.clear,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ).paddingOnly(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                    ),
                    Container(
                      height: 250.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoPicker(
                          diameterRatio: 1,
                          magnification: 1.1,
                          onSelectedItemChanged: (value) {
                            vehicleDetailController.selectedYear.value =
                                vehicleDetailController.currentYear.value -
                                    value;
                            vehicleDetailController.vehicleYear.text =
                                vehicleDetailController.selectedYear.value
                                    .toString();
                            vehicleDetailController.isValidateVYear.value =
                                vehicleDetailController
                                    .vehicleYear.text.isNotEmpty;
                          },
                          itemExtent: 32.0,
                          children: List<Widget>.generate(
                            vehicleDetailController.currentYear.value -
                                1970 +
                                1,
                            (index) {
                              return Center(
                                child: AppText(
                                  text:
                                      '${vehicleDetailController.currentYear.value - index}',
                                ),
                              ).paddingOnly(
                                top: 5.h,
                                bottom: 5.w,
                              );
                            },
                          ),
                        ),
                      ),
                    ).paddingOnly(
                      left: 16.w,
                      right: 16.w,
                    ),
                    CustomButton(
                      height: 50.h,
                      onTap: () {
                        vehicleDetailController.vehicleYear.text =
                            vehicleDetailController.selectedYear.value
                                .toString();
                        vehicleDetailController.isValidateVYear.value = true;

                        Get.back();
                      },
                      text: AppString.save,
                    ).paddingOnly(
                      left: 16.w,
                      right: 15.w,
                      bottom: 16.h,
                    )
                  ],
                ),
              ),
            ));
      },
      validator: AppValidation.vehicleYearValidator,
      controller: vehicleDetailController.vehicleYear,
      suffixIcon: Transform.scale(
        scale: 0.3,
        child: SvgPicture.asset(
          IconAsset.downArrow,
        ),
      ),
      onChanged: (val) {},
    );
  }

  Widget _buildVehicleNumberField(
      VehicleDetailController vehicleDetailController) {
    return customTextFormField(
      text: AppString.vehicleNumber,
      hintText: AppString.vehicleNumber,
      controller: vehicleDetailController.vehicleNumber,
      validator: AppValidation.vehicleNumberValidator,
      maxLength: 17,
      onChanged: (val) {
        vehicleDetailController.isValidateVName.value =
            vehicleDetailController.vehicleNumber.text.isNotEmpty;
      },
    ).paddingSymmetric(vertical: 16.h);
  }

  Widget _buildInfoText(VehicleDetailController vehicleDetailController) {
    return InfoTextWidget(
      title: vehicleDetailController.screenName.value,
      titleFontSize: 24.sp,
      titleFontWeight: FontWeight.w600,
      description: AppString.addYourVehicleInformationForBetterSearch,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const CustomBackArrowWidget().paddingAll(11.w),
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
    );
  }

  Widget _buildCarImage(vehicleDetailController) {
    return (vehicleDetailController.image.value.isNotEmpty)
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
          ).paddingOnly(
            top: 24.h,
            bottom: 8.h,
          )
        : screenName == AppString.editScreenFlag
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
                    await Utils().imagePickerModel(
                        selectImage: vehicleDetailController.imagePath,
                        image: vehicleDetailController.image);

                    vehicleDetailController.isValidateImage.value = true;
                  },
                  child: Container(
                    height: 195.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child:
                        SvgPicture.asset(IconAsset.editIcon).paddingAll(85.h),
                  ),
                ),
              ).paddingOnly(top: 24.h, bottom: 8.h)
            : GestureDetector(
                onTap: () async {
                  await Utils().imagePickerModel(
                      selectImage: vehicleDetailController.imagePath,
                      image: vehicleDetailController.image);

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
                      SvgPicture.asset(IconAsset.uploadIcon)
                          .paddingOnly(bottom: 6.h),
                      AppText(
                        text: AppString.tapToAddACoverImageForVehicle,
                        textAlign: TextAlign.center,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ).paddingOnly(
                  top: 24.h,
                  bottom: 8.h,
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
                text: selectedVal.value.isNotEmpty
                    ? selectedVal.value
                    : '${AppString.select} $text',
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
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        5.0,
                        0,
                        8.0,
                      ),
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
            log("val ::$value");
            selectedVal.value = value!;
            log("val ::$selectedVal");
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
              borderRadius: BorderRadius.circular(14.r),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
