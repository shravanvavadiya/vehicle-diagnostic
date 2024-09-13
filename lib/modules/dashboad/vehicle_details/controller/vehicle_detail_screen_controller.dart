import 'package:flutter_template/utils/app_string.dart';
import 'package:get/get.dart';

class VehicleDetailScreenController extends GetxController {
  RxBool idDisplayErrorBox =false.obs;

  List<Map<String, dynamic>> vehicleDetailsList = [
    {
      "title": AppString.vehicleNumber,
      "subTitle": "VU69 YDE",
    },
    {
      "title": AppString.vehicleYear,
      "subTitle": "2023",
    },
    {
      "title": AppString.vehicleMake,
      "subTitle": "ROVER",
    },
    {
      "title": AppString.vehicleModel,
      "subTitle": "BMW",
    },
    {
      "title": AppString.transmissionType,
      "subTitle": "Car",
    },
    {
      "title": AppString.fuelType,
      "subTitle": "Petrol",
    }
  ];
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
}
