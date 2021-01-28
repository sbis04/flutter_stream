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
        policy: json["policy"] == null ? null : json["policy"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "policy": policy == null ? null : policy,
        "id": id == null ? null : id,
      };
}
