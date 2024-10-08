import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/personal_information_view/presentation/user_information_screen.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';

import '../../widget/custom_button.dart';
import '../../widget/info_text_widget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: CustomAnnotatedRegions(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height*0.17,
                ),
                _buildLogoImage(),
                const Expanded(
                  child: SizedBox(),
                ),
                _buildInfoText(),
                _buildNextButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return CustomButton(
      height: 52.h,
      onTap: () {
        Get.to(const UserInformationScreen());
      },
      text: AppString.letsGetStarted,
    ).paddingSymmetric(
      horizontal: 16.w,
      vertical: 25.h,
    );
  }

  Widget _buildInfoText() {
    return InfoTextWidget(
      title: AppString.welcomeFriendLetsGetStartedToKnowYou,
      titleFontSize: 32.sp,
      titleFontWeight: FontWeight.w500,
      description: AppString.beforeWeGetStarted,
      fontSize: 16.sp,
      bottomSpace: 22.h,
      fontWeight: FontWeight.w400,
    ).paddingOnly(
      bottom: 25.h,
      left: 16.w,
      right: 16.w,
    );
  }

  Widget _buildLogoImage() {
    return Image.asset(
      ImagesAsset.appLogo,
      height: 190.h,
    );
  }
}
