import 'dart:convert';

import 'playback_id.dart';

class Data {
  Data({
    this.test,
    this.status,
    this.playbackIds,
    this.mp4Support,
    this.masterAccess,
    this.id,
    this.createdAt,
  });

  bool test;
  String status;
  List<PlaybackId> playbackIds;
  String mp4Support;
  String masterAccess;
  String id;
  String createdAt;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        test: json["test"],
        status: json["status"],
        playbackIds: List<PlaybackId>.from(
            json["playback_ids"].map((x) => PlaybackId.fromJson(x))),
        mp4Support: json["mp4_support"],
        masterAccess: json["master_access"],
        id: json["id"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "test": test,
        "status": status,
        "playback_ids": List<dynamic>.from(playbackIds.map((x) => x.toJson())),
        "mp4_support": mp4Support,
        "master_access": masterAccess,
        "id": id,
        "created_at": createdAt,
      };
}
