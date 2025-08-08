import 'package:get/get.dart';
import 'package:manifest/core/utils/helpers.dart';
import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/models/explore_tab_model/featured_tab_model/featured_tab_model.dart'
    as FeaturedTabModel;

class PlaylistResponseModel {
  String? message;
  Playlist? data;

  PlaylistResponseModel({this.message, this.data});

  factory PlaylistResponseModel.fromJson(Map<String, dynamic> json) {
    return PlaylistResponseModel(
      message: json['message'],
      data: json['data'] != null ? Playlist.fromJson(json['data']) : null,
    );
  }
}

class Playlist {
  int? id;
  String? name;
  ImageData? image;
  int? userId;
  var deviceId;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? tracksCount;
  String? tracksTotalDuration;
  List<Tracks>? tracks;

  Playlist({
    this.id,
    this.name,
    required this.image,
    this.userId,
    this.deviceId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.tracksCount,
    this.tracksTotalDuration,
    this.tracks,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      image: parseImageData(json['image']),
      userId: json['user_id'],
      deviceId: json['device_id'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      tracksCount: json['tracks_count'],
      tracksTotalDuration: json['tracks_total_duration'],
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => Tracks.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Tracks {
  int? id;
  int? playlistId;
  int? trackId;
  int? order;
  dynamic deviceId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? itemIndex;
  int? affirmationsCount;
  String? trackName;
  String? trackFile;
  TrackAffirmations? trackAffirmations;
  String? tags;
  String? file;
  dynamic categoryId;
  int? subscriptionPlan;
  String? name;
  ImageData? image;
  dynamic mindMovies;
  int? status;
  Pivot? pivot;
  String? trackDuration;
  int? durationInSeconds;

  Tracks({
    this.id,
    this.playlistId,
    this.trackId,
    this.order,
    this.deviceId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.itemIndex,
    this.affirmationsCount,
    this.trackName,
    this.trackFile,
    this.trackAffirmations,
    this.tags,
    this.file,
    this.categoryId,
    this.subscriptionPlan,
    this.name,
    this.image,
    this.mindMovies,
    this.status,
    this.pivot,
    this.trackDuration,
    this.durationInSeconds,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) {
    return Tracks(
      id: json['id'],
      playlistId: json['playlist_id'],
      trackId: json['track_id'],
      order: json['order'],
      deviceId: json['device_id'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      itemIndex: json['item_index'],
      affirmationsCount: json['affirmations_count'],
      trackName: json['track_name'],
      trackFile: json['track_file'],
      trackAffirmations: json['track_affirmations'] != null
          ? TrackAffirmations.fromJson(json['track_affirmations'])
          : null,
      tags: json['tags'],
      file: json['file'],
      categoryId: json['category_id'],
      subscriptionPlan:
          json['subscription_plan'] == "0" || json['subscription_plan'] == "1"
              ? int.parse(json['subscription_plan'])
              : null,
      name: json['name'],
      image: parseImageData(json['image']),
      mindMovies: json['mind_movies'],
      status: int.tryParse(json['status']),
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
      trackDuration: json['track_duration'],
      durationInSeconds: json['duration_in_seconds'],
    );
  }

  // Convert Tracks to PlaylistOrTrack
  FeaturedTabModel.PlaylistOrTrack toPlaylistOrTrack() {
    return FeaturedTabModel.PlaylistOrTrack(
      id: id ?? 0,
      name: trackName ?? name ?? '',
      image: image,
      tags: tags,
      file: trackFile ?? file,
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
      trackDuration: trackDuration,
      affirmationsCount: affirmationsCount?.toString(),
      isFavorite: RxBool(false),
      isFeatured: RxBool(false),
      affirmations: trackAffirmations != null
          ? trackAffirmations!.file!
              .map(
                (affirmation) => FeaturedTabModel.Affirmation(
                  id: affirmation.affirmationId,
                  description: affirmation.affirmationTitle,
                  image: '',
                  subForm: '',
                  affirmationsDuration: '00:00:00',
                  isFavorite: RxBool(false),
                  isHidden: RxBool(false),
                  voices: [],
                ),
              )
              .toList()
          : <FeaturedTabModel.Affirmation>[],
      userId: userId?.toString(),
      deviceId: deviceId?.toString(),
      isPlaylist: false,
    );
  }
}

class Pivot {
  int? playlistId;
  int? trackId;

  Pivot({this.playlistId, this.trackId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      playlistId: json['playlist_id'],
      trackId: json['track_id'],
    );
  }
}

class TrackAffirmations {
  List<Affirmation>? file;

  TrackAffirmations(this.file);

  factory TrackAffirmations.fromJson(Map<String, dynamic> json) {
    final List<Affirmation> _file = <Affirmation>[];
    if (json['file'] != null) {
      json['file'].forEach((v) {
        _file.add(Affirmation.fromJson(v));
      });
    }
    return TrackAffirmations(_file);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (file != null) {
      data['file'] = file!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Affirmation {
  String adamVoiceUrl;
  String aliceVoiceUrl;
  String antoniVoiceUrl;
  String affirmationTitle;
  int affirmationId;

  Affirmation({
    required this.adamVoiceUrl,
    required this.aliceVoiceUrl,
    required this.antoniVoiceUrl,
    required this.affirmationTitle,
    required this.affirmationId,
  });

  factory Affirmation.fromJson(Map<String, dynamic> json) => Affirmation(
        adamVoiceUrl: json["adam_voice_url"],
        aliceVoiceUrl: json["alice_voice_url"],
        antoniVoiceUrl: json["antoni_voice_url"],
        affirmationTitle: json["affirmation_title"],
        affirmationId: json["affirmation_id"],
      );

  toJson() => {
        "adam_voice_url": adamVoiceUrl,
        "alice_voice_url": aliceVoiceUrl,
        "antoni_voice_url": antoniVoiceUrl,
        "affirmation_title": affirmationTitle,
        "affirmation_id": affirmationId,
      };
}
