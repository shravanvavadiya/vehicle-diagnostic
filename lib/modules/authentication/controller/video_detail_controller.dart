import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VehicleDetailController extends GetxController {
  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController vehicleYear = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? imagePath;
  RxString image = "".obs;

  RxString selectedValueMake = 'Select'.obs;
  RxString selectedValueModel = 'Select'.obs;
  RxString selectedValueTType = 'Select'.obs;
  RxString selectedValueFType = 'Select'.obs;

  RxBool isValidateVName = false.obs;
  RxBool isValidateVYear = false.obs;
  RxBool isValidateVMake = false.obs;
  RxBool isValidateVModel = false.obs;
  RxBool isValidateVType = false.obs;
  RxBool isValidateVFuelT = false.obs;
  RxBool isValidateImage = false.obs;


  clearController(){
    vehicleNumber.clear();
    vehicleYear.clear();
    selectedValueMake.value = 'Select';
    selectedValueModel.value = 'Select';
    selectedValueTType.value = 'Select';
    selectedValueFType.value = 'Select';
  }

/*  var selectedValueMake = ValueNotifier<String>("Select");
  var selectedValueModel = ValueNotifier<String>("Select");
  var selectedValueTType = ValueNotifier<String>("Select");
  var selectedValueFType = ValueNotifier<String>("Select");*/
  final List<String> vehicleMake = [
    'BMW',
    'Mercedes-Benz',
    'Volkswagen',
    'Hyundai',
    'Kia',
    'Audi',
  ];
  final List<String> vehicleModel = [
    "840i",
    "850i",
    "M850i",
    "M8",
  ];
  final List<String> vehicleType = [
    'Sedan',
    'Coupe',
    'Hatchback',
    'SUV',
    'Crossover',
  ];
  final List<String> transmissionType = [
    'Automatic',
    'Manual',
    'Semi-Automatic',
    'CVT',
    'Dual-Clutch',
  ];
  final List<String> fuelType = [
    'Petrol',
    'Diesel',
    'Electric',
    'Hybrid',
  ];
}
