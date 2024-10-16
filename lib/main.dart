import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/my_app.dart';
import 'package:flutter_template/utils/app_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FireBaseNotification().setUpLocalNotification();
  // FirebaseAnalyticsUtils().init();
  // FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  runZonedGuarded<Future<void>>(() async {
    // await crashlytics.setCrashlyticsCollectionEnabled(true);
    // FlutterError.onError = crashlytics.recordFlutterError;

  }, (error, stack) => print(error));
  // crashlytics.recordError(error, stack));
}
