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

  VehicleDetailController({required String name, required Vehicle fetchData}) {
    print(name);
    name == AppString.editScreenFlag
        ? {
            screenName.value = AppString.editYourVehicleDetails,
            // fetchData.photo = image.value,
            // fetchData.vehicleNumber = vehicleNumber.text,
            vehicleNumber.text = fetchData.vehicleNumber!,
            vehicleYear.text = fetchData.vehicleYear!,
            selectedYear.value = int.parse(fetchData.vehicleYear!),
            selectedValueMake.value = fetchData.vehicleMake!,
            selectedValueModel.value = fetchData.vehicleModel!,
            selectedValueTType.value = fetchData.transmissionType!,
            selectedValueFType.value = fetchData.fuelType!,
            networkImage.value = fetchData.photo!,
            vehicleId.value = fetchData.id!,
            vehicleUserId.value = fetchData.userId!,

            isValidateVName.value = true,
            isValidateVYear.value = true,
            isValidateVMake.value = true,
            isValidateVModel.value = true,
            isValidateVType.value = true,
            isValidateVFuelT.value = true,
            isValidateImage.value = true,
          }
        : {
            screenName.value = AppString.addYourVehicleDetails,
          };
  }

  RxString screenName = "".obs;

  ScrollController scrollController = ScrollController();

  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController vehicleYear = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<AddVehicleModel> addVehicleModel = AddVehicleModel().obs;
  XFile? imagePath;
  RxString image = "".obs;
  RxString networkImage = "".obs;
  RxInt selectedYear = 2010.obs;
  final RxInt currentYear = DateTime.now().year.obs;

  RxBool isValidateVName = false.obs;
  RxBool isValidateVYear = false.obs;
  RxBool isValidateVMake = false.obs;
  RxBool isValidateVModel = false.obs;
  RxBool isValidateVType = false.obs;
  RxBool isValidateVFuelT = false.obs;
  RxBool isValidateImage = false.obs;

  clearController() {
    vehicleNumber.text = "";
    vehicleYear.text = "";
    imagePath = XFile("");
    image.value = "";
    selectedValueMake.value = 'Select';
    selectedValueModel.value = 'Select';
    selectedValueTType.value = 'Select';
    selectedValueFType.value = 'Select';
  }

  Future<void> clearAfterSelectedData() async {
    vehicleModel.value = [];
    selectedValueModel.value = "";
    isValidateVModel.value = false;
    fuelType.value = [];
    selectedValueFType.value = "Select";
    isValidateVType.value = false;
    transmissionType.value = [];
    selectedValueTType.value = "Select";
    isValidateVFuelT.value = false;
  }

  final RxList<String> vehicleMakeList = RxList();
  final RxList<String> vehicleModel = RxList();
  final RxList<String> fuelType = RxList();
  final RxList<String> transmissionType = RxList();

  final RxnString selectedValueMake = RxnString();
  final RxnString selectedValueModel = RxnString();
  final RxnString selectedValueTType = RxnString();
  final RxnString selectedValueFType = RxnString();
  VehicleNumberModel? vehicleResponse;
  RxBool isCheckVehicleNUmber = false.obs;

  Future<VehicleNumberModel?> vehicleNumberCheck({required String vehicleNumberText}) async {
    handleLoading(true);

    try {
      vehicleResponse = await VehicleService.vehicleNumber(vehicleNumber: vehicleNumberText); // OG63 GGG
      log("vehicleResponse ${vehicleResponse!.toJson()}");
      vehicleNumber.text = vehicleResponse!.registrationNumber!;
      isValidateVName.value = true;
      vehicleYear.text = vehicleResponse!.yearOfManufacture!.toString();
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
      });

      update();

      log("vehicleResponse makeTemp:;$carMake");
      log("vehicleResponse vehicleMakeList:;$vehicleMakeList");
      log("vehicleResponse selectedValueMake:;$selectedValueMake");
    } catch (e) {
      AppSnackBar.showErrorSnackBar(message: "Vehicle Details Not Found", title: "error");
      log("error e :::::::$e");
      handleLoading(false);
    } finally {
      handleLoading(false);
    }
  }

  Future<void> vehicleMakeApi() async {
    handleLoading(true);
    await processApi(
      () => VehicleService.vehicleMake(),
      error: (error, stack) {
        log("UpdateUserProfile error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        if (result.apiresponse?.data != null || result.apiresponse!.data!.isNotEmpty) {
          vehicleMakeList.assignAll(result.apiresponse!.data!);
          vehicleMakeList.refresh();
          update();
          handleLoading(false);
        }
      },
    );
    handleLoading(false);
  }

  Future<void> vehicleModelApi({required String selectedVehicleMakeString}) async {
    handleLoading(true);
    log("vehicleModel.value 03 ${vehicleModel.value}");
    log("vehicleModel.value string  03 ${selectedValueMake.value}");

    await processApi(
      () => VehicleService.vehicleModel(selectedVehicleMake: selectedVehicleMakeString),
      error: (error, stack) {
        log("UpdateUserProfile error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        log("vehicle model ${result.apiresponse!.data!}");
        vehicleModel.value.assignAll(result.apiresponse!.data!);
        vehicleModel.refresh();
        update();

        handleLoading(false);
        log("vehicleModel.value 04 ${vehicleModel.value}");
        log("vehicleModel.value string  04 ${selectedValueMake.value}");
      },
    );
    handleLoading(false);
  }

  Future<void> vehicleFuelType({required String selectedVehicleMakeString, required String selectedVehicleModelString}) async {
    handleLoading(true);

    await processApi(
      () => VehicleService.vehicleFuel(selectedVehicleMake: selectedVehicleMakeString, selectedVehicleModel: selectedVehicleModelString),
      error: (error, stack) {
        log("UpdateUserProfile error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        if (result.apiresponse?.data != null || result.apiresponse!.data!.isNotEmpty) {
          log("vehicle model ${result.apiresponse!.data!}");
          fuelType.value.assignAll(result.apiresponse!.data!);
          fuelType.refresh();
          update();
          handleLoading(false);
        }
      },
    );
    handleLoading(false);
  }

  Future<void> vehicleTransmissionType(
      {required String selectedVehicleMakeString, required String selectedVehicleModelString, required String selectedVehicleFuelString}) async {
    handleLoading(true);

    await processApi(
      () => VehicleService.vehicleTransmission(
        selectedVehicleMake: selectedVehicleMakeString,
        selectedVehicleModel: selectedVehicleModelString,
        selectedVehicleFuel: selectedVehicleFuelString,
      ),
      error: (error, stack) {
        log("UpdateUserProfile error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        if (result.apiresponse?.data != null || result.apiresponse!.data!.isNotEmpty) {
          log("vehicle model ${result.apiresponse!.data!}");
          transmissionType.value.assignAll(result.apiresponse!.data!);
          transmissionType.refresh();
          handleLoading(false);
        }
      },
    );
    handleLoading(false);
  }

  Future<void> addVehicleApi() async {
    handleLoading(true);
    final MyVehicleData addVehicleData = MyVehicleData(
      fuelType: selectedValueFType.trim(),
      vehicleYear: vehicleYear.text.trim(),
      vehicleNumber: vehicleNumber.text.trim(),
      vehicleModel: selectedValueModel.trim(),
      vehicleMake: selectedValueMake.value,
      userId: AppPreference.getInt("UserId"),
      transmissionType: selectedValueTType.value,
      id: vehicleId.value,
    );
    await processApi(
      () => VehicleService.createVehicle(
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
      fuelType: selectedValueFType.trim(),
      vehicleYear: vehicleYear.text.trim(),
      vehicleNumber: vehicleNumber.text.trim(),
      vehicleModel: selectedValueModel.trim(),
      vehicleMake: selectedValueMake.value,
      userId: vehicleUserId.value,
      transmissionType: selectedValueTType.value,
      id: vehicleId.value,
    );

    await processApi(
      () => VehicleService.editVehicle(
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

  dynamic selectedIndex = 0.0.obs;

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (vehicleModel.isNotEmpty) {
          vehicleModel.clear();
        }
        vehicleMakeApi();
        scrollController.addListener(() {
          selectedIndex = scrollController.offset;
          log("offset $selectedIndex");
        });
      },
    );
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.toUpperCase().replaceAll(' ', '');
    if (newText.length > 4) {
      newText = newText.substring(0, 4) + ' ' + newText.substring(4);
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
