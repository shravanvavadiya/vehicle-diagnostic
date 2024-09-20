
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:get/get.dart';

import '../models/vehicle_information_step_model.dart';
import '../services/vehicle_information_service.dart';

class AddVehicleInformationController extends GetxController with LoadingMixin, LoadingApiMixin {

  Rx<VehicleInformationModel> vehicleModel = VehicleInformationModel().obs;
  RxList<QueData> getAllVehicleQueList = <QueData>[].obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            getAllVehiclesQue();
      },
    );
    super.onInit();
  }


  Future<void> getAllVehiclesQue() async {
    handleLoading(true);
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
    handleLoading(false);
  }
}

