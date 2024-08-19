import 'dart:async';
import 'package:exercies4/common/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  late final SharedPreferences _pref;

  Future<SharedPreferencesHelper> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  String getString(String key) {
    return _pref.getString(key) ?? '';
  }

  Future<bool> setInt(String key, int value) async {
    return await _pref.setInt(key, value);
  }

  int? getInt(String key) {
    return _pref.getInt(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _pref.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _pref.getDouble(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(AppConstants.keyFirstDevice) ?? true;
  }

  Future<bool> setUserId(String uid) async {
    return await _pref.setString(AppConstants.keyUserId, uid);
  }

  String getUserId() {
    return _pref.getString(AppConstants.keyUserId) ?? '';
  }

}
