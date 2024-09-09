import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/authentication/controller/personal_information_controller.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/widget/custom_backarrow_widget.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/custom_textfeild.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({super.key});

  final PersonalInformationController personalInformationController = Get.put(PersonalInformationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackArrowWidget().paddingOnly(top: 50.h),
            InfoTextWidget(
              title: AppString.mayIInquireAboutYourName,
              titleFontSize: 24.sp,
              titleFontWeight: FontWeight.w600,
              description: AppString.iLoveToKnowWhatToCallYou,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            customTextFormField(
              text: AppString.firstName,
              hintText: AppString.firstName,
              controller: personalInformationController.firstname,
            ).paddingOnly(top: 24.h, bottom: 16.h),
            customTextFormField(
              text: AppString.lastName,
              hintText: AppString.lastName,
              controller: personalInformationController.lastname,
            ),
            customTextFormField(
              text: AppString.email,
              hintText: AppString.emailEx,
              controller: personalInformationController.email,
              keyboardType: TextInputType.emailAddress,
            ).paddingSymmetric(vertical: 16.h),
            customTextFormField(
              text: AppString.postCode,
              hintText: AppString.postCode,
              controller: personalInformationController.postCode,
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: CustomButton(
        onTap: () {
          Navigation.pushNamed(Routes.addVehicle);
        },
        height: 56.h,
        width: 113.w,
        endSvg: IconAsset.forwardArrow,
        text: AppString.next,
        borderRadius: BorderRadius.circular(46),
      ).paddingOnly(bottom: 16.h),
    );
  }
}

Widget customTextFormField({
  required String text,
  required String hintText,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(
        text: text,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ).paddingOnly(bottom: 6.h),
      CustomTextField(
        controller: controller,
        hintText: hintText,
        keyboardType: keyboardType,
      ),
    ],
  );
}
