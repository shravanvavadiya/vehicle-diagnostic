import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../modules/add_vehicle_information/models/vehicle_information_step_model.dart';
import '../modules/add_vehicle_information/services/vehicle_information_service.dart';
import '../utils/common_api_caller.dart';
import '../utils/loading_mixin.dart';

class QuestionAndAnsController extends GetxController with LoadingMixin, LoadingApiMixin {
  PageController pageController = PageController();
  RxInt currentStep = 0.obs;
  Map<int, String> selectedAnswers = {}; // Store the selected answers by index
  RxDouble progress = 0.0.obs;
  RxBool isLoading = false.obs;
  RxBool isResponseData = false.obs;
  Rx<VehicleInformationModel> vehicleModel = VehicleInformationModel().obs;
  Map<String, String> selectedResponse = {}; // Store the selected answers with keys

  void updateProgress() {
    progress.value = (currentStep.value + 1) / vehicleModel.value.apiresponse!.data!.length; // Update progress based on the current step
  }

  Future<void> getAllVehiclesQue() async {
    handleLoading(true);
    isLoading.value = true;
    processApi(
      () => VehicleInformationService.getVehicleInformation(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        if (data.apiresponse!.data?.isEmpty != true) {
          isResponseData.value = true;
          vehicleModel.value = data;
        } else {
          isResponseData.value = false;
        }
        log("vehicle que list data :: ${data.apiresponse?.data}");
      },
    );
    isLoading.value = false;
    handleLoading(false);
  }

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2), () {
      getAllVehiclesQue();
    });
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
