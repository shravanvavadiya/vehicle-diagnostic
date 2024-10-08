import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:get/get.dart';

class CustomBackArrowWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomBackArrowWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap?? (){
        Navigation.pop();
        log("can pop ::");
      },
      child: Container(
        height: 36.h,
        width: 36.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(IconAsset.backArrow).paddingAll(10.h),
      ),
    );
  }
}
