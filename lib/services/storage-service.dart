import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/models/identity/company.dart';

class StorageService {
  static StorageService _instance;
  static SharedPreferences _sharedPreferences;

  static const String _keyAccessToken = 'accessToken';
  static const String _keyRefreshToken = 'refreshToken';
  static const String _keyLoginUser = 'loginUser';
  static const String _keyLoginCompany = 'loginCompany';
  static const String _keyLanguage = 'language';

  Account _loginUser;
  Company _loginCompany;
  String _accessToken;
  String _refreshToken;
  String _language;

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }

    // init from local storage
    // TODO revert later
    _instance._accessToken = _instance.getString(_keyAccessToken);
    _instance._refreshToken = _instance.getString(_keyRefreshToken);
    _instance._language = _instance.getString(_keyLanguage);
    print(_instance.getString(_keyLoginUser));
    try {
      _instance.loginUser =
          Account.fromJson(json.decode(_instance.getString(_keyLoginUser)));
    } catch (_) {
      print(_);
    }

    return _instance;
  }

  Account get loginUser => _loginUser;

  set loginUser(Account value) {
    _loginUser = value;
    putString(_keyLoginUser, json.encode(value.toJson()));
  }

  Company get loginCompany => _loginCompany;

  set loginCompany(Company value) {
    _loginCompany = value;
    putString(_keyLoginCompany, json.encode(value.toJson()));
  }

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
    putString(_keyAccessToken, value);
  }

  String get refreshToken => _refreshToken;

  set refreshToken(String value) {
    _refreshToken = value;
    putString(_keyRefreshToken, value);
  }

  String get language => _language;

  set language(String value) {
    _language = value;
    putString(_keyLanguage, value);
  }

  Future<bool> putBool(String key, bool value) =>
      _sharedPreferences.setBool(key, value);

  bool getBool(String key) => _sharedPreferences.getBool(key);

  Future<bool> putDouble(String key, double value) =>
      _sharedPreferences.setDouble(key, value);

  double getDouble(String key) => _sharedPreferences.getDouble(key);

  Future<bool> putInt(String key, int value) =>
      _sharedPreferences.setInt(key, value);

  int getInt(String key) => _sharedPreferences.getInt(key);

  Future<bool> putString(String key, String value) =>
      _sharedPreferences.setString(key, value);

  String getString(String key) => _sharedPreferences.getString(key);

  Future<bool> putStringList(String key, List<String> value) =>
      _sharedPreferences.setStringList(key, value);

  List<String> getStringList(String key) =>
      _sharedPreferences.getStringList(key);

  bool isKeyExists(String key) => _sharedPreferences.containsKey(key);

  Future<bool> clearKey(String key) => _sharedPreferences.remove(key);

  Future<bool> clearAll() => _sharedPreferences.clear();

  Future<bool> clearSession() {
    clearKey(_keyAccessToken);
    clearKey(_keyRefreshToken);
    clearKey(_keyLoginUser);
    clearKey(_keyLoginCompany);

    _accessToken = null;
    _refreshToken = null;
    _loginUser = null;
    _loginCompany = null;
  }
}
