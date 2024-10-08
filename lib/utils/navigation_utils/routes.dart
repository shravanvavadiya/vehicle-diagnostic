import 'package:flutter_template/modules/authentication/presentation/google_login_screen.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/vehicle_details_screen.dart';
import 'package:flutter_template/modules/personal_information_view/get_started_screen.dart';
import 'package:flutter_template/modules/profile/presentation/profile_screen.dart';
import 'package:flutter_template/modules/splash/presentation/splash_screen.dart';
import 'package:flutter_template/modules/subscriptions/presentation/subscriptions_summery_screen.dart';
import 'package:get/get.dart';
import '../../modules/authentication/presentation/create_new_password_screen.dart';
import '../../modules/authentication/presentation/log_in_with_email_screen.dart';
import '../../modules/profile/presentation/account_information_screen.dart';
import '../../modules/subscriptions/presentation/subscriptions_plan_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  // get started
  static const String questionAndAnsScreenDemo = '/QuestionAndAnsScreenDemo';
  static const String splash = '/splash';
  static const String createNewPasswordScreen = '/CreateNewPasswordScreen';
  static const String demo01 = '/demo01';
  static const String logInWithEmailId = '/logInWithEmailId';
  static const String homeScreen = '/home';
  static const String signIn = '/signIn';
  static const String getStarted = '/getStarted';
  static const String personalInformation = '/personalInformation';
  static const String addVehicle = '/addVehicle';
  static const String addVehicleDetail = '/addVehicleDetail';

  static const String vehicleInformationStepsScreen = '/vehicleInformationStepsScreen';
  static const String accountInformation = '/accountInformation';
  static const String profileScreen = '/profileScreen';
  static const String vehicleDetailScreen = '/vehicleDetailScreen';
  static const String subscriptionsSummeryScreen = '/subscriptionsSummeryScreen';
  static const String subscriptionsPlanScreen = '/subscriptionsPlanScreen';

  static List<GetPage<dynamic>> pages = [
    /*GetPage<dynamic>(
      name: demo01,
      page: () => TextFieldButtonExample(),
      transition: defaultTransition,
    ),*/
    GetPage<dynamic>(
      name: logInWithEmailId,
      page: () => const LogInWithEmailScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: createNewPasswordScreen,
      page: () => const CreateNewPasswordScreen(
        userEmail: "123@gmail.com",
      ),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signIn,
      page: () => const GoogleLogInScreen(),
      transition: defaultTransition,
    ),

    GetPage<dynamic>(
      name: getStarted,
      page: () => const GetStartedScreen(),
      transition: defaultTransition,
    ),
    // GetPage<dynamic>(
    //   name: personalInformation,
    //   page: () => UserInformationScreen(),
    //   transition: defaultTransition,
    // ),
    // GetPage<dynamic>(
    //   name: addVehicle,
    //   page: () => const AddVehicleScreen(),
    //   transition: defaultTransition,
    // ),
    // GetPage<dynamic>(
    //   name: addVehicleDetail,
    //   page: () => const AddVehicleDetailsScreen(),
    //   transition: defaultTransition,
    // ),
    GetPage<dynamic>(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: defaultTransition,
    ),
    // GetPage<dynamic>(
    //   name: vehicleDiagnosisScreen,
    //   page: () => VehicleDiagnosisScreen(),
    //   transition: defaultTransition,
    // ),
    /*GetPage<dynamic>(
      name: vehicleInformationStepsScreen,
      page: () => VehicleInformationStepsScreen(
        screenName: "",
      ),
      transition: defaultTransition,
    ),*/
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
      page: () => VehicleDetailScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: subscriptionsSummeryScreen,
      page: () => const SubscriptionsSummeryScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: subscriptionsPlanScreen,
      page: () => const SubscriptionsPlanScreen(),
      transition: defaultTransition,
    ),
  ];
}
