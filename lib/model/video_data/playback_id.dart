import 'dart:convert';

class PlaybackId {
  PlaybackId({
    this.policy,
    this.id,
  });

  String policy;
  String id;

  factory PlaybackId.fromRawJson(String str) =>
      PlaybackId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaybackId.fromJson(Map<String, dynamic> json) => PlaybackId(
        policy: json["policy"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "policy": policy,
        "id": id,
      };
}
