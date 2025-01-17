import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedpreference;
  static late FlutterSecureStorage flutterSecureStorage;
  static init() async {
    sharedpreference = await SharedPreferences.getInstance();
    flutterSecureStorage = const FlutterSecureStorage();
  }

  static Future<bool> savedata({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedpreference.setString(key, value);
    } else if (value is int) {
      return await sharedpreference.setInt(key, value);
    } else if (value is bool) {
      return await sharedpreference.setBool(key, value);
    } else {
      return await sharedpreference.setDouble(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedpreference.get(key);
  }

  static Future<bool> removedata({
    required String key,
  }) async {
    return await sharedpreference.remove(key);
  }

  static Future<bool> clear() async {
    return await sharedpreference.clear();
  }

  static setSecuredString(String key, String? value) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {
    return await flutterSecureStorage.read(key: key);
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static deleteFromSecureStorge({
    required String key,
  }) async {
    await flutterSecureStorage.delete(key: key);
  }
}
