// To parse this JSON data, do
//
//     final videoData = videoDataFromJson(jsonString);

import 'dart:convert';

import 'video_data/data.dart';

class VideoData {
  VideoData({
    this.data,
  });

  Data data;

  factory VideoData.fromRawJson(String str) =>
      VideoData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
