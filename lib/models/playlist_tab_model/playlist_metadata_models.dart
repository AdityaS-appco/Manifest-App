import 'package:manifest/models/explore_tab_model/explore_tab/explore_playlist_by_id_model.dart';

/// Metadata model for favorite affirmations
class FavoriteAffirmationsMetaModel {
  final String titleMeta;
  final int affirmationCountMeta;
  final int durationInSecondsMeta;

  const FavoriteAffirmationsMetaModel({
    this.titleMeta = 'Favorite Affirmations',
    this.affirmationCountMeta = 0,
    this.durationInSecondsMeta = 0,
  });

  factory FavoriteAffirmationsMetaModel.fromJson(Map<String, dynamic> json) {
    return FavoriteAffirmationsMetaModel(
      titleMeta: json['title'] ?? 'Favorite Affirmations',
      affirmationCountMeta: json['affirmation_count'] ?? 0,
      durationInSecondsMeta: json['duration_in_seconds'] ?? 0,
    );
  }

  FavoriteAffirmationsMetaModel copyWith({
    String? titleMeta,
    int? affirmationCountMeta,
    int? durationInSecondsMeta,
  }) {
    return FavoriteAffirmationsMetaModel(
      titleMeta: titleMeta ?? this.titleMeta,
      affirmationCountMeta: affirmationCountMeta ?? this.affirmationCountMeta,
      durationInSecondsMeta: durationInSecondsMeta ?? this.durationInSecondsMeta,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': titleMeta,
      'affirmation_count': affirmationCountMeta,
      'duration_in_seconds': durationInSecondsMeta,
    };
  }
}

/// Metadata model for favorite tracks
class FavoriteTracksMetaModel {
  final String titleMeta;
  final int affirmationCountMeta;
  final int durationInSecondsMeta;

  const FavoriteTracksMetaModel({
    this.titleMeta = 'Favorite Tracks',
    this.affirmationCountMeta = 0,
    this.durationInSecondsMeta = 0,
  });

  factory FavoriteTracksMetaModel.fromJson(Map<String, dynamic> json) {
    return FavoriteTracksMetaModel(
      titleMeta: json['title'] ?? 'Favorite Tracks',
      affirmationCountMeta: json['affirmation_count'] ?? 0,
      durationInSecondsMeta: json['duration_in_seconds'] ?? 0,
    );
  }

  FavoriteTracksMetaModel copyWith({
    String? titleMeta,
    int? affirmationCountMeta,
    int? durationInSecondsMeta,
  }) {
    return FavoriteTracksMetaModel(
      titleMeta: titleMeta ?? this.titleMeta,
      affirmationCountMeta: affirmationCountMeta ?? this.affirmationCountMeta,
      durationInSecondsMeta: durationInSecondsMeta ?? this.durationInSecondsMeta,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': titleMeta,
      'affirmation_count': affirmationCountMeta,
      'duration_in_seconds': durationInSecondsMeta,
    };
  }
}

/// Metadata model for collections
class MyCollectionsMetaModel {
  final String titleMeta;
  final int collectionCountMeta;

  const MyCollectionsMetaModel({
    this.titleMeta = 'My Collection',
    this.collectionCountMeta = 0,
  });

  factory MyCollectionsMetaModel.fromJson(Map<String, dynamic> json) {
    return MyCollectionsMetaModel(
      titleMeta: json['title'] ?? 'My Collection',
      collectionCountMeta: json['collection_count'] ?? 0,
    );
  }

  MyCollectionsMetaModel copyWith({
    String? titleMeta,
    int? collectionCountMeta,
  }) {
    return MyCollectionsMetaModel(
      titleMeta: titleMeta ?? this.titleMeta,
      collectionCountMeta: collectionCountMeta ?? this.collectionCountMeta,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': titleMeta,
      'collection_count': collectionCountMeta,
    };
  }
}

/// Metadata model for favorite playlists
class FavoritePlaylistsMetaModel {
  final String titleMeta;
  final int playlistCountMeta;
  final int durationInSecondsMeta;

  const FavoritePlaylistsMetaModel({
    this.titleMeta = 'Favorite Playlists',
    this.playlistCountMeta = 0,
    this.durationInSecondsMeta = 0,
  });

  factory FavoritePlaylistsMetaModel.fromJson(Map<String, dynamic> json) {
    return FavoritePlaylistsMetaModel(
      titleMeta: json['title'] ?? 'Favorite Playlists',
      playlistCountMeta: json['playlist_count'] ?? 0,
      durationInSecondsMeta: json['duration_in_seconds'] ?? 0,
    );
  }

  FavoritePlaylistsMetaModel copyWith({
    String? titleMeta,
    int? playlistCountMeta,
    int? durationInSecondsMeta,
  }) {
    return FavoritePlaylistsMetaModel(
      titleMeta: titleMeta ?? this.titleMeta,
      playlistCountMeta: playlistCountMeta ?? this.playlistCountMeta,
      durationInSecondsMeta: durationInSecondsMeta ?? this.durationInSecondsMeta,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': titleMeta,
      'playlist_count': playlistCountMeta,
      'duration_in_seconds': durationInSecondsMeta,
    };
  }
}

/// Metadata model for playlist data
class PlaylistDataMetaModel {
  final FavoriteAffirmationsMetaModel favoriteAffirmations;
  final FavoriteTracksMetaModel favoriteTracks;
  final MyCollectionsMetaModel myCollections;
  final FavoritePlaylistsMetaModel favoritePlaylists;
  final List<Playlist> content;

  const PlaylistDataMetaModel({
    required this.favoriteAffirmations,
    required this.favoriteTracks,
    required this.myCollections,
    required this.favoritePlaylists,
    this.content = const [],
  });

  factory PlaylistDataMetaModel.fromJson(Map<String, dynamic> json) {
    return PlaylistDataMetaModel(
      favoriteAffirmations: FavoriteAffirmationsMetaModel.fromJson(
        (json['favorite_affirmations'] as List).first ?? const FavoriteAffirmationsMetaModel(),
      ),
      favoriteTracks: FavoriteTracksMetaModel.fromJson(
        (json['favorite_tracks'] as List).first ?? const FavoriteTracksMetaModel(),
      ),
      myCollections: MyCollectionsMetaModel.fromJson(
        (json['my_collection'] as List).first ?? const MyCollectionsMetaModel(),
      ),
      favoritePlaylists: FavoritePlaylistsMetaModel.fromJson(
        (json['favorite_playlist'] as List).first ?? const FavoritePlaylistsMetaModel(),
      ),
      content: (json['content'] as List?)?.map((e) => Playlist.fromJson(e)).toList() ?? [],
    );
  }

  PlaylistDataMetaModel copyWith({
    FavoriteAffirmationsMetaModel? favoriteAffirmations,
    FavoriteTracksMetaModel? favoriteTracks,
    MyCollectionsMetaModel? myCollections,
    FavoritePlaylistsMetaModel? favoritePlaylists,
    List<Playlist>? content,
  }) {
    return PlaylistDataMetaModel(
      favoriteAffirmations: favoriteAffirmations ?? this.favoriteAffirmations,
      favoriteTracks: favoriteTracks ?? this.favoriteTracks,
      myCollections: myCollections ?? this.myCollections,
      favoritePlaylists: favoritePlaylists ?? this.favoritePlaylists,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorite_affirmations': [favoriteAffirmations.toJson()],
      'favorite_tracks': [favoriteTracks.toJson()],
      'my_collection': [myCollections.toJson()],
      'favorite_playlist': [favoritePlaylists.toJson()],
      'content': content,
    };
  }
} 