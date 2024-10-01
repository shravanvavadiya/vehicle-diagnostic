import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/personal_information_view/presentation/user_information_screen.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/lets_start_widget.dart';
import 'package:get/get.dart';

class GetStartedScreen extends StatelessWidget {

  const GetStartedScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: CustomAnnotatedRegions(
        child: Scaffold(
          body: SafeArea(
            child: LetsStartWidget(
              image: ImagesAsset.getStarted,
              title: AppString.welcomeFriendLetsGetStartedToKnowYou,
              description: AppString.beforeWeGetStarted,
              buttonText: AppString.letsGetStarted,
              bottom: 60.h,
              onTap: () {
                // Navigation.pushNamed(Routes.personalInformation);
                Get.offAll(const UserInformationScreen());
              },
            ),
          ),
        ),
      ),
    );
  }
}
