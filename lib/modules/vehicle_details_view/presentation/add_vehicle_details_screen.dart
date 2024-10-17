import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:flutter_template/widget/custom_backarrow_widget.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';

import '../../../my_app.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';

class AddVehicleDetailsScreen extends StatefulWidget {
  final String screenName;
  final Vehicle? vehicleData;

  const AddVehicleDetailsScreen({
    super.key,
    required this.screenName,
    this.vehicleData,
  });

  @override
  State<AddVehicleDetailsScreen> createState() => _AddVehicleDetailsScreenState();
}

class _AddVehicleDetailsScreenState extends State<AddVehicleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
      statusBarColor: AppColors.whiteColor,
      child: GetX<VehicleDetailController>(
        init: VehicleDetailController(
            name: widget.screenName, fetchData: widget.screenName == AppString.editScreenFlag ? widget.vehicleData! : Vehicle()),
        builder: (vehicleDetailController) => Scaffold(
          appBar: AppBar(
            leading: const CustomBackArrowWidget().paddingAll(11.w),
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            controller: vehicleDetailController.scrollController,
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
                      : widget.screenName == AppString.editScreenFlag
                          ? GestureDetector(
                              onTap: () async {
                                await Utils().imagePickerModel(selectImage: vehicleDetailController.imagePath, image: vehicleDetailController.image);
                              },
                              child: SizedBox(
                                height: 195.h,
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      maxHeightDiskCache: 1500,
                                      maxWidthDiskCache: 1500,
                                      color: Colors.transparent,
                                      imageUrl: vehicleDetailController.networkImage.value,
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, imageProvider) => Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(9.r),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.dividerColor,
                                        ),
                                      ),
                                    ).paddingOnly(top: 24.h, bottom: 8.h),
                                    Container(
                                      height: 195.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.blackColor.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(9.r),
                                      ),
                                      child: SvgPicture.asset(IconAsset.editIcon).paddingAll(85.h),
                                    ).paddingOnly(top: 24.h, bottom: 8.h),
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await Utils().imagePickerModel(selectImage: vehicleDetailController.imagePath, image: vehicleDetailController.image);
                                if (vehicleDetailController.image.value.isNotEmpty) {
                                } else {}
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
                    controller: vehicleDetailController.vehicleNumberController.value,
                    // validator: AppValidation.vehicleNumberValidator,
                    maxLength: 17,
                    onChanged: (String) {
                      if (vehicleDetailController.vehicleNumberController.value.text.length > 3) {
                        if (vehicleDetailController.debounce?.isActive ?? false) vehicleDetailController.debounce?.cancel();
                        vehicleDetailController.debounce = Timer(const Duration(seconds: 1), () {
                          vehicleDetailController.vehicleNumberCheck(vehicleNumberText: vehicleDetailController.vehicleNumberController.value.text);
                        });
                      }
                    },
                  ).paddingSymmetric(vertical: 16.h),
                  customTextFormField(
                    text: AppString.vehicleYear,
                    keyboardType: TextInputType.number,
                    hintText: AppString.vehicleYear,
                    maxLength: 4,
                    readOnly: true,
                    onTap: () {
                      widget.screenName == AppString.editScreenFlag ? vehicleDetailController.getSelectedYear() : {};
                      vehicleDetailController.isCheckAnsFormTextField.value
                          ? const SizedBox()
                          : Get.bottomSheet(
                              isDismissible: false,
                              isScrollControlled: false,
                              backgroundColor: AppColors.transparent,
                              ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r)),
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
                                      ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
                                      Container(
                                        height: 250.h,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CupertinoPicker(
                                            scrollController: FixedExtentScrollController(
                                                initialItem:
                                                    widget.screenName == AppString.editScreenFlag ? vehicleDetailController.initYearIndex.value : 5),
                                            diameterRatio: 1,
                                            magnification: 1.1,
                                            onSelectedItemChanged: (value) {
                                              vehicleDetailController.selectedYear.value = vehicleDetailController.currentYear.value - value;
                                              vehicleDetailController.vehicleYearController.value.text =
                                                  vehicleDetailController.selectedYear.value.toString();
                                            },
                                            itemExtent: 32.0,
                                            children: List<Widget>.generate(
                                              vehicleDetailController.currentYear.value - 1970 + 1,
                                              (index) {
                                                return Center(
                                                  child: AppText(
                                                    text: '${vehicleDetailController.currentYear.value - index}',
                                                  ),
                                                ).paddingOnly(top: 5.h, bottom: 5.w);
                                              },
                                            ),
                                          ),
                                        ),
                                      ).paddingOnly(left: 16.w, right: 16.w),
                                      CustomButton(
                                        height: 50.h,
                                        buttonColor: AppColors.primaryColor,
                                        onTap: () {
                                          vehicleDetailController.vehicleYearController.value.text =
                                              vehicleDetailController.selectedYear.value.toString();
                                          Get.back();
                                        },
                                        text: AppString.save,
                                      ).paddingOnly(left: 16.w, right: 15.w, bottom: 16.h)
                                    ],
                                  ),
                                ),
                              ));
                    },
                    // validator: AppValidation.vehicleYearValidator,
                    controller: vehicleDetailController.vehicleYearController.value,
                    onChanged: (String) {},
                    suffixIcon: Transform.scale(
                      scale: 0.3,
                      child: SvgPicture.asset(
                        IconAsset.downArrow,
                      ),
                    ),
                  ),
                  customTextFormField(
                    readOnly: vehicleDetailController.isCheckAnsFormTextField.value,
                    text: AppString.vehicleMake,
                    hintText: AppString.vehicleMake,
                    controller: vehicleDetailController.vehicleMakeController.value,
                    // validator: AppValidation.vehicleMakeValidator,
                    maxLength: 17,
                    onChanged: (String) {
                      vehicleDetailController.vehicleTransmissionTypeController.refresh();
                      vehicleDetailController.update();
                      // vehicleDetailController.isCheckAnsFormTextField.value = vehicleDetailController.vehicleMakeController.value.text.isNotEmpty;
                    },
                    onTap: () {},
                  ).paddingSymmetric(vertical: 16.h),
                  customTextFormField(
                    readOnly: vehicleDetailController.isCheckAnsFormTextField.value,
                    text: AppString.vehicleModel,
                    hintText: AppString.vehicleModel,
                    controller: vehicleDetailController.vehicleModelController.value,
                    // validator: AppValidation.vehicleModelValidator,
                    maxLength: 17,
                    onChanged: (String) {
                      vehicleDetailController.vehicleTransmissionTypeController.refresh();
                      vehicleDetailController.update();
                      // vehicleDetailController.isCheckAnsFormTextField.value = vehicleDetailController.vehicleModelController.value.text.isNotEmpty;
                    },
                    onTap: () {},
                  ).paddingSymmetric(vertical: 16.h),
                  customTextFormField(
                    readOnly: vehicleDetailController.isCheckAnsFormTextField.value,
                    text: AppString.fuelType,
                    hintText: AppString.fuelType,
                    controller: vehicleDetailController.vehicleFuelTypeController.value,
                    // validator: AppValidation.fuelType,
                    maxLength: 17,
                    onChanged: (String) {
                      vehicleDetailController.vehicleTransmissionTypeController.refresh();
                      vehicleDetailController.update();
                      // vehicleDetailController.isCheckAnsFormTextField.value = vehicleDetailController.vehicleFuelTypeController.value.text.isNotEmpty;
                    },
                    onTap: () {},
                  ).paddingSymmetric(vertical: 16.h),
                  customTextFormField(
                    readOnly: vehicleDetailController.isCheckAnsFormTextField.value,
                    text: AppString.transmissionType,
                    hintText: AppString.transmissionType,
                    controller: vehicleDetailController.vehicleTransmissionTypeController.value,
                    // validator: AppValidation.transMissionTypeValidator,
                    maxLength: 17,
                    onChanged: (String) {
                      vehicleDetailController.vehicleTransmissionTypeController.refresh();
                      vehicleDetailController.update();
                      // vehicleDetailController.isCheckAnsFormTextField.value =
                      //     vehicleDetailController.vehicleTransmissionTypeController.value.text.isNotEmpty;
                    },
                    onTap: () {},
                  ).paddingSymmetric(vertical: 16.h),
                  /*  selectionTextField(
                    onMenuStateChange: (p0) {
                      log("messagemessagemessagemessage");
                      vehicleDetailController.scrollToBottom();
                    },
                    vehicleDetailController: vehicleDetailController,
                    context,
                    text: AppString.vehicleMake,
                    validator: AppValidation.vehicleMakeValidator,
                    list: vehicleDetailController.vehicleMakeList,
                    selectedVal: vehicleDetailController.selectedValueMake,
                    onChanged: (newValue) {
                      vehicleDetailController.selectedValueMake.value = newValue;
                      vehicleDetailController.isValidateVMake.value = true;
                      vehicleDetailController.selectedValueModel.value = null;
                      vehicleDetailController.isValidateVModel.value = false;
                      vehicleDetailController.vehicleModel.value = [];

                      vehicleDetailController.selectedValueTType.value = null;
                      vehicleDetailController.isValidateVType.value = false;
                      vehicleDetailController.transmissionType.value = [];

                      vehicleDetailController.selectedValueFType.value = null;
                      vehicleDetailController.isValidateVFuelT.value = false;
                      vehicleDetailController.fuelType.value = [];

                      SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
                        vehicleDetailController.vehicleModelApi(selectedVehicleMakeString: vehicleDetailController.selectedValueMake.value ?? "");
                      });
                    },
                  ).paddingSymmetric(vertical: 16.h),
                  GestureDetector(
                    onTap: () {
                      log("log(messagemessagemessagemessage);");
                      if (vehicleDetailController.selectedValueMake.value?.isEmpty ?? true) {
                        AppSnackBar.showErrorSnackBar(message: "Please select vehicle make", title: "error");
                      }
                    },
                    child: selectionTextField(
                      onMenuStateChange: (p0) {
                        vehicleDetailController.scrollToBottom();
                      },
                      vehicleDetailController: vehicleDetailController,
                      context,
                      validator: AppValidation.vehicleModelValidator,
                      text: AppString.vehicleModel,
                      list: vehicleDetailController.vehicleModel.value,
                      selectedVal: vehicleDetailController.selectedValueModel,
                      onChanged: (newValue) {
                        vehicleDetailController.selectedValueModel.value = newValue;
                        vehicleDetailController.isValidateVModel.value = true;

                        vehicleDetailController.selectedValueFType.value = null;

                        vehicleDetailController.isValidateVFuelT.value = false;

                        vehicleDetailController.selectedValueTType.value = null;

                        vehicleDetailController.isValidateVType.value = false;

                        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                          vehicleDetailController.vehicleFuelType(
                            selectedVehicleMakeString: vehicleDetailController.selectedValueMake.value ?? "",
                            selectedVehicleModelString: vehicleDetailController.selectedValueModel.value ?? "",
                          );
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      log("log(messagemessagemessagemessage);");
                      if (vehicleDetailController.selectedValueModel.value?.isEmpty ?? true) {
                        AppSnackBar.showErrorSnackBar(message: "Please select vehicle model", title: "error");
                      }
                    },
                    child: selectionTextField(
                      onMenuStateChange: (p0) {
                        vehicleDetailController.scrollToBottom();
                      },
                      vehicleDetailController: vehicleDetailController,
                      context,
                      validator: AppValidation.fuelType,
                      text: AppString.fuelType,
                      list: vehicleDetailController.fuelType.value,
                      selectedVal: vehicleDetailController.selectedValueFType,
                      onChanged: (newValue) {
                        vehicleDetailController.selectedValueFType.value = newValue;
                        vehicleDetailController.isValidateVFuelT.value = true;

                        vehicleDetailController.selectedValueTType.value = null;
                        vehicleDetailController.isValidateVType.value = false;

                        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                          vehicleDetailController.vehicleTransmissionType(
                            selectedVehicleMakeString: vehicleDetailController.selectedValueMake.value!,
                            selectedVehicleModelString: vehicleDetailController.selectedValueModel.value!,
                            selectedVehicleFuelString: vehicleDetailController.selectedValueFType.value!,
                          );
                        });
                      },
                    ).paddingSymmetric(vertical: 16.h),
                  ),
                  GestureDetector(
                    onTap: () {
                      log("log(messagemessagemessagemessage);");
                      if (vehicleDetailController.selectedValueFType.value?.isEmpty ?? true) {
                        AppSnackBar.showErrorSnackBar(message: "Please select vehicle fuel type", title: "error");
                      }
                    },
                    child: selectionTextField(
                      onMenuStateChange: (p0) {
                        vehicleDetailController.scrollToBottom();
                      },
                      vehicleDetailController: vehicleDetailController,
                      context,
                      validator: AppValidation.transMissionTypeValidator,
                      text: AppString.transmissionType,
                      list: vehicleDetailController.transmissionType.value,
                      selectedVal: vehicleDetailController.selectedValueTType,
                      onChanged: (String) {
                        vehicleDetailController.selectedValueTType.value = String;
                        vehicleDetailController.isValidateVType.value = true;

                        SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {});
                      },
                    ),
                  ),*/
                  Obx(
                    () {
                      print(vehicleDetailController.vehicleNumberController.value.text.isNotEmpty &&
                          vehicleDetailController.vehicleYearController.value.text.isNotEmpty &&
                          vehicleDetailController.vehicleMakeController.value.text.isNotEmpty &&
                          vehicleDetailController.vehicleModelController.value.text.isNotEmpty &&
                          vehicleDetailController.vehicleFuelTypeController.value.text.isNotEmpty &&
                          vehicleDetailController.vehicleTransmissionTypeController.value.text.isNotEmpty &&
                          (vehicleDetailController.image.value.isNotEmpty || vehicleDetailController.networkImage.value.isNotEmpty));
                      print(
                          "vehicleNumberController::${vehicleDetailController.vehicleNumberController.value.text} vehicleYearController::${vehicleDetailController.vehicleYearController.value.text} vehicleMakeController::${vehicleDetailController.vehicleMakeController.value.text} vehicleModelController::${vehicleDetailController.vehicleModelController.value.text} vehicleFuelTypeController::${vehicleDetailController.vehicleFuelTypeController.value.text} vehicleTransmissionTypeController::${vehicleDetailController.vehicleTransmissionTypeController.value.text} ${vehicleDetailController.image.value} || ${vehicleDetailController.networkImage.value}");
                      return Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              // vehicleDetailController.formKey.currentState?.validate() ?? false;
                              if (vehicleDetailController.isSnackBarStop.value) {
                                if ((vehicleDetailController.image.value.isNotEmpty || vehicleDetailController.networkImage.value.isNotEmpty) ==
                                    false) {
                                  AppSnackBar.showErrorSnackBar(message: "Please select vehicle image.", title: "error");
                                  vehicleDetailController.snackBarStopFunction();
                                } else if (vehicleDetailController.vehicleNumberController.value.text.isEmpty) {
                                  vehicleDetailController.snackBarStopFunction();
                                  AppSnackBar.showErrorSnackBar(message: "Please select vehicle number.", title: "error");
                                } else if (vehicleDetailController.vehicleYearController.value.text.isEmpty) {
                                  vehicleDetailController.snackBarStopFunction();
                                  AppSnackBar.showErrorSnackBar(message: "Please select vehicle year.", title: "error");
                                } else if (vehicleDetailController.vehicleMakeController.value.text.isEmpty) {
                                  vehicleDetailController.snackBarStopFunction();
                                  AppSnackBar.showErrorSnackBar(message: "Please select vehicle make.", title: "error");
                                } else if (vehicleDetailController.vehicleModelController.value.text.isEmpty) {
                                  vehicleDetailController.snackBarStopFunction();
                                  AppSnackBar.showErrorSnackBar(message: "Please select vehicle model.", title: "error");
                                } else if (vehicleDetailController.vehicleFuelTypeController.value.text.isEmpty) {
                                  vehicleDetailController.snackBarStopFunction();
                                  AppSnackBar.showErrorSnackBar(message: "Please select vehicle fuel type.", title: "error");
                                } else if (vehicleDetailController.vehicleTransmissionTypeController.value.text.isEmpty) {
                                  AppSnackBar.showErrorSnackBar(message: "Please select vehicle transmission type.", title: "error");
                                  vehicleDetailController.snackBarStopFunction();
                                }
                              }
                            },
                            child: CustomButton(
                              onTap: () async {
                                log("message");
                                widget.screenName == AppString.editScreenFlag
                                    ? await vehicleDetailController.editVehicleApi()
                                    : await vehicleDetailController.addVehicleApi();
                              },
                              isDisabled: (vehicleDetailController.vehicleNumberController.value.text.isNotEmpty &&
                                      vehicleDetailController.vehicleYearController.value.text.isNotEmpty &&
                                      vehicleDetailController.vehicleMakeController.value.text.isNotEmpty &&
                                      vehicleDetailController.vehicleModelController.value.text.isNotEmpty &&
                                      vehicleDetailController.vehicleFuelTypeController.value.text.isNotEmpty &&
                                      vehicleDetailController.vehicleTransmissionTypeController.value.text.isNotEmpty &&
                                      (vehicleDetailController.image.value.isNotEmpty || vehicleDetailController.networkImage.value.isNotEmpty))
                                  ? false
                                  : true,
                              height: 52.h,
                              width: 131.w,
                              disableTextColor: AppColors.whiteColor,
                              endSvgHeight: 16.h,
                              endSvg: IconAsset.forwardArrow,
                              text: AppString.submit,
                              borderRadius: BorderRadius.circular(46),
                            ),
                          )).paddingOnly(bottom: 25.h, top: 16.h);
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.w),
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
      required Function(bool)? onMenuStateChange,
      required String? Function(String?)? validator,
      required VehicleDetailController vehicleDetailController,
      required RxnString? selectedVal}) {
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
                text: selectedVal?.value ?? AppString.select,
                fontSize: 16.sp,
                letterSpacing: 0.5,
                fontWeight: selectedVal?.value == null ? FontWeight.w500 : FontWeight.w600,
                color: selectedVal?.value == null ? AppColors.blackColor.withOpacity(0.4) : AppColors.primaryColor,
                // color: AppColors.primaryColor,
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
          value: selectedVal?.value,
          // value: vehicleDetailController.selectedValue.value.isEmpty ? AppString.selectGender : AppString.male,
          onChanged: (value) {
            onChanged!(value!);
          },
          validator: validator,
          onSaved: (value) {},
          onMenuStateChange: (isOpen) {
            onMenuStateChange!(isOpen);
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
    );
  }
}
