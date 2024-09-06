import 'package:flutter_template/modules/authentication/presentation/sign_in_screen.dart';
import 'package:flutter_template/modules/authentication/presentation/sign_up_screen.dart';
import 'package:flutter_template/modules/dashboad/home/home_screen.dart';
import 'package:flutter_template/splash_screen.dart';
import 'package:get/get.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  // get started
  static const String splash = '/splash';
  static const String homeScreen = '/home';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signIn,
      page: () => const SignInScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signUp,
      page: () => const SignUpScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: homeScreen,
      page: () => const HomeScreen(),
      transition: defaultTransition,
    ),
  ];
}
