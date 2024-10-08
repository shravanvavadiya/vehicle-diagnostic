import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';
import 'package:get/get.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../widget/annotated_region.dart';
import '../controller/question_ans_controller.dart';
import 'question_answer.dart';

class VehicleDiagnosisScreen extends StatefulWidget {
  final String screenName;
  final int vehicleId;

  VehicleDiagnosisScreen(
      {super.key, required this.screenName, required this.vehicleId});

  @override
  State<VehicleDiagnosisScreen> createState() => _VehicleDiagnosisScreenState();
}

class _VehicleDiagnosisScreenState extends State<VehicleDiagnosisScreen> {
  @override
  Widget build(BuildContext context) {
    log('token  :: ${SharedPreferencesHelper.instance.getLogInUser()}');
    log(widget.screenName);
    final QuestionAndAnsController questionAndAnsController =
        Get.put(QuestionAndAnsController());

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
                height: 1.5,
                bottom: MediaQuery.of(context).size.height * 0.15,
                isStart: true,
                yesOnTap: () async {
                  questionAndAnsController.getAllVehiclesQue();
                  log("preLoadDataFunction===>onTAP yes screenName::${widget.screenName}");
                  if (widget.screenName == AppString.editScreenFlag) {
                    log("preLoadDataFunction===>onTAP yes IN IF screenName::${widget.screenName}");
                    await questionAndAnsController.preLoadDataFunction(
                        vehicleId: widget.vehicleId);
                    setState(() {});
                  }
                  await Get.to(
                    QuestionAndAnsScreen(
                        screenName: widget.screenName,
                        vehicleId: widget.vehicleId),
                  );
                  setState(() {});
                },
                noOnTap: () {
                  widget.screenName == AppString.editScreenFlag
                      ? Get.offAll(HomeScreen())
                      : Get.offAll(HomeScreen());
                }),
          ),
        ),
      ),
    );
  }
}
