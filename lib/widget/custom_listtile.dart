import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text.dart';


class CustomListTile extends StatelessWidget {
  final String title;
  final String trailingText;
  final EdgeInsetsGeometry? contentPadding;

  const CustomListTile({
    super.key,
    required this.title,
    required this.trailingText,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding ?? EdgeInsets.zero,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: title,
            color: AppColors.secondaryColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(width: 50.w),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: AppText(
                text: trailingText,
                color: AppColors.primaryColor,
                fontSize: 16.sp,
                maxLines: 3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
