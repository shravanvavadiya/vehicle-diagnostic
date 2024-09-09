import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static void hideKeyboardInApp(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static Future<XFile?> imagePicker({required ImageSource source}) async {
    try {
      if (Platform.isIOS) {
        var permissionStatus = await Permission.camera.request();
      }
      final ImagePicker picker = ImagePicker();
      XFile? photo = await picker.pickImage(source: source);
      return photo;
    } catch (e) {
      if (e.toString().contains("camera_access_denied")) {
        await openAppSettings();
      }
    }
    return null;
  }

  Future<void> imagePickerModel({XFile? selectImage, RxString? image}) {
    return showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Choose from Gallery',
              style: TextStyle(color: AppColors.blackColor, fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
            onPressed: () async {
              Get.back();
              selectImage = await Utils.imagePicker(source: ImageSource.gallery);
              if (selectImage?.path.isNotEmpty ?? false) {
                image?.value = selectImage?.path ?? "";
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Choose from Camera',
              style: TextStyle(color: AppColors.blackColor, fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
            onPressed: () async {
              Get.back();
              selectImage = await Utils.imagePicker(source: ImageSource.camera);
              if (selectImage?.path.isNotEmpty ?? false) {
                image?.value = selectImage?.path ?? "";
              }
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: AppColors.textColor, fontSize: 18.sp, fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
