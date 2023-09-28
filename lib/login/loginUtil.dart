import 'dart:convert';
import 'package:fluttertest/config/appSetting.dart';
import 'package:fluttertest/config/appStorage.dart';
import 'package:fluttertest/login/loginUser.dart';
import 'package:http/http.dart' as http;

Future<LoginUser> login(String username, String password) async {
  final url = Uri.parse(SERVER_GET_JWT);
  final headers = {'Content-Type': 'application/json; charset=utf-8'};
  final body = json.encode({
    'notesId': username,
    'password': password,
  });
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes));
    _validLoginData(data);
    final loginUser = LoginUser.fromJson(data["data"]);
    await saveLoginUser(loginUser);
    return loginUser;
  } else {
    throw Exception('無法連接伺服器');
  }
}

void _validLoginData(data) {
  if (data["returnCode"] != "0") {
    throw Exception(data["message"]);
  }
}
