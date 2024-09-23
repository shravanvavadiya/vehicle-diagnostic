import 'dart:async';
import 'dart:developer';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:get/get.dart';

import '../models/vehicle_information_step_model.dart';
import '../services/vehicle_information_service.dart';

class AddVehicleInformationController extends GetxController
    with LoadingMixin, LoadingApiMixin {
  Rx<VehicleInformationModel> vehicleModel = VehicleInformationModel().obs;
  RxList<QueData> getAllVehicleQueList = <QueData>[].obs;
  RxBool isLoading = false.obs;
  RxList<String> selectedAnswers = <String>[].obs;
  RxString question = ''.obs;

  // Method to update selected answers and store the question
  void updateSelectedAnswers(String newQuestion, List<String> answers) {
    question.value = newQuestion;
    selectedAnswers.assignAll(answers);
  }

  /* @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            getAllVehiclesQue();
      },
    );
    super.onInit();
  }*/

  //Get all question with options
  Future<void> getAllVehiclesQue() async {
    handleLoading(true);
    isLoading.value = true;
    processApi(
      () => VehicleInformationService.getVehicleInformation(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        vehicleModel.value = data;
        getAllVehicleQueList.addAll(data.apiresponse?.data ?? []);
        log("getAllVehicleList que list :: ${getAllVehicleQueList.toJson()}");
        log("vehicle que list data :: ${data.apiresponse?.data}");
        log("vehicle que list:: ${getAllVehicleQueList.length}");
      },
    );
    isLoading.value = false;
    handleLoading(false);
  }

  //Submit ans for all question
  Future<void> submitForm(int vehicleId) async {
    final body = {
      "qaVehicleRequests": selectedAnswers
          .map((answer) => {"answer": answer, "question": question.value})
          .toList(),
      "vehicleId": vehicleId,
    };
    handleLoading(true);
    processApi(
      () => VehicleInformationService.submitVehicleRequest(body),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        handleLoading(false);
      },
    );
  }
}
