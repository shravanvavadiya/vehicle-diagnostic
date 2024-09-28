import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../modules/add_vehicle_information/models/submit_vehicle_request.dart';
import '../modules/add_vehicle_information/models/vehicle_information_step_model.dart';
import '../modules/add_vehicle_information/services/vehicle_information_service.dart';
import '../utils/common_api_caller.dart';
import '../utils/loading_mixin.dart';

class QuestionAndAnsController extends GetxController with LoadingMixin, LoadingApiMixin {
  PageController pageController = PageController();
  RxInt currentStep = 0.obs;
  Map<int, String> selectedAnswers = {}; // Store the selected answers by index
  RxDouble progress = 0.1.obs;
  RxBool isLoading = false.obs;
  RxBool isResponseData = false.obs;
  Rx<VehicleInformationModel> vehicleModel = VehicleInformationModel().obs;
  List<Map<String, dynamic>> selectedResponse = <Map<String, dynamic>>[];

  void updateProgress() {
    progress.value = (currentStep.value + 1) / vehicleModel.value.apiresponse!.data!.length; // Update progress based on the current step
  }

  void clearAll() {
    selectedAnswers.clear();
    selectedResponse.clear();
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
          /*preSelectedAnswers["apiresponse"]["data"]["question"].forEach((key, value) {
            print("key selected ${key}");
            int index = vehicleModel.value.apiresponse!.data!.indexWhere((element) => element.key == key);
            if (index != -1) {
              selectedAnswers[index] = value;
              selectedResponse[key] = value;
            }
          });*/
        } else {
          isResponseData.value = false;
        }
      },
    );
    isLoading.value = false;
    handleLoading(false);
  }

  Future submitForm({required int vehicleId, required List<Map<String, dynamic>> selectedResponse}) async {
    print("selectedResponse $selectedResponse");
    final body = {
      // "qaVehicleRequests": [
      //   {"question": "string", "answer": "string"}
      // ],
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

  Future<VehicleQuestionAndAns?> EditForm({required int vehicleId, required List<Map<String, dynamic>> selectedResponse}) async {
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

  final Map<String, dynamic> preSelectedAnswers = {
    "apiresponse": {
      "dataArray": null,
      "data": [
        {
          "creationDate": 1726744065932,
          "lastModifiedDate": 1726744065932,
          "id": 1,
          "question": "What is the main symptom or issue you're experiencing?",
          "answers": [
            "The engine won’t start",
            "The car makes strange noises (e.g., knocking, squealing)",
            "The car vibrates or shakes while driving",
            "A warning light is on (e.g., check engine, ABS)",
            "The car struggles to accelerate or loses power",
            "Other (allow free text)"
          ],
          "key": "Issue"
        },
        {
          "creationDate": 1726744171683,
          "lastModifiedDate": 1726744171683,
          "id": 2,
          "question": "When did you first notice the issue?",
          "answers": ["Today", "A few days ago", "A few weeks ago", "Over a month ago"],
          "key": "Notice The Issue"
        },
        {
          "creationDate": 1726744985737,
          "lastModifiedDate": 1726744985737,
          "id": 3,
          "question": "How often does the issue occur?",
          "answers": ["Every time I use the car", "Only sometimes", "It only happened once", "Not sure"],
          "key": "Issue occur"
        },
        {
          "creationDate": 1726745046330,
          "lastModifiedDate": 1726745046330,
          "id": 4,
          "question": "When does the problem typically happen?",
          "answers": [
            "When starting the car",
            "While driving (e.g., accelerating or turning)",
            "When slowing down or braking",
            "Randomly",
            "Not sure"
          ],
          "key": "Typically happen"
        },
        {
          "creationDate": 1726745129685,
          "lastModifiedDate": 1726745129685,
          "id": 5,
          "question": "Where do you notice the problem the most?",
          "answers": [
            "Around the engine or under the hood",
            "From the wheels or brakes",
            "Inside the car (e.g., dashboard or steering)",
            "Underneath the car (e.g., fluid leak, exhaust)",
            "Not sure"
          ],
          "key": "Most problem"
        },
        {
          "creationDate": 1726745183051,
          "lastModifiedDate": 1726745183051,
          "id": 6,
          "question": "Have you noticed any unusual smells or fluids leaking from the car?",
          "answers": [
            "Yes, there’s a strange smell (e.g., burning, gasoline)",
            "Yes, I see fluid leaking under the car",
            "No, nothing unusual",
            "Not sure"
          ],
          "key": "Unusual smells"
        },
        {
          "creationDate": 1726745254953,
          "lastModifiedDate": 1726745254953,
          "id": 7,
          "question": "Is there a specific sound the car is making?",
          "answers": ["Knocking or rattling", "Squealing or grinding", "Clicking or ticking", "No unusual sounds", "Not sure"],
          "key": "Specific sound"
        },
        {
          "creationDate": 1726745373589,
          "lastModifiedDate": 1726745373589,
          "id": 8,
          "question": "Have any warning lights appeared on the dashboard?",
          "answers": [
            "Yes, a 'check engine' light",
            "Yes, a brake or ABS light",
            "Yes, a battery or charging system light",
            "No, no warning lights",
            "Not sure"
          ],
          "key": "Warning lights"
        },
        {
          "creationDate": 1726745497861,
          "lastModifiedDate": 1726745497861,
          "id": 9,
          "question": "What type of driving do you mostly do?",
          "answers": ["City driving (stop-and-go traffic)", "Highway driving", "A mix of both", "Other (allow free text)"],
          "key": "Mostly driving"
        },
        {
          "creationDate": 1726745568945,
          "lastModifiedDate": 1726745568945,
          "id": 10,
          "question": "Has the weather or temperature been unusual when the problem happens?",
          "answers": ["Yes, it's been very cold", "Yes, it's been very hot", "No, weather has been normal", "Not sure"],
          "key": "Weather or temperature problem"
        },
        {
          "creationDate": 1726745630201,
          "lastModifiedDate": 1726745630201,
          "id": 11,
          "question": "Has the vehicle been serviced or repaired recently?",
          "answers": ["Yes, in the last month", "Yes, in the last 6 months", "No, not recently", "Not sure"],
          "key": "Repaired recently"
        },
        {
          "creationDate": 1726745676222,
          "lastModifiedDate": 1726745676222,
          "id": 12,
          "question": "What is the current mileage of the vehicle?",
          "answers": ["Less than 50,000 miles", "50,000 - 100,000 miles", "100,000 - 150,000 miles", "150,000+ miles"],
          "key": "Current mileage"
        }
      ],
      "timestamp": 1727506354146
    }
  };
}
