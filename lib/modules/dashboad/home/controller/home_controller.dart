import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_template/modules/dashboad/home/service/home_service.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../utils/app_string.dart';
import '../../../../utils/navigation_utils/navigation.dart';
import '../../../../utils/navigation_utils/routes.dart';
import '../models/get_vehicle_data_model.dart';
import '../presentation/home_screen.dart';

class HomeController extends GetxController with LoadingMixin, LoadingApiMixin {
  Rx<GetVehicleDataModel> vehicleModel = GetVehicleDataModel().obs;
  GetVehicleDataModel? getAllVehicleList;

  RxBool isLoading = false.obs;
  RxBool isResponseData = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool paginationLoading = true.obs;
  RxBool hasMoreData = true.obs;
  RxInt currentPage = 1.obs;
  RxBool idDisplayErrorBox = false.obs;

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Tap back again to leave");
      // AppSnackBar();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void onInit() {
    print("refresh data");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("refresh data 1 ");
      getAllVehicles(currentPage: currentPage.value);
      scrollController.addListener(() {
        if (((scrollController.position.maxScrollExtent) == scrollController.position.pixels) &&
            // paginationLoading.isFalse &&
            hasMoreData.value &&
            getAllVehicleList != null) {
          paginationLoading.value = true;
          currentPage.value++;
          getMoreAllVehicles(currentPage: currentPage.value);
        } else {
          hasMoreData.value == false ? paginationLoading.value = true : paginationLoading.value = false;
        }
      });
    });

    super.onInit();
  }

  Future<void> getAllVehicles({required int currentPage}) async {
    isLoading.value = true;
    handleLoading(true);
    processApi(
      () => HomeService.getAllVehicle(currentPage: currentPage),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        // data.apiresponse!.data!.vehicle!.isNotEmpty
        data.apiresponse?.dataArray == null
            ? {
                isResponseData.value = true,
                vehicleModel.value = data,
                getAllVehicleList = data,
              }
            : {getAllVehicleList!.apiresponse!.data!.vehicle!.isEmpty ? isResponseData.value = true : isResponseData.value = false};
      },
    );
    isLoading.value = false;
    handleLoading(false);
  }

  Future<void> getMoreAllVehicles({required int currentPage}) async {
    try {
      isLoading.value = true;
      paginationLoading.value = false;
      handleLoading(true);
      processApi(
        () => HomeService.getAllVehicle(currentPage: currentPage),
        error: (error, stack) => handleLoading(false),
        result: (data) {
          if (data.apiresponse!.data!.vehicle!.isNotEmpty) {
            print("is not empty data ");
            if (getAllVehicleList != null && data.apiresponse?.data?.vehicle != null) {
              getAllVehicleList!.apiresponse!.data!.vehicle!.addAll(data.apiresponse?.data?.vehicle ?? []);
              paginationLoading.value = true;
            } else {
              getAllVehicleList = data;
              paginationLoading.value = true;
            }
          } else {
            print("is empty data ");
            hasMoreData.value = false;
            paginationLoading.value = true;
          }
        },
      );
      isLoading.value = false;
      handleLoading(false);
    } catch (e) {
      print("e $e");
    } finally {
      paginationLoading.value = true; // End loading state
    }
  }

  Future<void> deleteVehicle({required int vehicleId}) async {
    handleLoading(true);
    await processApi(
      () => HomeService.deleteVehicle(vehicleId: vehicleId),
      error: (error, stack) {
        handleLoading(false);
      },
      result: (data) {
        getAllVehicles(currentPage: currentPage.value);
        Get.offAll(HomeScreen());
        // getAllVehicleList.removeWhere((vehicle) => vehicle.id == vehicleId);
        //Navigator.pop(context);
        log("Vehicle with ID $vehicleId deleted successfully.");
      },
    );
    handleLoading(false);
  }

  @override
  void dispose() {
    // isResponseData.value = false;
    print("dispose Method");
    Get.delete<HomeController>();

    // TODO: implement dispose
    super.dispose();
  }
}
