import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';

class LetsStartWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final bool? isStart;
  final double bottom;
  final double? height;
  final VoidCallback? onTap;
  final VoidCallback? yesOnTap;
  final VoidCallback? noOnTap;

  const LetsStartWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.isStart,
    required this.bottom,
    this.onTap,
    this.height,
    this.yesOnTap,
    this.noOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 30.h,
      //   backgroundColor: Colors.white,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: Image.asset(
                    ImagesAsset.appTitle,
                    height: 36.h,
                  ),
                ),
                Image.asset(
                  image,
                  height: 256.h,
                ).paddingOnly(
                  top: 45.h,
                  bottom: bottom - 15,
                ),
                InfoTextWidget(
                  title: title,
                  titleFontSize: 32.sp,
                  titleFontWeight: FontWeight.w500,
                  description: description,
                  fontSize: 16.sp,
                  height: height,
                  bottomSpace: 14.h,
                  fontWeight: FontWeight.w400,
                ).paddingOnly(
                  bottom: 0.h,
                  left: 16.w,
                  right: 16.w,
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            isStart == true
                ? Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 50.h,
                          onTap: noOnTap,
                          text: AppString.no,
                          borderWidth: 1.w,
                          textColor: AppColors.primaryColor,
                          needBorderColor: true,
                          buttonBorderColor: AppColors.primaryColor,
                          buttonColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomButton(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          height: 50.h,
                          onTap: yesOnTap,
                          text: AppString.yes,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                    horizontal: 16.w,
                    vertical: 25.h,
                  )
                : CustomButton(
                    height: 50.h,
                    onTap: onTap,
                    text: buttonText,
                  ).paddingSymmetric(
                    horizontal: 16.w,
                    vertical: 25.h,
                  ),
          ],
        ),
      ),
    );
  }
}
