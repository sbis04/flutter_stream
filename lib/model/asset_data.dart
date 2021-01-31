import 'dart:convert';

import 'common/data.dart';

class AssetData {
  AssetData({
    this.data,
  });

  List<Data> data;

  factory AssetData.fromRawJson(String str) =>
      AssetData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetData.fromJson(Map<String, dynamic> json) => AssetData(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
