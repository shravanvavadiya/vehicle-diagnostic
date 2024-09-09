import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VehicleDetailController extends GetxController {
  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController vehicleYear = TextEditingController();
  XFile? imagePath;
  RxString image = "".obs;

  var selectedValue = ValueNotifier<String>("Select");
  final List<String> genderItems = ["male", "female"];
}
