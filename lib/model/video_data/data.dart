import 'dart:convert';

import 'package:flutter_stream/model/video_data/track.dart';

import 'playback_id.dart';

class Data {
  Data({
    this.test,
    this.maxStoredFrameRate,
    this.status,
    this.tracks,
    this.id,
    this.maxStoredResolution,
    this.masterAccess,
    this.playbackIds,
    this.createdAt,
    this.duration,
    this.mp4Support,
    this.aspectRatio,
  });

  bool test;
  double maxStoredFrameRate;
  String status;
  List<Track> tracks;
  String id;
  String maxStoredResolution;
  String masterAccess;
  List<PlaybackId> playbackIds;
  String createdAt;
  double duration;
  String mp4Support;
  String aspectRatio;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        test: json["test"] == null ? null : json["test"],
        maxStoredFrameRate: json["max_stored_frame_rate"] == null
            ? null
            : json["max_stored_frame_rate"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        tracks: json["tracks"] == null
            ? null
            : List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
        id: json["id"] == null ? null : json["id"],
        maxStoredResolution: json["max_stored_resolution"] == null
            ? null
            : json["max_stored_resolution"],
        masterAccess:
            json["master_access"] == null ? null : json["master_access"],
        playbackIds: json["playback_ids"] == null
            ? null
            : List<PlaybackId>.from(
                json["playback_ids"].map((x) => PlaybackId.fromJson(x))),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        mp4Support: json["mp4_support"] == null ? null : json["mp4_support"],
        aspectRatio: json["aspect_ratio"] == null ? null : json["aspect_ratio"],
      );

  Map<String, dynamic> toJson() => {
        "test": test == null ? null : test,
        "max_stored_frame_rate":
            maxStoredFrameRate == null ? null : maxStoredFrameRate,
        "status": status == null ? null : status,
        "tracks": tracks == null
            ? null
            : List<dynamic>.from(tracks.map((x) => x.toJson())),
        "id": id == null ? null : id,
        "max_stored_resolution":
            maxStoredResolution == null ? null : maxStoredResolution,
        "master_access": masterAccess == null ? null : masterAccess,
        "playback_ids": playbackIds == null
            ? null
            : List<dynamic>.from(playbackIds.map((x) => x.toJson())),
        "created_at": createdAt == null ? null : createdAt,
        "duration": duration == null ? null : duration,
        "mp4_support": mp4Support == null ? null : mp4Support,
        "aspect_ratio": aspectRatio == null ? null : aspectRatio,
      };
}
