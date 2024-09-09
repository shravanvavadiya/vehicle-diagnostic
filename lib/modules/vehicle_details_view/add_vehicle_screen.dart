import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LetsStartWidget(
      image: ImagesAsset.addVehicle,
      title: "Yey! ”Jerry” now that we know you, lets get your vehicle details.",
      description: "Hello [firstname]! Now we know more about you, tell me about your vehicle(s)",
      buttonText: AppString.addVehicleDetails,
      bottom: 50.h,
      onTap: () {
        Navigation.pushNamed(Routes.vehicleDetail);
      },
    );
  }
}
