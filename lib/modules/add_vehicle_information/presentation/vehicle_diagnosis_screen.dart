import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';
import 'package:get/get.dart';

import '../../../api/preferences/shared_preferences_helper.dart';
import '../../../widget/annotated_region.dart';
import '../controller/add_vehicle_information_controller.dart';

class VehicleDiagnosisScreen extends StatelessWidget {
   VehicleDiagnosisScreen({super.key});

  final AddVehicleInformationController addVehicleQueController =
  Get.put(AddVehicleInformationController());

  @override
  Widget build(BuildContext context) {
    log('token  :: ${SharedPreferencesHelper.instance.getUserToken()}');

    return Scaffold(
      body: SafeArea(
        child: CustomAnnotatedRegions(
          child: Scaffold(
            body: LetsStartWidget(
                image: ImagesAsset.addVehicle,
                title: "Let's start the diagnosis!",
                description:
                    "Our AI Mechanic will ask you questions based on your symptoms and use it's vast knowledge to help diagnose, explain and resolve your faults.",
                buttonText: AppString.addVehicleDetails,
                //bottom: 100.h,
                bottom: MediaQuery.of(context).size.height * 0.12,
                isStart: true,
                yesOnTap: () {
                  addVehicleQueController.getAllVehiclesQue();
                  // Navigation.pushNamed(Routes.accountInformation);
                  Navigation.pushNamed(Routes.vehicleInformationStepsScreen);
                },
                noOnTap: () {
                  Navigation.pushNamed(Routes.homeScreen);
                }),
          ),
        ),
      ),
    );
  }
}
