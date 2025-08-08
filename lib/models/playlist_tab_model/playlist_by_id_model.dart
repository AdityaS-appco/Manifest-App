class PlaylistByIDModel {
  String? message;
  Data? data;

  PlaylistByIDModel({this.message, this.data});

  PlaylistByIDModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
    int? id;
    String? name;
    String? image;
    dynamic userId;
    String? deviceId;
    String? createdBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? tracksCount;
    String? tracksTotalDuration;
    List<Track>? tracks;

    Data({
        this.id,
        this.name,
        this.image,
        this.userId,
        this.deviceId,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.tracksCount,
        this.tracksTotalDuration,
        this.tracks,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        tracksCount: json["tracks_count"],
        tracksTotalDuration: json["tracks_total_duration"],
        tracks: json["tracks"] == null ? [] : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "user_id": userId,
        "device_id": deviceId,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "tracks_count": tracksCount,
        "tracks_total_duration": tracksTotalDuration,
        "tracks": tracks == null ? [] : List<dynamic>.from(tracks!.map((x) => x.toJson())),
    };
}

class Track {
    int? id;
    int? playlistId;
    int? trackId;
    dynamic order;
    String? deviceId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? itemIndex;
    int? affirmationsCount;
    TrackAffirmations? trackAffirmations;

    Track({
        this.id,
        this.playlistId,
        this.trackId,
        this.order,
        this.deviceId,
        this.createdAt,
        this.updatedAt,
        this.itemIndex,
        this.affirmationsCount,
        this.trackAffirmations,
    });

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json["id"],
        playlistId: json["playlist_id"],
        trackId: json["track_id"],
        order: json["order"],
        deviceId: json["device_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        itemIndex: json["item_index"],
        affirmationsCount: json["affirmations_count"],
        trackAffirmations: json["track_affirmations"] == null ? null : TrackAffirmations.fromJson(json["track_affirmations"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "playlist_id": playlistId,
        "track_id": trackId,
        "order": order,
        "device_id": deviceId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "item_index": itemIndex,
        "affirmations_count": affirmationsCount,
        "track_affirmations": trackAffirmations?.toJson(),
    };
}

class TrackAffirmations {
    List<FileElement>? file;

    TrackAffirmations({
        this.file,
    });

    factory TrackAffirmations.fromJson(Map<String, dynamic> json) => TrackAffirmations(
        file: json["file"] == null ? [] : List<FileElement>.from(json["file"]!.map((x) => FileElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "file": file == null ? [] : List<dynamic>.from(file!.map((x) => x.toJson())),
    };
}

class FileElement {
    String? adamVoiceUrl;
    String? aliceVoiceUrl;
    String? antoniVoiceUrl;

    FileElement({
        this.adamVoiceUrl,
        this.aliceVoiceUrl,
        this.antoniVoiceUrl,
    });

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        adamVoiceUrl: json["adam_voice_url"],
        aliceVoiceUrl: json["alice_voice_url"],
        antoniVoiceUrl: json["antoni_voice_url"],
    );

    Map<String, dynamic> toJson() => {
        "adam_voice_url": adamVoiceUrl,
        "alice_voice_url": aliceVoiceUrl,
        "antoni_voice_url": antoniVoiceUrl,
    };
}
