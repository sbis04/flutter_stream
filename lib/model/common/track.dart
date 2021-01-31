import 'dart:convert';

class Track {
  Track({
    this.maxWidth,
    this.type,
    this.id,
    this.duration,
    this.maxFrameRate,
    this.maxHeight,
    this.maxChannelLayout,
    this.maxChannels,
  });

  int maxWidth;
  String type;
  String id;
  double duration;
  double maxFrameRate;
  int maxHeight;
  String maxChannelLayout;
  int maxChannels;

  factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        maxWidth: json["max_width"] == null ? null : json["max_width"],
        type: json["type"] == null ? null : json["type"],
        id: json["id"] == null ? null : json["id"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        maxFrameRate: json["max_frame_rate"] == null
            ? null
            : json["max_frame_rate"].toDouble(),
        maxHeight: json["max_height"] == null ? null : json["max_height"],
        maxChannelLayout: json["max_channel_layout"] == null
            ? null
            : json["max_channel_layout"],
        maxChannels: json["max_channels"] == null ? null : json["max_channels"],
      );

  Map<String, dynamic> toJson() => {
        "max_width": maxWidth == null ? null : maxWidth,
        "type": type == null ? null : type,
        "id": id == null ? null : id,
        "duration": duration == null ? null : duration,
        "max_frame_rate": maxFrameRate == null ? null : maxFrameRate,
        "max_height": maxHeight == null ? null : maxHeight,
        "max_channel_layout":
            maxChannelLayout == null ? null : maxChannelLayout,
        "max_channels": maxChannels == null ? null : maxChannels,
      };
}
