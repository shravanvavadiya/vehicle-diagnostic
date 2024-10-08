import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/add_vehicle_information/models/selected_qns_ans_model.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:get/get.dart';

import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../models/submit_vehicle_request.dart';
import '../models/vehicle_information_step_model.dart';
import '../services/vehicle_information_service.dart';

class QuestionAndAnsController extends GetxController with LoadingMixin, LoadingApiMixin {
  PageController pageController = PageController();
  RxInt currentStep = 0.obs;
  Map<int, String> selectedAnswers = {}; // Store the selected answers by index
  RxDouble progress = 0.1.obs;
  RxBool isLoading = false.obs;
  RxBool isResponseData = false.obs;
  Rx<VehicleInformationModel> vehicleModel = VehicleInformationModel().obs;
  List<SelectedQnsAnsModel> selectedResponseList = <SelectedQnsAnsModel>[];
  RxInt userVehicleId = 0.obs;

  void updateProgress() {
    progress.value = (currentStep.value + 1) / vehicleModel.value.apiresponse!.data!.length; // Update progress based on the current step
  }

  RxMap preLoadDataResponse = {}.obs;

  void clearAll() {
    selectedAnswers.clear();
    selectedResponseList.clear();
    currentStep.value = 0;
    pageController.jumpToPage(0);
    progress.value = 0.1;
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
      },
    );
    isLoading.value = false;
    handleLoading(false);
  }

  Future preLoadDataFunction({required int vehicleId}) async {
    log("preLoadDataFunction===>onTAP yes call");
    processApi(
      () => VehicleInformationService.getAnsByVehicleId(vehicleId: vehicleId),
      error: (error, stack) {
        log("preLoadDataFunction===>onTAP yes error $error");
        handleLoading(false);
      },
      result: (data) {
        selectedResponseList = [];
        log("preLoadDataFunction===>onTAP yes success Res::${data.toJson()}");
        for (var key in data.apiresponse?.data?.qaVehicleResponses ?? []) {
          int totleLength = vehicleModel.value.apiresponse?.data?.length ?? 0;
          for (int i = 0; i < totleLength; i++) {
            if (key.question == vehicleModel.value.apiresponse?.data?[i].key) {
              print("compere both data for pre load data ${key.question}----$i");
              // int datas = vehicleModel.value.apiresponse!.data![i].answers!.indexOf(key.answer!);
              // preLoadDataResponse[key.question] = datas;
              selectedResponseList.add(SelectedQnsAnsModel(question: key.question, answer: key.answer));
              selectedAnswers[i] = key.answer ?? ""; // Store answer by index
              isResponseData.value = true;
              break;
            }
          }
        }
        log(" preLoadDataFunction final response:::${selectedResponseList}");
      },
    );
  }

  void finalResponse() {
    Map response = {};
  }

  Future submitForm({required int vehicleId, required List<SelectedQnsAnsModel> selectedResponse}) async {
    print("selectedResponse $selectedResponse");
    final body = {
      "qaVehicleRequests": selectedResponse,
      "vehicleId": vehicleId,
    };
    handleLoading(true);
    log("bodybody ${body}");
    processApi(
      () => VehicleInformationService.submitVehicleRequest(body),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        log("data::: ${data.toJson()}");
        Get.offAll(HomeScreen());
        clearAll();
        handleLoading(false);
      },
    );
    return null;
  }

  Future<VehicleQuestionAndAns?> EditForm({required int vehicleId, required List<SelectedQnsAnsModel> selectedResponse}) async {
    final body = {
      "qaVehicleRequests": selectedResponse,
      "vehicleId": vehicleId,
    };
    log("body :: ${body.entries}");
    handleLoading(true);
    processApi(
      () => VehicleInformationService.editVehicleRequest(body),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        log("data::: ${data.toJson()}");
        // Navigation.pushNamed(Routes.homeScreen);
        Get.offAll(HomeScreen());
        clearAll();
        handleLoading(false);
      },
    );
    return null;
  }

  @override
  void onInit() {
    log("Get.arguments ${Get.arguments}");
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
