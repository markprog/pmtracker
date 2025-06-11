// import 'dart:convert';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user_repository/user_repository.dart';
//
// class Const {
//   static const String ACCESS_TOKEN = "ACCESS_TOKEN";
//   static const String EXPIRES_AT = "EXPIRES_AT";
//   static const String USER = "USER";
// }
//
// class SharedPreferencesHelper {
//   static late final SharedPreferences _prefs;
//
//   /// ❗ Инициализировать один раз в `main()`
//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   // 🔽 Методы доступа
//   static String getString(String key) => _prefs.getString(key) ?? '';
//   static Future<void> setString(String key, String value) async => _prefs.setString(key, value);
//
//   static bool getBool(String key) => _prefs.getBool(key) ?? false;
//   static Future<void> setBool(String key, bool value) async => _prefs.setBool(key, value);
//
//   // 🔽 Конкретные ключи
//   static String get user => getString(Const.USER);
//   static Future<void> setUser(String value) => setString(Const.USER, value);
//
//   static String get accessToken => getString(Const.ACCESS_TOKEN);
//   static Future<void> setAccessToken(String value) => setString(Const.ACCESS_TOKEN, value);
//
//   static String get expiresAt => getString(Const.EXPIRES_AT);
//   static Future<void> setExpiresAt(String value) => setString(Const.EXPIRES_AT, value);
// }
