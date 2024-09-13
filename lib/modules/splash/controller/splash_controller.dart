import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      navigateFurther();
    });
    super.onInit();
  }

  Future<void> navigateFurther() async {
    Navigation.replace(Routes.signIn);
  }

}