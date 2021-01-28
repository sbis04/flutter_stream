import 'dart:convert';

import 'asset_data/datum.dart';

class AssetData {
  AssetData({
    this.data,
  });

  List<Datum> data;

  factory AssetData.fromRawJson(String str) =>
      AssetData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetData.fromJson(Map<String, dynamic> json) => AssetData(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
