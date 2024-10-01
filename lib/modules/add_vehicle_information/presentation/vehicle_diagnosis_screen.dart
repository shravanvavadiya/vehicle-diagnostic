import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../controller/question_ans_controller.dart';
import 'question_answer.dart';
import '../../../widget/annotated_region.dart';

class VehicleDiagnosisScreen extends StatelessWidget {
  final String screenName;
  final int vehicleId;

  VehicleDiagnosisScreen({super.key, required this.screenName, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    log('token  :: ${SharedPreferencesHelper.instance.getLogInUser()}');
    log(screenName);
    final QuestionAndAnsController questionAndAnsController = Get.put(QuestionAndAnsController());

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
                yesOnTap: () async {
                  questionAndAnsController.getAllVehiclesQue();
                  log("preLoadDataFunction===>onTAP yes screenName::$screenName");
                  if (screenName == AppString.editScreen) {
                    log("preLoadDataFunction===>onTAP yes IN IF screenName::$screenName");
                    await questionAndAnsController.preLoadDataFunction(vehicleId: vehicleId);
                  }
                  Get.to(
                    QuestionAndAnsScreen(screenName: screenName, vehicleId: vehicleId),
                  );
                },
                noOnTap: () {
                  screenName == AppString.editScreen ? Get.back() : Get.offAll(HomeScreen());
                }),
          ),
        ),
      ),
    );
  }
}
