import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_template/modules/dashboad/home/service/home_service.dart';
import 'package:flutter_template/utils/common_api_caller.dart';
import 'package:flutter_template/utils/loading_mixin.dart';
import 'package:get/get.dart';

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

  List<Map<String, dynamic>> vehicleMoreInfo = [
    {
      "title": AppString.issue,
      "subTitle": "The engine won't start",
    },
    {
      "title": AppString.noticeTheIssue,
      "subTitle": "Today",
    },
    {
      "title": AppString.issueOccur,
      "subTitle": "Every Time I Use the car",
    },
    {
      "title": AppString.typicallyHappen,
      "subTitle": "While driving",
    },
    {
      "title": AppString.mostProblem,
      "subTitle": "From the wheels or brakes",
    },
    {
      "title": AppString.unusualSmells,
      "subTitle": "Not sure",
    },
    {
      "title": AppString.specificSound,
      "subTitle": "Knocking or rating",
    },
    {
      "title": AppString.warningLights,
      "subTitle": "Yes,a brake or ABS light",
    },
    {
      "title": AppString.mostlyDriving,
      "subTitle": "Highway",
    },
    {
      "title": AppString.weatherOrTemperatureProblem,
      "subTitle": "Not sure",
    },
    {
      "title": AppString.repairedRecently,
      "subTitle": "Yes,in the last month",
    },
    {
      "title": AppString.currentMileage,
      "subTitle": "50,000-100,000 miles",
    }
  ];

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
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
        data.apiresponse!.data!.vehicle!.isNotEmpty
            ? {
                isResponseData.value = true,
                vehicleModel.value = data,
                getAllVehicleList = data,
              }
            : {isResponseData.value = false};
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
        Navigation.removeAll(HomeScreen());

        // getAllVehicleList.removeWhere((vehicle) => vehicle.id == vehicleId);
        //Navigator.pop(context);
        log("Vehicle with ID $vehicleId deleted successfully.");
      },
    );
    handleLoading(false);
  }
}
