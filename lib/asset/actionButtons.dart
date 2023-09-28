import 'package:flutter/material.dart';
import 'package:fluttertest/asset/datagw/assetDataGW.dart';
import 'package:fluttertest/util/util.dart';

class AssetListActions extends StatelessWidget {
  const AssetListActions(
      {Key? key, required this.onScanBarcode, required this.onClearCounted})
      : super(key: key);

  final VoidCallback onScanBarcode;
  final VoidCallback onClearCounted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: onScanBarcode,
                  icon: Icon(Icons.qr_code),
                  color: Colors.white,
                ),
              ),
               const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                  downloadAssets();
                  },
                  icon: Icon(Icons.download),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    onClearCounted();
                  },
                  icon: Icon(Icons.refresh),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.nfc),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.nfc),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.nfc),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.nfc),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.nfc),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.construction),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.book_online),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.camera_indoor),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                  onPressed: () {
                    // Add your code here
                  },
                  icon: Icon(Icons.camera_front_rounded),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void downloadAssets() {
    fetchAllAssets().then((value) => {
      showMessage(value.toString())
    });
  }
}
