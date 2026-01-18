import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  factory PreferencesManager() => _instance;

  PreferencesManager._internal();

  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }

  Future<bool> remove(String key) async {
    return _preferences.remove(key);
  }

  Future<bool> clear() {
    return _preferences.clear();
  }
}
