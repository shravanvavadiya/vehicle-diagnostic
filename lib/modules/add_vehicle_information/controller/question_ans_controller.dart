import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/add_vehicle_information/models/selected_qns_ans_model.dart';
import 'package:flutter_template/modules/chat_view/presentation/chat_screen.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:get/get.dart';

import '../../../utils/app_preferences.dart';
import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../models/submit_vehicle_request.dart';
import '../models/vehicle_information_step_model.dart';
import '../presentation/question_answer.dart';
import '../services/vehicle_information_service.dart';

class QuestionAndAnsController extends GetxController with LoadingMixin, LoadingApiMixin {
  PageController pageController = PageController();
  RxInt currentStep = 0.obs;
  RxMap<int, String> selectedAnswers = <int, String>{}.obs; // Store the selected answers by index
  RxDouble progress = 0.1.obs;
  RxBool isLoading = false.obs;
  RxBool isResponseData = false.obs;
  RxBool isPreLoadDataBool = false.obs;
  Rx<VehicleInformationModel> vehicleModel = VehicleInformationModel().obs;
  RxList<SelectedQnsAnsModel> selectedResponseList = <SelectedQnsAnsModel>[].obs;
  RxInt vehicleIdFlag = 0.obs;
  RxString screenFlag = "".obs;

  QuestionAndAnsController({required String navigationScreenFlag, required int userVehicleId}) {
    if (navigationScreenFlag == AppString.editScreenFlag) {
      log("preload function first call");
      screenFlag.value = navigationScreenFlag;
      // preLoadDataFunction(vehicleId: userVehicleId);
    }
    vehicleIdFlag.value = userVehicleId;
  }

  void updateProgress() {
    progress.value = (currentStep.value + 1) / vehicleModel.value.apiresponse!.data!.length; // Update progress based on the current step
  }

  RxMap preLoadDataResponse = {}.obs;

  void clearAll() {
    selectedAnswers.value.clear();
    selectedResponseList.clear();
    currentStep.value = 0;
    pageController.jumpToPage(0);
    progress.value = 0.1;
  }

  Future<void> getAllVehiclesQue() async {
    handleLoading(true);
    isLoading.value = true;
    await processApi(
      () => VehicleInformationService.getVehicleInformation(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        if (data.apiresponse!.data?.isEmpty != true) {
          vehicleModel.value = data;
          log("vehicle ${vehicleModel.value.apiresponse?.data?.length.toString()}");
          isResponseData.value = true;
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
    isPreLoadDataBool.value = true;
    await processApi(
      () => VehicleInformationService.getAnsByVehicleId(vehicleId: vehicleId),
      error: (error, stack) {
        log("preLoadDataFunction===>onTAP yes error $error");
        handleLoading(false);
      },
      result: (data) {
        selectedResponseList.value = [];
        log("preLoadDataFunction===>onTAP yes success Res::${data.toJson()}");
        log("11111111111");
        for (var key in data.apiresponse?.data?.qaVehicleResponses ?? []) {
          log("222222222222 ${vehicleModel.value.apiresponse?.data?.length}");
          int totleLength = vehicleModel.value.apiresponse?.data?.length ?? 0;
          for (int i = 0; i < totleLength; i++) {
            log("333333333333");
            if (key.question == vehicleModel.value.apiresponse?.data?[i].key) {
              log("4444444444");
              print("compere both data for pre load data ${key.question}----$i");
              selectedResponseList.value.add(SelectedQnsAnsModel(question: key.question, answer: key.answer));
              selectedAnswers.value[i] = key.answer ?? ""; // Store answer by index
              break;
            }
          }
        }
        log(" preLoadDataFunction final response:::${selectedResponseList.value}");
        isPreLoadDataBool.value = false;
      },
    );
  }

  Future submitForm({required int vehicleId, required List<SelectedQnsAnsModel> selectedResponse}) async {
    print("selectedResponse $selectedResponse");
    final body = {
      "qaVehicleRequests": selectedResponse,
      "vehicleId": vehicleId,
    };
    handleLoading(true);
    log("bodybody ${body}");
    await processApi(
      () => VehicleInformationService.submitVehicleRequest(body),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        log("data::: ${data.toJson()}");
        log("data::: ${AppPreference.getInt("UserId")}");
        // Get.offAll(HomeScreen());
        Get.offAll(ChatScreen(
          vehicleId: vehicleIdFlag.value,
          userId: AppPreference.getInt("UserId"),
          screenFlag: "",
        ));

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
    await processApi(
      () => VehicleInformationService.editVehicleRequest(body),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        log("data::: ${data.toJson()}");
        // Get.offAll(HomeScreen());
        Get.offAll(ChatScreen(
          vehicleId: vehicleIdFlag.value,
          userId: AppPreference.getInt("UserId"),
          screenFlag: "",
        ));
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
