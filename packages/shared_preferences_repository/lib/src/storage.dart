import 'package:shared_preferences/shared_preferences.dart';

class Const {
  static const String ACCESS_TOKEN = "ACCESS_TOKEN";
  static const String EXPIRES_AT = "EXPIRES_AT";
  static const String USER = "USER";
}

class SharedPreferencesHelper {
  final SharedPreferences _prefs;

  SharedPreferencesHelper(this._prefs);

  // Методы доступа
  String getString(String key) => _prefs.getString(key) ?? '';
  Future<void> setString(String key, String value) async => _prefs.setString(key, value);

  bool getBool(String key) => _prefs.getBool(key) ?? false;
  Future<void> setBool(String key, bool value) async => _prefs.setBool(key, value);

  // Конкретные ключи
  String get user => getString(Const.USER);
  Future<void> setUser(String value) => setString(Const.USER, value);

  String get accessToken => getString(Const.ACCESS_TOKEN);
  Future<void> setAccessToken(String value) => setString(Const.ACCESS_TOKEN, value);

  String get expiresAt => getString(Const.EXPIRES_AT);
  Future<void> setExpiresAt(String value) => setString(Const.EXPIRES_AT, value);

  Future<void> clearUserData() async {
    await _prefs.remove(Const.USER);
    await _prefs.remove(Const.ACCESS_TOKEN);
    await _prefs.remove(Const.EXPIRES_AT);
  }
}