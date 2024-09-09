import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
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
  final VoidCallback? onTap;

  const LetsStartWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.isStart,
    required this.bottom,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 30.h,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              ImagesAsset.appTitle,
              height: 36.h,
            ),
          ),
          Image.asset(
            image,
            height: 256.h,
          ).paddingOnly(top: 68.h, bottom: bottom),
          Column(
            children: [
              InfoTextWidget(
                title: title,
                titleFontSize: 32.sp,
                titleFontWeight: FontWeight.w500,
                description: description,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ).paddingOnly(bottom: 32.h),
              isStart == true
                  ? Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            text: "No",
                            textColor: AppColors.highlightedColor,
                            needBorderColor: true,
                            buttonBorderColor: AppColors.highlightedColor,
                            buttonColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomButton(
                            onTap: () {},
                            text: "Yes",
                          ),
                        ),
                      ],
                    )
                  : CustomButton(
                      onTap: onTap,
                      text: buttonText,
                    )
            ],
          ).paddingSymmetric(horizontal: 16.w),
        ],
      ),
    );
  }
}
