import 'package:flutter/material.dart';
import 'package:flutter_template/modules/splash/controller/splash_controller.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Image.asset(
              ImagesAsset.splash,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
