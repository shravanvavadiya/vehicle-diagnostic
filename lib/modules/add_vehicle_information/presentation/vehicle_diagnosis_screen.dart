import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/modules/add_vehicle_information/presentation/vehicle_information_steps_screen.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../demo/question_ans_controller.dart';
import '../../../demo/question_answer.dart';
import '../../../widget/annotated_region.dart';
import '../controller/add_vehicle_information_controller.dart';

class VehicleDiagnosisScreen extends StatelessWidget {
  final String screenName;
  final int vehicleId;

  VehicleDiagnosisScreen({super.key, required this.screenName, required this.vehicleId});

  final AddVehicleInformationController addVehicleQueController = Get.put(AddVehicleInformationController());
  final QuestionAndAnsController questionAndAnsController = Get.put(QuestionAndAnsController());

  @override
  Widget build(BuildContext context) {
    log('token  :: ${SharedPreferencesHelper.instance.getLogInUser()}');

    return Scaffold(
      body: SafeArea(
        child: CustomAnnotatedRegions(
          child: Scaffold(
            body: LetsStartWidget(
                image: ImagesAsset.addVehicle,
                title: AppString.letsStartTheDiagnosis,
                description: AppString.letsStartTheDiagnosisDes,
                buttonText: AppString.addVehicleDetails,
                //bottom: 100.h,
                bottom: MediaQuery.of(context).size.height * 0.12,
                isStart: true,
                yesOnTap: () {
                  addVehicleQueController.getAllVehiclesQue();
                  questionAndAnsController.getAllVehiclesQue();
                  addVehicleQueController.removeSelectedAnswers();
                  // Navigation.pushNamed(Routes.accountInformation);
                  // Navigation.pushNamed(Routes.vehicleInformationStepsScreen,arg: vehicleId);
                  Get.to(
                      QuestionAndAnsScreen(
                        screenName: "Edit Screen",
                          vehicleId :vehicleId
                      ),
                      );
                  /*Get.to(
                      const VehicleInformationStepsScreen(
                        screenName: "Edit Screen",
                      ),
                      arguments: vehicleId);*/
                },
                noOnTap: () {
                  screenName == "Vehicle Information Add" ? Get.back() : Get.offAll(HomeScreen());
                }),
          ),
        ),
      ),
    );
  }
}
