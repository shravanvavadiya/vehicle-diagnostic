import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void showErrorSnackBar({
    required String message,
    required String title,
  }) {
    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      snackStyle: SnackStyle.FLOATING,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          5.w.verticalSpace,
          GestureDetector(
            onTap: Get.back,
            child: Icon(Icons.close, color: Colors.white, size: 16.sp),
          )
        ],
      ),
      titleText: Container(),
      backgroundColor: title.toLowerCase() == "error"
          ? Colors.redAccent
          : title.toLowerCase() == "success"
              ? Colors.green
              : Colors.black45,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      // isDismissible: false,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 6),
    );
  }
}
