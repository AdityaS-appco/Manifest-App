import 'package:get/get.dart';

mixin PlaylistLoadingStateMixin {
  /// Initial loading state for playlist data
  final RxBool _isInitialLoading = false.obs;
  final RxBool _isRefreshingPlaylistData = false.obs;
  final RxBool _isFetchingPlaylistData = false.obs;

  RxBool get isInitialLoadingRx => _isInitialLoading;
  RxBool get isRefreshingPlaylistDataRx => _isRefreshingPlaylistData;
  RxBool get isFetchingPlaylistDataRx => _isFetchingPlaylistData;

  bool get isInitialLoading => _isInitialLoading.value;
  bool get isRefreshingPlaylistData => _isRefreshingPlaylistData.value;
  bool get isFetchingPlaylistData => _isFetchingPlaylistData.value;

  void startInitialLoading() {
    _isInitialLoading.value = true;
  }

  void stopInitialLoading() {
    _isInitialLoading.value = false;
  }

  void startRefreshingPlaylistData() {
    _isRefreshingPlaylistData.value = true;
  }

  void stopRefreshingPlaylistData() {
    _isRefreshingPlaylistData.value = false;
  }

  void startFetchingPlaylistData() {
    _isFetchingPlaylistData.value = true;
  }

  void stopFetchingPlaylistData() {
    _isFetchingPlaylistData.value = false;
  }

  /// Loading state for specific playlist operations
  final RxBool _isLoadingFavoriteAffirmations = false.obs;
  final RxBool _isLoadingFavoriteTracks = false.obs;
  final RxBool _isLoadingCollections = false.obs;
  final RxBool _isLoadingFavoritePlaylists = false.obs;
  final RxBool _isLoadingByYouContent = false.obs;

  RxBool get isLoadingFavoriteAffirmationsRx => _isLoadingFavoriteAffirmations;
  RxBool get isLoadingFavoriteTracksRx => _isLoadingFavoriteTracks;
  RxBool get isLoadingCollectionsRx => _isLoadingCollections;
  RxBool get isLoadingFavoritePlaylistsRx => _isLoadingFavoritePlaylists;
  RxBool get isLoadingByYouContentRx => _isLoadingByYouContent;

  bool get isLoadingFavoriteAffirmations => _isLoadingFavoriteAffirmations.value;
  bool get isLoadingFavoriteTracks => _isLoadingFavoriteTracks.value;
  bool get isLoadingCollections => _isLoadingCollections.value;
  bool get isLoadingFavoritePlaylists => _isLoadingFavoritePlaylists.value;
  bool get isLoadingByYouContent => _isLoadingByYouContent.value;

  void startLoadingFavoriteAffirmations() {
    _isLoadingFavoriteAffirmations.value = true;
  }

  void stopLoadingFavoriteAffirmations() {
    _isLoadingFavoriteAffirmations.value = false;
  }

  void startLoadingFavoriteTracks() {
    _isLoadingFavoriteTracks.value = true;
  }

  void stopLoadingFavoriteTracks() {
    _isLoadingFavoriteTracks.value = false;
  }

  void startLoadingCollections() {
    _isLoadingCollections.value = true;
  }

  void stopLoadingCollections() {
    _isLoadingCollections.value = false;
  }

  void startLoadingFavoritePlaylists() {
    _isLoadingFavoritePlaylists.value = true;
  }

  void stopLoadingFavoritePlaylists() {
    _isLoadingFavoritePlaylists.value = false;
  }

  void startLoadingByYouContent() {
    _isLoadingByYouContent.value = true;
  }

  void stopLoadingByYouContent() {
    _isLoadingByYouContent.value = false;
  }
} 