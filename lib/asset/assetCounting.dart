import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'actionButtons.dart';
import 'ent/asset.dart';

class AssetCountingWidget extends StatefulWidget {
  const AssetCountingWidget({Key? key}) : super(key: key);

  @override
  _AssetCountingWidgetState createState() => _AssetCountingWidgetState();
}

class _AssetCountingWidgetState extends State<AssetCountingWidget> {
     _AssetCountingWidgetState(){
    oriAssets = createAssets();
    assets = oriAssets;
    _scrollController = ScrollController();
    } 
  late List<Asset> oriAssets ;
  late List<Asset> assets ;
  var _scrollController ;
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
              assets=filterAssets(value);
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
                          color: assets[index].asset_name.endsWith("V")
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
            )),
      ],
    );
  }

  Future<void> _scanBarcode(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    if (barcodeScanRes != '-1') {
      Fluttertoast.showToast(
        msg: getAssetReadMsg(barcodeScanRes),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  String getAssetReadMsg(String barcodeScanRes) {
    String ret = "";
    for (int i = 0; i < oriAssets.length; i++) {
      if (oriAssets[i].asset_id == barcodeScanRes) {
        ret = "已讀取:${oriAssets[i].asset_name}";
        oriAssets[i].asset_name = "${oriAssets[i].asset_name} V";
        continue;
      }
    }
    if (ret == "") return "找不到相關資產.";
    setState(() {});
    return ret;
  }

  static List<Asset> createAssets() {
    final random = Random();
    final assets = List.generate(
      10000,
      (index) => Asset(
        '${random.nextInt(10000000)}',
        'Asset ${index + 1}',
      ),
    );

    assets.insert(0, Asset("8762921", '乾燥機'));
    assets.insert(0, Asset("8762622", '桌上型電腦'));
    assets.insert(0, Asset("8762923", 'Asus筆電'));
    assets.insert(0, Asset("8762624", 'Acer筆電'));
    assets.insert(0, Asset("8762925", 'Tableau Server'));
    assets.insert(0, Asset("8762926", 'Nvidia 顯卡'));
    assets.insert(0, Asset("8762627", '印表機'));
    assets.insert(0, Asset("8762929", 'Office 365'));
    assets.add(Asset("8762610", '投影機'));
    return assets;
  }

   List<Asset> filterAssets( String query) {
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
}
