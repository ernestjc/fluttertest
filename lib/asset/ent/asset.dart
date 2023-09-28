class Asset {
  String asset_id;
  String asset_name;
  bool counted;

  Asset({
    required this.asset_id,
    required this.asset_name,
    this.counted = false,
  });
 
  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      asset_id: json['assetId'],
      asset_name: json['assetName1'] ,
      counted: json['counted']!=null ? json['counted'] : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assetId': asset_id,
      'assetName1': asset_name,
      'counted': counted,
    };
  }
}
