import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/features/playlist/playlist_type.enum.dart';

class ExploreCategoriesByIdModel {
  String? message;
  int? id;
  String? name;
  String? categoryDescription;
  List<String>? tagList;
  List<Playlist>? playlists;
  List<Recommended>? recommended;

  ExploreCategoriesByIdModel(
      {this.message,
      this.id,
      this.name,
      this.categoryDescription,
      this.tagList,
      this.playlists,
      this.recommended});

  ExploreCategoriesByIdModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    name = json['name'];
    categoryDescription = json['category_description'];
    tagList =
        json['tagList'] != null ? List<String>.from(json['tagList']) : null;
    if (json['playlists'] != null) {
      playlists = <Playlist>[];
      json['playlists'].forEach((v) {
        playlists!.add(Playlist.fromJson(v));
      });
    }
    if (json['recommended'] != null) {
      recommended = <Recommended>[];
      json['recommended'].forEach((v) {
        recommended!.add(Recommended.fromJson(v));
      });
    }
  }
}

class Playlist {
  int? id;
  String? name;
  ImageData? image;
  int? userId;
  var deviceId;
  int? tracksCount;
  String? tracksTotalDuration;
  PlaylistType? createdBy;
  String? creator;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? tracks;
  String? type;

  Playlist({
    this.id,
    this.name,
    this.image,
    this.userId,
    this.deviceId,
    this.tracksCount,
    this.tracksTotalDuration,
    this.createdBy,
    this.creator,
    this.createdAt,
    this.updatedAt,
    this.tracks,
    this.type,
  });

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = ImageData.fromJson(json['image']);
    userId = json['user_id'];
    deviceId = json['device_id'];
    tracksCount = json['tracks_count'];
    tracksTotalDuration = json['tracks_total_duration'];
    createdBy = json['created_by'] != null
        ? (json['created_by'] as String == 'A' ||
                json['created_by'] as String == '1'
            ? PlaylistType.admin
            : PlaylistType.custom)
        : null;
    creator = json['creator'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    tracks = json['tracks'] != null ? List<dynamic>.from(json['tracks']) : null;
    type = json['type'] ?? 'playlist';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image?.toJson(),
      'user_id': userId,
      'device_id': deviceId,
      'tracks_count': tracksCount,
      'tracks_total_duration': tracksTotalDuration,
      'created_by': createdBy != null
          ? (createdBy == PlaylistType.admin ? 'A' : 'custom')
          : null,
      'creator': creator,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'tracks': tracks,
      'type': type,
    };
  }
}

class Recommended {
  int? id;
  String? name;
  String? image;
  int? userId;
  var deviceId;
  int? tracksCount;
  String? tracksTotalDuration;
  int? affirmationsCount;
  String? totalAffirmationsDuration;
  int? isPlaylist;
  PlaylistType? createdBy;

  Recommended({
    this.id,
    this.name,
    this.image,
    this.userId,
    this.deviceId,
    this.tracksCount,
    this.tracksTotalDuration,
    this.affirmationsCount,
    this.totalAffirmationsDuration,
    this.isPlaylist,
    this.createdBy,
  });

  Recommended.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    userId = json['user_id'];
    deviceId = json['device_id'];
    tracksCount = json['tracks_count'];
    tracksTotalDuration = json['tracks_total_duration'];
    affirmationsCount = json['affirmations_count'];
    totalAffirmationsDuration = json['total_affirmations_duration'];
    isPlaylist = json['is_playlist'];
    createdBy = json['created_by'] != null
        ? (json['created_by'] as String == 'A' ||
                json['created_by'] as String == '1'
            ? PlaylistType.admin
            : PlaylistType.custom)
        : null;
  }
}
