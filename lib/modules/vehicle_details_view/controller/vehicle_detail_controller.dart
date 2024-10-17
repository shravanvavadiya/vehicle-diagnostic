import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/add_vehicle_model.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/my_vehicle_model.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_preferences.dart';
import '../../../utils/app_string.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../../add_vehicle_information/presentation/vehicle_diagnosis_screen.dart';
import '../../dashboad/home/models/get_vehicle_data_model.dart';
import '../model/vehicle_number_model.dart';
import '../service/add_vehicle_service.dart';

class VehicleDetailController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxInt vehicleId = 0.obs;
  RxInt vehicleUserId = 0.obs;
  RxInt initYearIndex = 0.obs;
  Timer? debounce;
  RxBool isSnackBarStop = true.obs;
  RxBool isCheckAnsFormTextField = false.obs;

  snackBarStopFunction() {
    isSnackBarStop.value = false;
    Future.delayed(
      Duration(seconds: 2),
          () => isSnackBarStop.value = true,
    );
  }

  VehicleDetailController({required String name, required Vehicle fetchData}) {
    print(name);
    name == AppString.editScreenFlag
        ? {
      screenName.value = AppString.editYourVehicleDetails,
      // fetchData.photo = image.value,
      // fetchData.vehicleNumber = vehicleNumber.text,
      vehicleNumberController.value.text = fetchData.vehicleNumber!,
      vehicleYearController.value.text = fetchData.vehicleYear!,

      vehicleMakeController.value.text = fetchData.vehicleMake!,
      vehicleModelController.value.text = fetchData.vehicleModel!,
      vehicleTransmissionTypeController.value.text = fetchData.transmissionType!,
      vehicleFuelTypeController.value.text = fetchData.fuelType!,
      networkImage.value = fetchData.photo!,
      vehicleId.value = fetchData.id!,
      vehicleUserId.value = fetchData.userId!,

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      //   vehicleModelApi(selectedVehicleMakeString: selectedValueMake.value ?? "");
      //   vehicleFuelType(
      //     selectedVehicleMakeString: selectedValueMake.value ?? "",
      //     selectedVehicleModelString: selectedValueModel.value ?? "",
      //   );
      //   vehicleTransmissionType(
      //     selectedVehicleMakeString: selectedValueMake.value!,
      //     selectedVehicleModelString: selectedValueModel.value!,
      //     selectedVehicleFuelString: selectedValueFType.value!,
      //   );
      // }),
    }
        : {
      screenName.value = AppString.addYourVehicleDetails,
    };
  }

  RxString screenName = "".obs;

  ScrollController scrollController = ScrollController();

  final Rx<TextEditingController> vehicleNumberController = TextEditingController().obs;
  final Rx<TextEditingController> vehicleYearController = TextEditingController().obs;
  final Rx<TextEditingController> vehicleMakeController = TextEditingController().obs;
  final Rx<TextEditingController> vehicleModelController = TextEditingController().obs;
  final Rx<TextEditingController> vehicleFuelTypeController = TextEditingController().obs;
  final Rx<TextEditingController> vehicleTransmissionTypeController = TextEditingController().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<AddVehicleModel> addVehicleModel = AddVehicleModel().obs;
  XFile? imagePath;
  RxString image = "".obs;
  RxString networkImage = "".obs;
  RxInt selectedYear = 2019.obs;
  final RxInt currentYear = DateTime
      .now()
      .year
      .obs;

  /* final RxList<String> vehicleMakeList = RxList();
  final RxList<String> vehicleModel = RxList();
  final RxList<String> fuelType = RxList();
  final RxList<String> transmissionType = RxList();

  final RxnString selectedValueMake = RxnString();
  final RxnString selectedValueModel = RxnString();
  final RxnString selectedValueTType = RxnString();
  final RxnString selectedValueFType = RxnString();*/
  VehicleNumberModel? vehicleResponse;
  RxBool isCheckVehicleNUmber = false.obs;

  Future<VehicleNumberModel?> vehicleNumberCheck({required String vehicleNumberText}) async {
    handleLoading(true);

    try {
      vehicleResponse = await VehicleService.vehicleNumber(vehicleNumber: vehicleNumberText);
      log("vehicleResponse ${vehicleResponse!.toJson()}");

      vehicleResponse?.response?.statusCode == "KeyInvalid"
          ? {
        AppSnackBar.showErrorSnackBar(
            message: "We couldn't find the vehicle number in our database. Please enter the details manually to proceed.", title: "success"),
        snackBarStopFunction(),
        isCheckAnsFormTextField.value = false,
        vehicleYearController.value.text = "",
        vehicleMakeController.value.text = "",
        vehicleModelController.value.text = "",
        vehicleFuelTypeController.value.text = "",
        vehicleTransmissionTypeController.value.text = "",
        vehicleYearController.refresh(),
        vehicleMakeController.refresh(),
        vehicleModelController.refresh(),
        vehicleFuelTypeController.refresh(),
        vehicleTransmissionTypeController.refresh(),
      }
          : {
        vehicleYearController.value.text = vehicleResponse?.response?.dataItems?.vehicleRegistration?.yearOfManufacture ?? "",
        vehicleMakeController.value.text = vehicleResponse?.response?.dataItems?.vehicleRegistration?.make ?? "",
        vehicleModelController.value.text = vehicleResponse?.response?.dataItems?.vehicleRegistration?.model ?? "",
        vehicleFuelTypeController.value.text = vehicleResponse?.response?.dataItems?.vehicleRegistration?.fuelType ?? "",
        vehicleTransmissionTypeController.value.text = vehicleResponse?.response?.dataItems?.vehicleRegistration?.transmissionType ?? "",
        isCheckAnsFormTextField.value = true,
        vehicleYearController.refresh(),
        vehicleMakeController.refresh(),
        vehicleModelController.refresh(),
        vehicleFuelTypeController.refresh(),
        vehicleTransmissionTypeController.refresh(),
      };

      /*vehicleNumberController.text = vehicleResponse!.registrationNumber!;
      isValidateVName.value = true;
      vehicleYearController.text = vehicleResponse!.yearOfManufacture!.toString();
      isValidateVYear.value = true;
      String carMake = (vehicleResponse?.make ?? '').toLowerCase();
      log("vehicleResponse carMake::$carMake");
      String? resultCarMake = vehicleMakeList.firstWhereOrNull(
        (element) => element.toLowerCase().contains(carMake),
      );
      log("vehicleResponse DATA::$resultCarMake");
      selectedValueMake.value = resultCarMake;
      isValidateVMake.value = true;
      selectedValueFType.value = vehicleResponse!.fuelType!;
      isValidateVFuelT.value = true;
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
        vehicleModelApi(selectedVehicleMakeString: selectedValueMake.value ?? "");
      });*/
    } catch (e, st) {
      AppSnackBar.showErrorSnackBar(
          message: "We couldn't find the vehicle number in our database. Please enter the details manually to proceed.", title: "error");
      log("error e :::::::$e ::::::::::: $st");
      handleLoading(false);
    } finally {
      handleLoading(false);
    }
  }

  int findYearIndex(int startYear, int count, int selectedYear) {
    // Generate the list of years in reverse order
    List<int> yearList = List.generate(count, (index) => startYear + count - 1 - index);

    return yearList.indexOf(selectedYear);
  }

  getSelectedYear() {
    int yearCount = currentYear.value - 1970 + 1;
    log("yearCount ${yearCount}");

    int yearIndex = findYearIndex(1970, yearCount, int.parse(vehicleYearController.value.text));

    if (yearIndex != -1) {
      initYearIndex.value = yearIndex;
      log('Selected year $selectedYear found at index: $yearIndex');
    } else {
      log('Selected year $selectedYear not found in the list.');
    }
  }

  // Future<void> vehicleMakeApi() async {
  //   handleLoading(true);
  //   await processApi(
  //     () => VehicleService.vehicleMake(),
  //     error: (error, stack) {
  //       log("UpdateUserProfile error ---> $error --- $stack");
  //       handleLoading(false);
  //     },
  //     result: (result) async {
  //       if (result.apiresponse?.data != null || result.apiresponse!.data!.isNotEmpty) {
  //         vehicleMakeList.assignAll(result.apiresponse!.data!);
  //         vehicleMakeList.refresh();
  //         update();
  //         handleLoading(false);
  //       }
  //     },
  //   );
  //   handleLoading(false);
  // }
  //
  // Future<void> vehicleModelApi({required String selectedVehicleMakeString}) async {
  //   handleLoading(true);
  //   log("vehicleModel.value 03 ${vehicleModel.value}");
  //   log("vehicleModel.value string  03 ${selectedValueMake.value}");
  //
  //   await processApi(
  //     () => VehicleService.vehicleModel(selectedVehicleMake: selectedVehicleMakeString),
  //     error: (error, stack) {
  //       log("UpdateUserProfile error ---> $error --- $stack");
  //       handleLoading(false);
  //     },
  //     result: (result) async {
  //       log("vehicle model ${result.apiresponse!.data!}");
  //       vehicleModel.value.assignAll(result.apiresponse!.data!);
  //       vehicleModel.refresh();
  //       update();
  //
  //       handleLoading(false);
  //       log("vehicleModel.value 04 ${vehicleModel.value}");
  //       log("vehicleModel.value string  04 ${selectedValueMake.value}");
  //     },
  //   );
  //   handleLoading(false);
  // }
  //
  // Future<void> vehicleFuelType({required String selectedVehicleMakeString, required String selectedVehicleModelString}) async {
  //   handleLoading(true);
  //
  //   await processApi(
  //     () => VehicleService.vehicleFuel(selectedVehicleMake: selectedVehicleMakeString, selectedVehicleModel: selectedVehicleModelString),
  //     error: (error, stack) {
  //       log("UpdateUserProfile error ---> $error --- $stack");
  //       handleLoading(false);
  //     },
  //     result: (result) async {
  //       if (result.apiresponse?.data != null || result.apiresponse!.data!.isNotEmpty) {
  //         log("vehicle model ${result.apiresponse!.data!}");
  //         fuelType.value.assignAll(result.apiresponse!.data!);
  //         fuelType.refresh();
  //         update();
  //         handleLoading(false);
  //       }
  //     },
  //   );
  //   handleLoading(false);
  // }
  //
  // Future<void> vehicleTransmissionType(
  //     {required String selectedVehicleMakeString, required String selectedVehicleModelString, required String selectedVehicleFuelString}) async {
  //   handleLoading(true);
  //
  //   await processApi(
  //     () => VehicleService.vehicleTransmission(
  //       selectedVehicleMake: selectedVehicleMakeString,
  //       selectedVehicleModel: selectedVehicleModelString,
  //       selectedVehicleFuel: selectedVehicleFuelString,
  //     ),
  //     error: (error, stack) {
  //       log("UpdateUserProfile error ---> $error --- $stack");
  //       handleLoading(false);
  //     },
  //     result: (result) async {
  //       if (result.apiresponse?.data != null || result.apiresponse!.data!.isNotEmpty) {
  //         log("vehicle model ${result.apiresponse!.data!}");
  //         transmissionType.value.assignAll(result.apiresponse!.data!);
  //         transmissionType.refresh();
  //         handleLoading(false);
  //       }
  //     },
  //   );
  //   handleLoading(false);
  // }

  Future<void> addVehicleApi() async {
    handleLoading(true);
    final MyVehicleData addVehicleData = MyVehicleData(
      fuelType: vehicleFuelTypeController.value.text.trim(),
      vehicleYear: vehicleYearController.value.text.trim(),
      vehicleNumber: vehicleNumberController.value.text.trim(),
      vehicleModel: vehicleModelController.value.text.trim(),
      vehicleMake: vehicleMakeController.value.text.trim(),
      userId: AppPreference.getInt("UserId"),
      transmissionType: vehicleTransmissionTypeController.value.text.trim(),
      id: vehicleId.value,
    );
    await processApi(
          () =>
          VehicleService.createVehicle(
            setUpProfileFormData: addVehicleData,
            imagePath: image.value,
          ),
      error: (error, stack) {
        log("UpdateUserProfile error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        if (result != null) {
          if (kDebugMode) {
            print("result $result");
          }
          Map<String, dynamic> jsonData = jsonDecode(result ?? "");
          int vehicleId = jsonData['apiresponse']['data']['id'];
          if (kDebugMode) {
            print('Vehicle ID: $vehicleId');
          }
          AppPreference.setInt("VEHICLEID", vehicleId);

          await Get.offAll(VehicleDiagnosisScreen(
            screenName: AppString.newVehicleAddFlag,
            vehicleId: vehicleId,
          ));
        } else {}
      },
    );

    handleLoading(false);
  }

  Future<void> editVehicleApi() async {
    handleLoading(true);
    final MyVehicleData editVehicleData = MyVehicleData(
      fuelType: vehicleFuelTypeController.value.text.trim(),
      vehicleYear: vehicleYearController.value.text.trim(),
      vehicleNumber: vehicleNumberController.value.text.trim(),
      vehicleModel: vehicleModelController.value.text.trim(),
      vehicleMake: vehicleMakeController.value.text.trim(),
      userId: AppPreference.getInt("UserId"),
      transmissionType: vehicleTransmissionTypeController.value.text.trim(),
      id: vehicleId.value,
    );

    await processApi(
          () =>
          VehicleService.editVehicle(
            setUpProfileFormData: editVehicleData,
            imagePath: image.value,
          ),
      error: (error, stack) {
        log("UpdateUserProfile error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        if (kDebugMode) {
          print("result $result");
        }
        Map<String, dynamic> jsonData = jsonDecode(result!);
        int vehicleId = jsonData['apiresponse']['data']['vehicleId'];
        if (kDebugMode) {
          print('Vehicle ID: $vehicleId');
        }
        AppPreference.setInt("VEHICLEID", vehicleId);
        Get.to(VehicleDiagnosisScreen(
          screenName: AppString.editScreenFlag,
          vehicleId: vehicleId,
        ));
      },
    );
    handleLoading(false);
  }

// dynamic selectedIndex = 0.0.obs;
//
// void scrollToBottom() {
//   scrollController.animateTo(
//     scrollController.position.maxScrollExtent,
//     duration: const Duration(milliseconds: 300),
//     curve: Curves.easeOut,
//   );
// }
}

// class CustomInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     String newText = newValue.text.toUpperCase().replaceAll(' ', '');
//     if (newText.length > 4) {
//       newText = newText.substring(0, 4) + ' ' + newText.substring(4);
//     }
//     return newValue.copyWith(
//       text: newText,
//       selection: TextSelection.collapsed(offset: newText.length),
//     );
//   }
// }
