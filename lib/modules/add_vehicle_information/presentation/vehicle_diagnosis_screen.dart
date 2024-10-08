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

class VehicleDiagnosisScreen extends StatefulWidget {
  final String screenName;
  final int vehicleId;

  VehicleDiagnosisScreen({super.key, required this.screenName, required this.vehicleId});

  @override
  State<VehicleDiagnosisScreen> createState() => _VehicleDiagnosisScreenState();
}

class _VehicleDiagnosisScreenState extends State<VehicleDiagnosisScreen> {
  @override
  Widget build(BuildContext context) {
    log('token  :: ${SharedPreferencesHelper.instance.getLogInUser()}');
    log(widget.screenName);
    final QuestionAndAnsController questionAndAnsController =
        Get.put(QuestionAndAnsController(navigationScreenFlag: widget.screenName, userVehicleId: widget.vehicleId));

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
                  await questionAndAnsController.getAllVehiclesQue();
                  log("preLoadDataFunction===>onTAP yes screenName::${widget.screenName} ${questionAndAnsController.vehicleModel.value.apiresponse?.data?.length}");
                  if (widget.screenName == AppString.editScreenFlag) {
                    log("preLoadDataFunction===>onTAP yes IN IF screenName::${widget.screenName}");
                    await questionAndAnsController.preLoadDataFunction(vehicleId: widget.vehicleId);
                    setState(() {});
                  }
                  await Get.to(
                    QuestionAndAnsScreen(screenName: widget.screenName, vehicleId: widget.vehicleId),
                  );
                  setState(() {});
                },
                noOnTap: () {
                  widget.screenName == AppString.editScreenFlag ? Get.offAll(HomeScreen()) : Get.offAll(HomeScreen());
                }),
          ),
        ),
      ),
    );
  }
}
