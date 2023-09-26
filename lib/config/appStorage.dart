import 'dart:convert';

import 'package:fluttertest/login/loginUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _LOGINUSER_KEY = 'loginUser';
Future<void> saveLoginUser(LoginUser loginUser) async {
  final prefs = await SharedPreferences.getInstance();
  final json = loginUser.toJson();

  await prefs.setString(_LOGINUSER_KEY, jsonEncode(json));
}

Future<LoginUser?> retrieveLoginUser() async {
  final prefs = await SharedPreferences.getInstance();
  final json = prefs.getString(_LOGINUSER_KEY);
  if (json == null) {
    return null;
  }
  final loginUser = LoginUser.fromJson(jsonDecode(json));
  return loginUser;
}
