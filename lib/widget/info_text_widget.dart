import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:get/get.dart';

class InfoTextWidget extends StatelessWidget {
  const InfoTextWidget(
      {super.key,
      required this.title,
      this.description,
      this.titleFontWeight,
      this.titleFontSize,
      this.fontWeight,
      this.fontSize,
      this.bottomSpace});

  final String title;
  final String? description;
  final FontWeight? titleFontWeight;
  final double? titleFontSize;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? bottomSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontWeight: titleFontWeight,
          color: AppColors.primaryColor,
          fontSize: titleFontSize,
        ).paddingOnly(
          bottom: bottomSpace??8.h,
          top: 24.h,
        ),
        AppText(
          text: description ?? "",
          textAlign: TextAlign.start,
          fontSize: fontSize,
          letterSpacing: 0.4,
          fontWeight: fontWeight,
          color: AppColors.secondaryColor,
        ),
      ],
    );
  }
}
