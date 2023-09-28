import 'package:flutter/material.dart';
import 'package:fluttertest/asset/assetCounting.dart';
import 'package:fluttertest/config/appStorage.dart';

class AssetCountingPage extends StatefulWidget {
  const AssetCountingPage({Key? key}) : super(key: key);

  @override
  _AssetCountingPageState createState() => _AssetCountingPageState();
}

class _AssetCountingPageState extends State<AssetCountingPage> {
  _AssetCountingPageState() {
    retrieveLoginUser().then((value) => setState(() {
      loginUser=value;
    }));
  }
  var loginUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('盤點作業(${loginUser!=null? loginUser.username:""})'),
      ),
      body: const AssetCountingWidget(),
    );
  }
}
