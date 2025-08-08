import 'package:get/get.dart';

mixin MediaPlayerLoadingStateMixin {
  // Loading states for explore-related operations
  final RxBool isPlayerDataLoading = false.obs;
  final RxBool isTogglingFavorite = false.obs;
  final RxBool isFetchingFeaturedData = false.obs;
  final RxBool isSearchingCategories = false.obs;
  final RxBool isFetchingGoalCategories = false.obs;
  final RxBool isSavingGoalCategories = false.obs;
  final RxBool isFetchingCategoryDetailById = false.obs;

  // New loading states for see all screens
  final RxBool isFetchingPlaylistSeeAll = false.obs;
  final RxBool isFetchingTrackSeeAll = false.obs;

  // Refresh states for explore-related operations
  final RxBool isRefreshingExploreData = false.obs;
  final RxBool isRefreshingCategories = false.obs;
  final RxBool isRefreshingFeaturedData = false.obs;
  final RxBool isRefreshingSearchCategories = false.obs;
  final RxBool isRefreshingGoalCategories = false.obs;
  final RxBool isRefreshingSavingGoalCategories = false.obs;
  final RxBool isRefreshingCategoryDetailById = false.obs;

  // New refresh states for see all screens
  final RxBool isRefreshingPlaylistSeeAll = false.obs;
  final RxBool isRefreshingTrackSeeAll = false.obs;

  // Methods to start and stop loading states for categories
  void startFetchingCategories() => isTogglingFavorite.value = true;
  void stopFetchingCategories() => isTogglingFavorite.value = false;

  // Methods to start and stop refresh states for categories
  void startRefreshingCategories() => isRefreshingCategories.value = true;
  void stopRefreshingCategories() => isRefreshingCategories.value = false;

  // Methods to start and stop loading states for explore data
  void startExploreDataLoading() => isPlayerDataLoading.value = true;
  void stopExploreDataLoading() => isPlayerDataLoading.value = false;

  // Methods to start and stop refresh states for explore data
  void startRefreshingExploreData() => isRefreshingExploreData.value = true;
  void stopRefreshingExploreData() => isRefreshingExploreData.value = false;

  // Methods to start and stop loading states for featured data
  void startFetchingFeaturedData() => isFetchingFeaturedData.value = true;
  void stopFetchingFeaturedData() => isFetchingFeaturedData.value = false;

  // Methods to start and stop refresh states for featured data
  void startRefreshingFeaturedData() => isRefreshingFeaturedData.value = true;
  void stopRefreshingFeaturedData() => isRefreshingFeaturedData.value = false;

  // Methods to start and stop loading states for searching
  void startSearchingCategories() => isSearchingCategories.value = true;
  void stopSearchingCategories() => isSearchingCategories.value = false;

  // Methods to start and stop refresh states for searching
  void startRefreshingSearchCategories() => isRefreshingSearchCategories.value = true;
  void stopRefreshingSearchCategories() => isRefreshingSearchCategories.value = false;

  // Methods to start and stop loading states for goal categories
  void startFetchingGoalCategories() => isFetchingGoalCategories.value = true;
  void stopFetchingGoalCategories() => isFetchingGoalCategories.value = false;

  // Methods to start and stop refresh states for goal categories
  void startRefreshingGoalCategories() => isRefreshingGoalCategories.value = true;
  void stopRefreshingGoalCategories() => isRefreshingGoalCategories.value = false;

  void startSavingGoalCategories() => isSavingGoalCategories.value = true;
  void stopSavingGoalCategories() => isSavingGoalCategories.value = false;

  // Methods to start and stop refresh states for saving goal categories
  void startRefreshingSavingGoalCategories() => isRefreshingSavingGoalCategories.value = true;
  void stopRefreshingSavingGoalCategories() => isRefreshingSavingGoalCategories.value = false;

  // Methods to start and stop loading states for category detail
  void startFetchingCategoryDetailById() => isFetchingCategoryDetailById.value = true;
  void stopFetchingCategoryDetailById() => isFetchingCategoryDetailById.value = false;

  // Methods to start and stop refresh states for category detail
  void startRefreshingCategoryDetailById() => isRefreshingCategoryDetailById.value = true;
  void stopRefreshingCategoryDetailById() => isRefreshingCategoryDetailById.value = false;

  // Methods to start and stop loading states for playlist see all
  void startFetchingPlaylistSeeAll() => isFetchingPlaylistSeeAll.value = true;
  void stopFetchingPlaylistSeeAll() => isFetchingPlaylistSeeAll.value = false;

  // Methods to start and stop refresh states for playlist see all
  void startRefreshingPlaylistSeeAll() => isRefreshingPlaylistSeeAll.value = true;
  void stopRefreshingPlaylistSeeAll() => isRefreshingPlaylistSeeAll.value = false;

  // Methods to start and stop loading states for track see all
  void startFetchingTrackSeeAll() => isFetchingTrackSeeAll.value = true;
  void stopFetchingTrackSeeAll() => isFetchingTrackSeeAll.value = false;

  // Methods to start and stop refresh states for track see all
  void startRefreshingTrackSeeAll() => isRefreshingTrackSeeAll.value = true;
  void stopRefreshingTrackSeeAll() => isRefreshingTrackSeeAll.value = false;
} 