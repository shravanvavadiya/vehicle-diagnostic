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

  //RxBool isAnyOptionSelected = false.obs;
  RxList<QueData> getAllVehicleQueList = <QueData>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedAnswer = "".obs;

  //RxList<Map<String, dynamic>> questionAnswerPairs = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> questionAnswerPair =
      <Map<String, dynamic>>[].obs;
  RxList<bool> isAnyOptionSelected = <bool>[].obs;
  RxInt currentIndex = 0.obs;

  void initializeFormStates(int numberOfForms) {
    isAnyOptionSelected.value = List.generate(numberOfForms, (index) => false);
  }

  void updateSelectedAnswers(
      {required String question, required String answer}) {
    int existingIndex = questionAnswerPair
        .indexWhere((element) => element['question'] == question);
    if (existingIndex >= 0) {
      questionAnswerPair[existingIndex]['answer'] = answer;
      log("$questionAnswerPair");
    } else {
      questionAnswerPair.add({
        'question': question,
        'answers': answer,
      });
    }
    //   isAnyOptionSelected.value = answer.isNotEmpty;
  }

  bool checkFormFilledUp({required String answer}) {
    bool isAnswerSelected = false;
    if (currentIndex.value >= 0) {
      isAnswerSelected =
          questionAnswerPair[currentIndex.value]['answer'] ==answer;

    }
    log("currentIndex ::${currentIndex}");
    log("isAnswerSelected :::${isAnswerSelected}");

    return isAnswerSelected;
  }

  /* bool checkFormFilledUp() {
    int index = questionAnswerPair.indexWhere((e) {
      return e['answer'] == null && e['answer'] == "";
    });

    return index == -1.obs;
  }
*/

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
        getAllVehicleQueList.clear();
        vehicleModel.value = data;
        getAllVehicleQueList.addAll(data.apiresponse?.data ?? []);
        for (QueData question in getAllVehicleQueList) {
          questionAnswerPair.add({
            "answer": "",
            "question": question.key,
          });
        }
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
      "qaVehicleRequests": questionAnswerPair,
      "vehicleId": vehicleId,
    };
    log("body :: ${body.entries}");
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
