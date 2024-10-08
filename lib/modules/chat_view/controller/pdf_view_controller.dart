import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../api/exception/app_exception.dart';

class PdfViewController extends GetxController {
  RxString screenName = "Vehicle-Report".obs;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  RxBool version = false.obs;
  RxString imagePath = "".obs;

  requestPermission() async {
    if (Platform.isAndroid) {
      // PermissionStatus storageStatus = await Permission.storage.request();

      final plugin = DeviceInfoPlugin();
      final android = await plugin.androidInfo;

      final storageStatus = android.version.sdkInt < 33 ? await Permission.storage.request() : PermissionStatus.granted;
      if (storageStatus == PermissionStatus.granted) {
        print("granted");
        return true;
      }
      if (storageStatus == PermissionStatus.denied) {
        print("denied");
        return false;
      }
      if (storageStatus == PermissionStatus.permanentlyDenied) {
        openAppSettings();
        return false;
      }
    } else {
      return true;
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
        debugPrint("ios : ${directory.path}");
      } else {
        directory = Directory('/storage/emulated/0/Download');
        debugPrint("android : ${directory.path}");

        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
          debugPrint("directory.exists : ${directory!.path}");
        }
      }
    } catch (err) {
      debugPrint("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> downloadPdf({required Uint8List responseData}) async {
    try {
      // Check storage permission
      if (await requestPermission()) {
        // Get the downloads directory
        /*   Directory? directory;
        if (Platform.isAndroid) {
          directory = await getExternalStorageDirectory();
          String newPath = '';
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != 'Android') {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          print("paths ${paths}");
          newPath = '$newPath/Download/VehicleReports';
          print("newPath ${newPath}");
          directory = Directory(newPath);
        } else {
          directory = await getApplicationDocumentsDirectory();
        }

        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }*/
        String filePath = await createSaveFilePath('NEOS-Mobile-${DateTime.now().millisecondsSinceEpoch}.pdf');
        print("filePath::::$filePath");

        final file = File(filePath);
        await file.writeAsBytes(responseData);

        AppSnackBar.showErrorSnackBar(
          message: "File downloaded to ${filePath}",
          title: "success",
        );
      } else {
        print('Permission denied');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<String> createSaveFilePath(String fileName) async {
    try {
      String path;
      String savePath = '';
      Directory directory;

      if (Platform.isAndroid) {
        path = "storage/emulated/0/Download/Vehicle_report";
      } else {
        path = (await getApplicationDocumentsDirectory()).path;
      }
      directory = Directory(path);
      print("directory:: $directory ${await directory.exists()}");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      savePath = '${directory.path}/$fileName';
      if (savePath.isEmpty) {
        throw AppException(message: 'File path not found', errorCode: 400);
      }
      return savePath;
    } catch (e, stack) {
      print('stack: $stack');
      rethrow;
    }
  }
}
