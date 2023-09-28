import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertest/util/util.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'actionButtons.dart';
import 'ent/asset.dart';

class AssetCountingWidget extends StatefulWidget {
  const AssetCountingWidget({Key? key}) : super(key: key);

  @override
  _AssetCountingWidgetState createState() => _AssetCountingWidgetState();
}

class _AssetCountingWidgetState extends State<AssetCountingWidget> {
  _AssetCountingWidgetState() {
    oriAssets = createAssets();
    assets = oriAssets;
    _scrollController = ScrollController();
  }
  late List<Asset> oriAssets;
  late List<Asset> assets;
  var _scrollController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: '篩選',
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              assets = _filterAssets(value);
            });
          },
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              controller: _scrollController,
              semanticChildCount: assets.length,
              itemCount: assets.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text('產編: ${assets[index].asset_id}'),
                    subtitle: Text(
                      '品名: ${assets[index].asset_name}',
                      style: TextStyle(
                          color: assets[index].counted
                              ? Colors.red
                              : Colors.blue, // Change color here
                          fontWeight: FontWeight.bold, // Make it bold
                          fontStyle: FontStyle.italic //set font to italic
                          ),
                    ));
              },
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: AssetListActions(
              onScanBarcode: () => _scanBarcode(context),
              onClearCounted: () => _clearCounted(),
            )),
      ],
    );
  }

  Future<void> _scanBarcode(BuildContext context) async {
    String readBarcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    if (readBarcode != '-1') {
      var readMessage = _setReadAndReadMsg(readBarcode);
      showMessageDialog(context, readMessage, "已讀訊息");
      setState(() {});
    }
  }

  String _setReadAndReadMsg(String readBarcode) {
    String ret = "";
    for (int i = 0; i < oriAssets.length; i++) {
      if (oriAssets[i].asset_id == readBarcode) {
        ret = "${oriAssets[i].asset_id}\n${oriAssets[i].asset_name}";
        oriAssets[i].counted = true;
        continue;
      }
    }
    if (ret == "") return "找不到相關資產.";
    return ret;
  }

  List<Asset> _filterAssets(String query) {
    if (query.isEmpty) {
      return oriAssets;
    }

    return oriAssets.where((asset) {
      final nameLower = asset.asset_name.toLowerCase();
      final queryLower = query.toLowerCase();
      final idLower = asset.asset_id.toLowerCase();

      return nameLower.contains(queryLower) || idLower.contains(queryLower);
    }).toList();
  }

  _clearCounted() {
    showConfirmationDialog(
        context,
        "確認",
        "確認刪除盤點資料?",
        () => setState(() {
              oriAssets.forEach((element) {
                element.counted = false;
              });
            }));
  }

  static List<Asset> createAssets() {
    final random = Random();
    final assets = List.generate(
      10000,
      (index) => Asset(
        asset_id: '${random.nextInt(10000000)}',
        asset_name:'Asset ${index + 1}',
      ),
    );

    assets.insert(0, Asset(asset_id: "8762921",asset_name: '乾燥機'));
    assets.insert(0, Asset(asset_id: "8762622", asset_name: '桌上型電腦'));
    assets.insert(0, Asset(asset_id: "8762923", asset_name: 'Asus筆電'));
    assets.insert(0, Asset(asset_id: "8762624", asset_name: 'Acer筆電'));
    assets.insert(0, Asset(asset_id: "8762925", asset_name: 'Tableau Server'));
    assets.insert(0, Asset(asset_id: "8762926", asset_name: 'Nvidia 顯卡'));
    assets.insert(0, Asset(asset_id: "8762627", asset_name: '印表機'));
    assets.insert(0, Asset(asset_id: "8762929", asset_name: 'Office 365'));
    assets.add(Asset(asset_id: "8762610", asset_name: '投影機'));
    return assets;
  }
}
