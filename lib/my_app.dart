import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/generated/l10n.dart';
import 'package:flutter_template/language_change_provider.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              initialRoute: Routes.splash,
              getPages: Routes.pages,
              builder: (context, child) {
                return Scaffold(
                  body: GestureDetector(
                    onTap: () {
                      Utils.hideKeyboardInApp(context);
                    },
                    child: child,
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
