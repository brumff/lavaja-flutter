import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static String _key = 'key';
  static save(String token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({"token": token, "isAuth": true}));
  }

  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);
      return mapUser['isAuth'];
    }
    return false;
  }

  static logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    print(_key);
  }

  static Future<String?> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);
      return mapUser['token'];
    }
    return null;
  }

  static Future<void> saveFirebaseToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firebase_token', token);
  }

  static Future<String?> getFirebaseToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('firebase_token');
  }
}
