import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/add_vehicle_model.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/my_vehicle_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/app_preferences.dart';
import '../../../utils/app_string.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/app_snackbar.dart';
import '../../add_vehicle_information/presentation/vehicle_diagnosis_screen.dart';
import '../../dashboad/home/models/get_vehicle_data_model.dart';
import '../service/add_vehicle_service.dart';

class VehicleDetailController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxInt vehicleId = 0.obs;
  RxInt vehicleUserId = 0.obs;

  VehicleDetailController({required String name, required Vehicle fetchData}) {
    print(name);
    name == "Edit Screen"
        ? {
            screenName.value = AppString.editYourVehicleDetails,
            // fetchData.photo = image.value,
            // fetchData.vehicleNumber = vehicleNumber.text,
            vehicleNumber.text = fetchData.vehicleNumber!,
            vehicleYear.text = fetchData.vehicleYear!,
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

  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController vehicleYear = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<AddVehicleModel> addVehicleModel = AddVehicleModel().obs;
  XFile? imagePath;
  RxString image = "".obs;
  RxString networkImage = "".obs;

  RxString selectedValueMake = 'Select'.obs;
  RxString selectedValueModel = 'Select'.obs;
  RxString selectedValueTType = 'Select'.obs;
  RxString selectedValueFType = 'Select'.obs;

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

  final List<String> vehicleMake = [
    'MARUTISUZUKI',
    'TATAMOTORS',
    'HYUNDAI',
    'TOYOTA',
    'BYD',
    'HONDA',
    'BMW',
  ];
  final List<String> vehicleModel = [
    "TOYOTACOROLLA",
    "HONDACRV",
    "POLO",
    "JEEP",
  ];

  final List<String> transmissionType = ['CAR', 'SUV', 'HYBRID'];
  final List<String> fuelType = ['PETROL', 'DIESEL', 'BIODIESEL'];

  Future<void> addVehicleApi() async {
    handleLoading(true);
    final MyVehicleData addVehicleData = MyVehicleData(
      fuelType: selectedValueFType.trim(),
      vehicleYear: vehicleYear.text.trim(),
      vehicleNumber: vehicleNumber.text.trim(),
      vehicleModel: selectedValueModel.trim(),
      vehicleMake: selectedValueMake.value,
      userId: SharedPreferencesHelper.instance.getUser()?.apiresponse?.data?.id,
      transmissionType: selectedValueTType.value,
      id: SharedPreferencesHelper.instance.getUser()?.apiresponse?.data?.id,
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
        print("result ${result}");
        Map<String, dynamic> jsonData = jsonDecode(result!);
        int id = jsonData['apiresponse']['data']['id'];
        print('Vehicle ID: $id');
        AppPreference.setInt("VEHICLEID", id);
        Get.offAll(VehicleDiagnosisScreen());
      },
    );
    imagePath = XFile("");
    image.value = "";
    clearController();
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
        print("result ${result}");
        Map<String, dynamic> jsonData = jsonDecode(result!);
        int id = jsonData['apiresponse']['data']['vehicleId'];
        print('Vehicle ID: $id');
        AppPreference.setInt("VEHICLEID", id);
        Get.to(VehicleDiagnosisScreen());
      },
    );
    imagePath = XFile("");
    image.value = "";
    clearController();
    handleLoading(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
