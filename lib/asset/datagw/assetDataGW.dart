import 'dart:convert';
import 'package:fluttertest/asset/ent/asset.dart';
import 'package:fluttertest/config/appSetting.dart';
import 'package:fluttertest/config/appStorage.dart';
import 'package:http/http.dart' as http;

Future<List<Asset>> fetchAllAssets() async {
  String token = (await retrieveLoginUser())!.jwt;
  final response = await http.post(
    Uri.parse(SERVER_GET_ALL_ASSEETS),
    headers: {
      'Content-Type': 'application/json;charset=utf-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes));
    _validLoginData(data);
    var ret = data["data"].map((item) => Asset.fromJson(item)).toList();
    return _convertToListAsset(ret);
  } else {
    throw Exception('取得資料時發生錯誤');
  }
}

Future<List<Asset>> _convertToListAsset(ret) {
  List<Asset> assets = [];
  for (int i = 0; i < ret.length; i++) {
    assets.add(ret[i]);
  }
  return Future.value(assets);
}

void _validLoginData(data) {
  if (data["returnCode"] != "0") {
    throw Exception(data["message"]);
  }
}
