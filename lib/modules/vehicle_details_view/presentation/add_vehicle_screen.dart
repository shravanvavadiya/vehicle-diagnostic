import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/vehicle_details_view/presentation/add_vehicle_details_screen.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends StatelessWidget {
  final String userName;

  const AddVehicleScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
      child: Scaffold(
        body: SafeArea(
          child: LetsStartWidget(
            image: ImagesAsset.addVehicle,
            title: "Yey! ”$userName” now that we know you, lets get your vehicle details.",
            description: "Hello [firstname]! Now we know more about you, tell me about your vehicle(s)",
            buttonText: AppString.addVehicleDetails,
            bottom: 40.h,
            onTap: () {
              // Navigation.pushNamed(Routes.addVehicleDetail);
              Get.to(const AddVehicleDetailsScreen(
                screenName: AppString.newVehicleAddFlag,
              ));
            },
          ),
        ),
      ),
    );
  }
}
