import 'package:flutter_template/modules/authentication/presentation/sign_in_screen.dart';
import 'package:flutter_template/modules/authentication/presentation/sign_up_screen.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/modules/dashboad/vehicle_details/presentation/vehicle_details_screen.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/modules/personal_information_view/personal_information_screen.dart';
import 'package:flutter_template/modules/profile/presentation/profile_screen.dart';
import 'package:flutter_template/modules/subscriptions/presentation/subscriptions_summery_screen.dart';
import 'package:flutter_template/modules/vehicle_details_view/add_vehicle_screen.dart';
import 'package:flutter_template/modules/vehicle_details_view/add_vehicle_details_screen.dart';
import 'package:flutter_template/modules/splash/presentation/splash_screen.dart';
import 'package:get/get.dart';
import '../../modules/add_vehicle_information/presentation/vehicle_diagnosis_screen.dart';
import '../../modules/add_vehicle_information/presentation/vehicle_information_steps_screen.dart';
import '../../modules/profile/presentation/account_information_screen.dart';
import '../../modules/subscriptions/presentation/subscriptions_plan_screen.dart';

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
  static const String addVehicleDetail = '/addVehicleDetail';
  static const String vehicleDiagnosisScreen = '/vehicleDiagnosisScreen';
  static const String vehicleInformationStepsScreen = '/vehicleInformationStepsScreen';
  static const String accountInformation = '/accountInformation';
  static const String profileScreen = '/profileScreen';
  static const String vehicleDetailScreen = '/vehicleDetailScreen';
  static const String subscriptionsSummeryScreen = '/subscriptionsSummeryScreen';
  static const String subscriptionsPlanScreen = '/subscriptionsPlanScreen';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signIn,
      page: () => SignInScreen(),
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
      page: () => const AddVehicleScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: addVehicleDetail,
      page: () => const AddVehicleDetailsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: homeScreen,
      page: () =>  HomeScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: vehicleDiagnosisScreen,
      page: () => const VehicleDiagnosisScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: vehicleInformationStepsScreen,
      page: () => VehicleInformationStepsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: accountInformation,
      page: () => AccountInformationScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: profileScreen,
      page: () => ProfileScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: vehicleDetailScreen,
      page: () =>  VehicleDetailScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: subscriptionsSummeryScreen,
      page: () =>  const SubscriptionsSummeryScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: subscriptionsPlanScreen,
      page: () =>  const SubscriptionsPlanScreen(),
      transition: defaultTransition,
    ),
  ];
}
