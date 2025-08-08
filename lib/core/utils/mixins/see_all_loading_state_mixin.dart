import 'package:get/get.dart';

mixin SeeAllLoadingStateMixin {
  // Loading states for see all operations
  final RxBool isFetchingSeeAllData = false.obs;
  final RxBool isRefreshingSeeAllData = false.obs;

  // Methods to start and stop loading states for see all data
  void startFetchingSeeAllData() => isFetchingSeeAllData.value = true;
  void stopFetchingSeeAllData() => isFetchingSeeAllData.value = false;

  // Methods to start and stop refresh states for see all data
  void startRefreshingSeeAllData() => isRefreshingSeeAllData.value = true;
  void stopRefreshingSeeAllData() => isRefreshingSeeAllData.value = false;
} 