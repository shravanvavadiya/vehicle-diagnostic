import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._();

  static SharedPreferencesHelper get instance => _instance;
  SharedPreferences? prefs;

  Future<void> initialAppPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void clearSharedPreferences() {
    log("clear clearSharedPreferences--");
    prefs?.clear();
    return;
  }

  Future setString(String key, String value) async {
    await prefs?.setString(key, value);
  }

  String getString(String key) {
    final String? value = prefs?.getString(key);
    return value ?? "";
  }

  Future setBoolean(String key, {required bool value}) async {
    await prefs?.setBool(key, value);
  }

  bool getBoolean(String key) {
    final bool? value = prefs?.getBool(key);
    return value ?? false;
  }

  Future setLong(String key, double value) async {
    await prefs?.setDouble(key, value);
  }

  double getLong(String key) {
    final double? value = prefs?.getDouble(key);
    return value ?? 0.0;
  }

  Future setInt(String key, int value) async {
    await prefs?.setInt(key, value);
  }

  int getInt(String key) {
    final int? value = prefs?.getInt(key);
    return value ?? 0;
  }

  static const String selectLanguage = 'en';

  Future<void> setLanguage(String language) async {
    await setString(selectLanguage, language);
  }

  String? getLanguage() {
    String language = getString(selectLanguage);
    return language.isNotEmpty ? language : null;
  }
}
