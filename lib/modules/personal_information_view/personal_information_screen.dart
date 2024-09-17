import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/modules/personal_information_view/controller/personal_information_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_backarrow_widget.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/custom_textfeild.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';

import '../../utils/navigation_utils/navigation.dart';
import '../../utils/navigation_utils/routes.dart';
import '../../utils/validation_utils.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({super.key});

  final PersonalInformationController personalInformationController =
      Get.put(PersonalInformationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(0, 45.h),
            child: AppBar(
              leading: const CustomBackArrowWidget().paddingAll(6.r),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: personalInformationController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoTextWidget(
                    title: AppString.mayIInquireAboutYourName,
                    titleFontSize: 24.sp,
                    titleFontWeight: FontWeight.w600,
                    description: AppString.iLoveToKnowWhatToCallYou,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  customTextFormField(
                    onChanged: (p0) {
                      personalInformationController.isValidateName.value=personalInformationController.firstname.text.isNotEmpty;
                    },
                    text: AppString.firstName,
                    hintText: AppString.firstName,
                    validator: AppValidation.nameValidator,
                    controller: personalInformationController.firstname,
                  ).paddingOnly(top: 24.h, bottom: 16.h),
                  customTextFormField(
                    onChanged: (p0) {
                      personalInformationController.isValidateLastName.value=personalInformationController.lastname.text.isNotEmpty;
                    },
                    text: AppString.lastName,
                    hintText: AppString.lastName,
                    validator: AppValidation.lastNameValidator,
                    controller: personalInformationController.lastname,
                  ),
                  customTextFormField(

                    onChanged: (p0) {
                      personalInformationController.isValidateEmail.value=personalInformationController.email.text.isNotEmpty;
                    },
                    text: AppString.email,
                    hintText: AppString.emailEx,
                    controller: personalInformationController.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidation.emailValidator,
                  ).paddingSymmetric(vertical: 16.h),
                  customTextFormField(
                    onChanged: (p0) {
                      personalInformationController.isValidatePostCode.value=personalInformationController.postCode.text.isNotEmpty;
                    },
                    text: AppString.postCode,
                    keyboardType: TextInputType.number,
                    hintText: AppString.postCode,
                    validator: AppValidation.postCode,
                    controller: personalInformationController.postCode,
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
          floatingActionButton: Obx(
            () => CustomButton(
              onTap: () async {
                if (personalInformationController.formKey.currentState
                        ?.validate() ??
                    false) {
                  Navigation.pushNamed(Routes.addVehicle);
                }
              },
              isDisabled: (personalInformationController.isValidateName.value &&
                      personalInformationController.isValidateLastName.value &&
                      personalInformationController.isValidateEmail.value &&
                      personalInformationController.isValidatePostCode.value)
                  ? false
                  : true,
              /*  (){
                personalInformationController.nextBtn();
              },*/
              /* personalInformationController.isButtonEnabled.value
                  ? () {

                    }
                  : null,*/
              buttonColor: AppColors.highlightedColor,
              disableTextColor: AppColors.whiteColor,
              height: 52.h,
              width: 113.w,
              endSvgHeight: 16.h,
              fontSize: 15.h,
              endSvg: IconAsset.forwardArrow,
              text: AppString.next,
              borderRadius: BorderRadius.circular(46),
            ).paddingOnly(bottom: 25.h),
          ),
        ),
      ),
    );
  }
}

Widget customTextFormField({
  String? Function(String?)? validator,
  required String text,
  required String hintText,
  required Function(String)? onChanged,
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
         onChanged: onChanged,
        controller: controller,
        hintText: hintText,
        validator: validator,
        keyboardType: keyboardType,
      ),
    ],
  );
}
