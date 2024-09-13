import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';

import '../../../widget/annotated_region.dart';

class VehicleDiagnosisScreen extends StatelessWidget {
  const VehicleDiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // Navigation.pushNamed(Routes.accountInformation);
                  Navigation.pushNamed(Routes.vehicleInformationStepsScreen);
                },
                noOnTap: () {
                  Navigation.pushNamed(Routes.vehicleInformationStepsScreen);
                }),
          ),
        ),
      ),
    );
  }
}
