import 'package:flutter/material.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';

import 'utils/navigation_utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      navigateFurther();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagesAsset.splash,
      fit: BoxFit.cover,
    );
  }

  Future<void> navigateFurther() async {
    Navigation.replace(Routes.signIn);
  }
}
