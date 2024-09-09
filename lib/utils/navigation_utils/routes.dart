import 'package:flutter_template/modules/authentication/presentation/sign_in_screen.dart';
import 'package:flutter_template/modules/authentication/presentation/sign_up_screen.dart';
import 'package:flutter_template/modules/dashboad/home/home_screen.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/modules/personal_information_view/personal_information_screen.dart';
import 'package:flutter_template/modules/vehicle_details_view/add_vehicle_screen.dart';
import 'package:flutter_template/modules/vehicle_details_view/vehicle_details_screen.dart';
import 'package:flutter_template/splash_screen.dart';
import 'package:get/get.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  // get started
  static const String splash = '/splash';
  static const String homeScreen = '/home';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String getStarted = '/getStarted';
  static const String personalInformation = '/personalInformation';
  static const String addVehicle = '/addVehicle';
  static const String vehicleDetail = '/vehicleDetail';

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
      name: getStarted,
      page: () => const GetStartedScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: personalInformation,
      page: () => PersonalInformationScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: addVehicle,
      page: () => AddVehicleScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: vehicleDetail,
      page: () => VehicleDetailsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: homeScreen,
      page: () => const HomeScreen(),
      transition: defaultTransition,
    ),
  ];
}
