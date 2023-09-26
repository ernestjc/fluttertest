import 'package:flutter/material.dart';
import 'package:fluttertest/asset/assetCounting.dart';

class AssetCountingPage extends StatelessWidget {
  const AssetCountingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('盤點作業'),
      ),
      body: const AssetCountingWidget(),
      );
  }
}
