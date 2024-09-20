import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/dashboad/home/service/home_service.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:get/get.dart';

import '../models/get_vehicle_data_model.dart';

class HomeController extends GetxController with LoadingMixin, LoadingApiMixin {

  Rx<GetVehicleDataModel> vehicleModel = GetVehicleDataModel().obs;
  RxList<Vehicle> getAllVehicleList = <Vehicle>[].obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
       getAllVehicles();
      },
    );
    super.onInit();
  }


  Future<void> getAllVehicles() async {
    handleLoading(true);
    processApi(
      () => HomeService.getAllVehicle(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        vehicleModel.value = data;
        getAllVehicleList.addAll(data.apiresponse?.data?.vehicle ?? []);
        log("getAllVehicleList :: ${getAllVehicleList.toJson()}");
        log("vehicle data :: ${data.apiresponse?.data}");
        log("vehicle :: ${vehicleModel.value.apiresponse?.data?.vehicle?.length}");
      },
    );
    handleLoading(false);
  }
}
