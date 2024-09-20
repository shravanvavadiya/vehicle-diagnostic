import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/add_vehicle_model.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/my_vehicle_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/app_snackbar.dart';
import '../service/add_vehicle_service.dart';

class VehicleDetailController extends GetxController
    with LoadingMixin, LoadingApiMixin {
  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController vehicleYear = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<AddVehicleModel> addVehicleModel = AddVehicleModel().obs;
  XFile? imagePath;
  RxString image = "".obs;

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
    vehicleNumber.clear();
    vehicleYear.clear();
    selectedValueMake.value = 'Select';
    selectedValueModel.value = 'Select';
    selectedValueTType.value = 'Select';
    selectedValueFType.value = 'Select';
  }

/*  var selectedValueMake = ValueNotifier<String>("Select");
  var selectedValueModel = ValueNotifier<String>("Select");
  var selectedValueTType = ValueNotifier<String>("Select");
  var selectedValueFType = ValueNotifier<String>("Select");*/
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

  /*Future<void> addVehicle() async {
    try {
      isProfileComplete.value = true;
      final UserDataModel setUpProfileFormData = UserDataModel(
        caption: captionController.text.trim(),
        firstName: firstNameController.text.trim(),
        gender: selectedValue.value,
        lastName: lastNameController.text.trim(),
        // email: userData?.data?.email ?? "",
        country: selectedCountry.value,
        age: DateFormat('yyyy/MM/dd').format(pickedDate).toString(),
      );
      final result = await AuthService.setupProfile(
        setUpProfileFormData: setUpProfileFormData,
        imagePath: image.value,
      );
      if (result?.statusCode == 200 || result?.statusCode == 201) {
        String? body = await result?.stream.bytesToString();
        final UserModel userModel = UserModel.fromJson(jsonDecode(body ?? ""));
        log("usermodel :: ${userModel.toJson()}");
        await AppPreference.setUser(userModel);
        log("Update Profile Successfully");
        Navigation.replaceAll(Routes.createTeam);
      }
      isProfileComplete.value = false;
    } catch (e, st) {
      isProfileComplete.value = false;
      log("UpdateUserProfile error ---> $e --- $st");
    }
  }*/

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
      () => VehicleInformationService.createVehicle(
        setUpProfileFormData: addVehicleData,
        imagePath: image.value,
      ),
      error: (error, stack) {
        log("UpdateUserProfile error ---> $error --- $stack");
        handleLoading(false);
      },
      result: (result) async {
        Navigation.pushNamed(Routes.vehicleDiagnosisScreen);
        if (result?.statusCode == 200 || result?.statusCode == 201) {
          /*  String? body = await result?.stream.bytesToString();
          final AddVehicleModel vehicleModel =
              AddVehicleModel.fromJson(jsonDecode(body ?? ""));*/
         // Navigation.pushNamed(Routes.vehicleDiagnosisScreen);
        }
      },
    );
    handleLoading(false);
  }
}
