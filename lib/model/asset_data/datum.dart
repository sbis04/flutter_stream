import 'dart:convert';

import 'package:flutter_stream/model/common/playback_id.dart';
import 'package:flutter_stream/model/common/track.dart';

class Datum {
  Datum({
    this.maxStoredResolution,
    this.id,
    this.playbackIds,
    this.status,
    this.aspectRatio,
    this.duration,
    this.tracks,
    this.maxStoredFrameRate,
    this.test,
    this.createdAt,
    this.masterAccess,
    this.mp4Support,
  });

  String maxStoredResolution;
  String id;
  List<PlaybackId> playbackIds;
  String status;
  String aspectRatio;
  double duration;
  List<Track> tracks;
  double maxStoredFrameRate;
  bool test;
  String createdAt;
  String masterAccess;
  String mp4Support;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        maxStoredResolution: json["max_stored_resolution"] == null
            ? null
            : json["max_stored_resolution"],
        id: json["id"] == null ? null : json["id"],
        playbackIds: json["playback_ids"] == null
            ? null
            : List<PlaybackId>.from(
                json["playback_ids"].map((x) => PlaybackId.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
        aspectRatio: json["aspect_ratio"] == null ? null : json["aspect_ratio"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        tracks: json["tracks"] == null
            ? null
            : List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
        maxStoredFrameRate: json["max_stored_frame_rate"] == null
            ? null
            : json["max_stored_frame_rate"].toDouble(),
        test: json["test"] == null ? null : json["test"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        masterAccess:
            json["master_access"] == null ? null : json["master_access"],
        mp4Support: json["mp4_support"] == null ? null : json["mp4_support"],
      );

  Map<String, dynamic> toJson() => {
        "max_stored_resolution":
            maxStoredResolution == null ? null : maxStoredResolution,
        "id": id == null ? null : id,
        "playback_ids": playbackIds == null
            ? null
            : List<dynamic>.from(playbackIds.map((x) => x.toJson())),
        "status": status == null ? null : status,
        "aspect_ratio": aspectRatio == null ? null : aspectRatio,
        "duration": duration == null ? null : duration,
        "tracks": tracks == null
            ? null
            : List<dynamic>.from(tracks.map((x) => x.toJson())),
        "max_stored_frame_rate":
            maxStoredFrameRate == null ? null : maxStoredFrameRate,
        "test": test == null ? null : test,
        "created_at": createdAt == null ? null : createdAt,
        "master_access": masterAccess == null ? null : masterAccess,
        "mp4_support": mp4Support == null ? null : mp4Support,
      };
}
