import 'package:get/get.dart';

mixin SoundscapeLoadingStateMixin {
  // Loading states for soundscape-related operations
  final RxBool isSoundscapeLoading = false.obs;
  final RxBool isFetchingSoundscapes = false.obs;
  final RxBool isLoadingMoreSoundscapes = false.obs;
  final RxBool isFetchingSoundscapeTags = false.obs;

  // Refresh states for soundscape-related operations
  final RxBool isRefreshingSoundscapes = false.obs;
  final RxBool isRefreshingSoundscapeTags = false.obs;

  // Favorite and download states
  final RxBool isAddingToFavorites = false.obs;
  final RxBool isRemovingFromFavorites = false.obs;
  final RxBool isDownloadingSoundscape = false.obs;
  final RxBool isRemovingDownloadedSoundscape = false.obs;

  // New loading state for adding to soundscape
  final RxBool isAddingToMySoundscape = false.obs;

  // Methods to start and stop loading states for soundscapes
  void startSoundscapeLoading() => isSoundscapeLoading.value = true;
  void stopSoundscapeLoading() => isSoundscapeLoading.value = false;

  void startFetchingSoundscapes() => isFetchingSoundscapes.value = true;
  void stopFetchingSoundscapes() => isFetchingSoundscapes.value = false;

  void startLoadingMoreSoundscapes() => isLoadingMoreSoundscapes.value = true;
  void stopLoadingMoreSoundscapes() => isLoadingMoreSoundscapes.value = false;

  void startFetchingSoundscapeTags() => isFetchingSoundscapeTags.value = true;
  void stopFetchingSoundscapeTags() => isFetchingSoundscapeTags.value = false;

  // Methods to start and stop refresh states for soundscapes
  void startRefreshingSoundscapes() => isRefreshingSoundscapes.value = true;
  void stopRefreshingSoundscapes() => isRefreshingSoundscapes.value = false;

  void startRefreshingSoundscapeTags() => isRefreshingSoundscapeTags.value = true;
  void stopRefreshingSoundscapeTags() => isRefreshingSoundscapeTags.value = false;

  // Methods for favorite operations
  void startAddingToFavorites() => isAddingToFavorites.value = true;
  void stopAddingToFavorites() => isAddingToFavorites.value = false;

  void startRemovingFromFavorites() => isRemovingFromFavorites.value = true;
  void stopRemovingFromFavorites() => isRemovingFromFavorites.value = false;

  // Methods for download operations
  void startDownloadingSoundscape() => isDownloadingSoundscape.value = true;
  void stopDownloadingSoundscape() => isDownloadingSoundscape.value = false;

  void startRemovingDownloadedSoundscape() => isRemovingDownloadedSoundscape.value = true;
  void stopRemovingDownloadedSoundscape() => isRemovingDownloadedSoundscape.value = false;

  // Methods for adding to soundscape
  void startAddingToMySoundscape() => isAddingToMySoundscape.value = true;
  void stopAddingToMySoundscape() => isAddingToMySoundscape.value = false;
} 