import 'package:flutter/material.dart';
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
      navigateFurther(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      key: ValueKey("Container"),
      width: double.maxFinite,
      child: Center(
        child: Text(
          'Splash screen ',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Future<void> navigateFurther(BuildContext context) async {
    Navigation.replace(Routes.signIn);
  }
}
