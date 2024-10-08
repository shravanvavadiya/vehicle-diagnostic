import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/generated/l10n.dart';
import 'package:flutter_template/language_change_provider.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
              theme: ThemeData(
                  fontFamily: "NeueHaasDisplayBold",
                  useMaterial3: false,
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  disabledColor: Colors.transparent,
                  scaffoldBackgroundColor: Colors.white,
                  checkboxTheme: CheckboxThemeData(
                      side: BorderSide(width: 0, color: AppColors.whiteColor),
                      checkColor: WidgetStatePropertyAll(AppColors.primaryColor),
                      fillColor: WidgetStatePropertyAll(AppColors.backgroundColor))),
              debugShowCheckedModeBanner: false,
              locale: Provider.of<LanguageChangeProvider>(context).currentLocal,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              title: AppString.appName,
              initialBinding: AppBidding(),
              // initialRoute: Routes.createNewPasswordScreen,
              initialRoute: Routes.splash,
              // initialRoute: Routes.demo01,
              getPages: Routes.pages,
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Scaffold(
                    backgroundColor: AppColors.whiteColor,
                    resizeToAvoidBottomInset: false,
                    body: GestureDetector(
                      onTap: () {
                        Utils.hideKeyboardInApp(context);
                      },
                      child: child,
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

class AppBidding extends Bindings {
  @override
  void dependencies() {}
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
