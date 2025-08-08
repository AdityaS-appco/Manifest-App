import 'package:get/get.dart';
import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/features/media_player/models/voice_option.dart';
import 'package:manifest/features/playlist/playlist_type.enum.dart';

class FeaturedListTabModel {
  FeaturedListTabModel({
    this.message,
    this.description,
    this.featured,
    this.recommended,
    this.newlyAdded,
    this.recentlyPlayed,
    this.favorites,
  });
  String? message;
  String? description;
  List<PlaylistOrTrack>? featured;
  List<PlaylistOrTrack>? recommended;
  List<PlaylistOrTrack>? newlyAdded;
  List<PlaylistOrTrack>? recentlyPlayed;
  List<PlaylistOrTrack>? favorites;

  FeaturedListTabModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    description = json['description'];
    featured = json['featured'] != null
        ? List.from(json['featured']).map((e) {
            return PlaylistOrTrack.fromJson(e);
          }).toList()
        : <PlaylistOrTrack>[];
    recommended = json['recommended'] != null
        ? List.from(json['recommended']).map((e) {
            return PlaylistOrTrack.fromJson(e);
          }).toList()
        : <PlaylistOrTrack>[];
    newlyAdded = json['newly_added'] != null
        ? List.from(json['newly_added']).map((e) {
            return PlaylistOrTrack.fromJson(e);
          }).toList()
        : <PlaylistOrTrack>[];
    recentlyPlayed = json['recently_played'] != null
        ? List.from(json['recently_played']).map((e) {
            return PlaylistOrTrack.fromJson(e);
          }).toList()
        : <PlaylistOrTrack>[];
    favorites = json['favorites'] != null
        ? List.from(json['favorites']).map((e) {
            return PlaylistOrTrack.fromJson(e);
          }).toList()
        : <PlaylistOrTrack>[];
  }
}

class Creator {
  String name;
  String imageUrl;

  Creator({
    required this.name,
    required this.imageUrl,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        name: json['name'] as String,
        imageUrl: json['image_url'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image_url': imageUrl,
      };
}

class PlaylistOrTrack {
  PlaylistOrTrack({
    required this.id,
    required this.name,
    this.image,
    this.mindMovie,
    this.tags,
    this.file,
    required this.isFeatured,
    required this.isFavorite,
    this.tracks,
    this.userId,
    this.deviceId,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.trackCount,
    this.trackDuration,
    this.tracksTotalDuration,
    this.affirmationsCount,
    this.totalAffirmationsDuration,
    this.affirmations,
    this.isPlaylist = false,
    this.isPremium = false,
    // this.creator,
  });

  int id;
  String? name;
  ImageData? image;
  String? mindMovie;
  String? tags;
  String? file;
  RxBool isFeatured;
  RxBool isFavorite;
  List<Track>? tracks;
  String? userId;
  String? deviceId;
  PlaylistType? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? trackCount;
  String? trackDuration;
  String? tracksTotalDuration;
  String? affirmationsCount;
  String? totalAffirmationsDuration;
  List<Affirmation>? affirmations;
  bool isPlaylist;
  bool isPremium;
  // Creator? creator;

  factory PlaylistOrTrack.fromJson(Map<String, dynamic> json) =>
      PlaylistOrTrack(
        id: json['id'],
        name: json['name'],
        image: ImageData.fromJson(json['image']),
        mindMovie: (json['mind_movie']?.toString().contains('.mp4') ?? false
            ? json['mind_movie']
            : null),
        // mindMovie: 'https://videos.pexels.com/video-files/26633309/11981374_360_640_24fps.mp4',
        tags: json['tags'] as String?,
        file: json['file'] as String?,
        isFeatured: RxBool(json['featured']?.toString() == '1' ||
            json['featured']?.toString() == 'true'),
        isFavorite: RxBool(json['favorite']?.toString() == '1' ||
            json['favorite']?.toString() == 'true' ||
            json['is_favorite']?.toString() == '1' ||
            json['is_favorite']?.toString() == 'true'),
        tracks: json['tracks'] != null
            ? List<Track>.from(json['tracks'].map((x) => Track.fromJson(x)))
            : null,
        userId: json['user_id']?.toString() ?? '',
        deviceId: json['device_id']?.toString() ?? '',
        createdBy: (json['created_by'] as String? ?? 'A') == 'A' ||
                (json['created_by'] as String? ?? 'A') == '1'
            ? PlaylistType.admin
            : PlaylistType.custom,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        trackCount: json['track_count']?.toString() ?? "0",
        tracksTotalDuration:
            json['tracks_total_duration']?.toString() ?? "00:00:00",
        trackDuration: json['track_duration']?.toString() ?? "00:00:00",
        affirmationsCount: json['affirmations_count']?.toString() ?? "0",
        totalAffirmationsDuration:
            json['total_affirmations_duration']?.toString() ?? "00:00:00",
        affirmations: json['affirmations'] != null
            ? List<Affirmation>.from(
                json['affirmations'].map((x) => Affirmation.fromJson(x)))
            : null,
        isPlaylist: (json['is_playlist']?.toString() == '1'),
        isPremium: (json['is_premium']?.toString() == '1'),
        // creator:
        //     json['creator'] != null ? Creator.fromJson(json['creator']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image?.toJson(),
        'tags': tags,
        'file': file,
        'featured': isFeatured.value ? 1 : 0,
        'is_favorite': isFavorite.value ? 1 : 0,
        'tracks': tracks?.map((x) => x.toJson()).toList(),
        'user_id': userId,
        'device_id': deviceId,
        'created_by': createdBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'track_count': trackCount,
        'tracks_total_duration': tracksTotalDuration,
        'track_duration': trackDuration,
        'affirmations_count': affirmationsCount,
        'total_affirmations_duration': totalAffirmationsDuration,
        'affirmations': affirmations?.map((x) => x.toJson()).toList(),
        'is_playlist': isPlaylist ? 1 : 0,
        'is_premium': isPremium ? 1 : 0,
        // 'creator': creator?.toJson(),
      };
}

class Track {
  int id;
  int playlistId;
  int trackId;
  int? order;
  String? deviceId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Track({
    required this.id,
    required this.playlistId,
    required this.trackId,
    this.order,
    this.deviceId,
    this.createdAt,
    this.updatedAt,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json['id'],
        playlistId: json['playlist_id'],
        trackId: json['track_id'],
        order: json['order'],
        deviceId: json['device_id'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'playlist_id': playlistId,
        'track_id': trackId,
        'order': order,
        'device_id': deviceId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class Affirmation {
  int id;
  String? description;
  String? image;
  String? subForm;
  String? affirmationsDuration;
  RxBool isFavorite;
  RxBool isHidden;
  List<VoiceOption> voices;
  String? shareLink;

  Affirmation({
    required this.id,
    required this.description,
    required this.image,
    required this.subForm,
    required this.affirmationsDuration,
    required this.voices,
    required this.isFavorite,
    required this.isHidden,
    this.shareLink,
  });

  factory Affirmation.fromJson(Map<String, dynamic> json) => Affirmation(
        id: json['id'],
        description: json['description'],
        image: json['image'],
        subForm: json['sub_form'],
        affirmationsDuration: json['affirmations_duration'],
        voices: json['voices'] != null
            ? List<VoiceOption>.from(
                json['voices'].map((x) => VoiceOption.fromJson(x)))
            : [],
        isFavorite: RxBool(json['is_favorite']?.toString() == '1' ||
            json['is_favorite']?.toString() == 'true'),
        isHidden: RxBool(json['is_hidden']?.toString() == '1' ||
            json['is_hidden']?.toString() == 'true'),
        shareLink: json['share_link'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'image': image,
        'sub_form': subForm,
        'affirmations_duration': affirmationsDuration,
        'voices': voices.map((x) => x.toJson()).toList(),
        'is_favorite': isFavorite.value ? 1 : 0,
        'is_hidden': isHidden.value ? 1 : 0,
        'share_link': shareLink,
      };

  /// * Get the first valid voice URL that contains '/audio/' in its path
  String? getValidVoiceUrl() {
    final voice = voices.firstWhere(
      (voice) => voice.voiceUrl != null && voice.voiceUrl!.contains('audio/'),
      orElse: () => voices.first,
    );
    return voice.voiceUrl;
  }
}
