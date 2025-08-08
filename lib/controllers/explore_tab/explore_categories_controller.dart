import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/controllers/theme_controller.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/shared/views/blur_screen.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/playlist/by_you/controllers/by_you_by_alok_controller.dart';
import 'package:manifest/features/playlist/by_you/models/local_mp3.dart';
import 'package:manifest/features/playlist/by_you/widgets/audio_player/audio_player_screen.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/mp3_overlay_menu.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/overlay_menu.dart';
import 'dart:convert';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/explore_tab_model/featured_tab_model/featured_tab_model.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';

class ExploreCategoriesController extends GetxController {
  final ByYouByAlokController _byYouController;
  ExploreCategoriesController(this._byYouController);

  ThemeController themeController = Get.find<ThemeController>();

  /// dummy data
  final RxInt _currentTabIndex = 0.obs;
  TabController? tabController;

  int get currentTabIndex => _currentTabIndex.value;

  void changeTab(int index) {
    _currentTabIndex.value = index;
    tabController!.animateTo(index);
    update();
  }

  RxInt volume = 50.obs;
  RxBool isMusicOn = false.obs;
  RxBool isVideoOn = false.obs;

  void increaseVolume() {
    if (volume.value < 100) {
      volume.value++;
    }
  }

  void decreaseVolume() {
    if (volume.value > 0) {
      volume.value--;
    }
  }

  void toggleMusic() {
    isMusicOn.value = !isMusicOn.value;
  }

  void toggleVideo() {
    isVideoOn.value = !isVideoOn.value;
  }

  // Services and end & end point
  ApiService apiService = ApiService();

  /// * loading state variables
  RxBool isAddingToMySoundscape = false.obs;

  /// * Data variables
  Rx<FeaturedListTabModel> featuredPlaylists = FeaturedListTabModel().obs;
  Rx<SoundscapeResponseModel> soundscapeResponse =
      SoundscapeResponseModel().obs;

  RxList<Soundscape> soundscapes = <Soundscape>[].obs;

  /// * View type for My Sounds section
  RxBool isGridView = true.obs;

  /// * getter for uploaded mp3s
  RxList<LocalMp3> get mp3s => _byYouController.mp3s;

  /// * soundscape pagination variables
  int pageSize = 6;
  RxInt currentSoundscapePage = 1.obs;
  RxInt totalSoundscapes = 0.obs;
  RxInt lastSoundscapePage = 0.obs;
  RxBool isLoadingMoreSoundscapes = false.obs;

  bool get hasSoundscapeMorePages =>
      currentSoundscapePage.value < lastSoundscapePage.value;

  /// * Get soundscapes with pagination
  Future<void> getSoundscapes({bool loadMore = false}) async {
    // Don't load more if already loading or reached the end
    if (isLoadingMoreSoundscapes.value ||
        (loadMore && !hasSoundscapeMorePages)) {
      return;
    }

    try {
      if (!loadMore) {
        // isSoundscapeLoading.value = true;
        currentSoundscapePage.value = 1;
        soundscapes.clear();
      } else {
        isLoadingMoreSoundscapes.value = true;
        currentSoundscapePage.value++;
      }

      var response = await apiService.request(
        apiEndPoint:
            '${ApiService.getSoundScapes.toString()}?device_id=${LocalStorage.deviceID.toString()}&per_page=$pageSize&page=${currentSoundscapePage.value}',
        isGet: true,
        withToken: LocalStorage.userAccessToken == '' ? false : true,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var newSoundscapeResponse = SoundscapeResponseModel.fromJson(data);

        if (!loadMore) {
          soundscapeResponse.value = newSoundscapeResponse;
          if (soundscapeResponse.value.data != null) {
            soundscapes.value = soundscapeResponse.value.data!;
          }
        } else if (newSoundscapeResponse.data != null) {
          soundscapes.addAll(newSoundscapeResponse.data!);
        }

        if (newSoundscapeResponse.pagination != null) {
          currentSoundscapePage.value =
              newSoundscapeResponse.pagination!.currentPage ?? 1;
          lastSoundscapePage.value =
              newSoundscapeResponse.pagination!.lastPage ?? 0;
        }

        LogUtil.v(
            'Soundscapes loaded successfully. Page: ${currentSoundscapePage.value}');
      } else {
        LogUtil.v('Error loading soundscapes: ${response.statusCode}');
      }
    } catch (e) {
      LogUtil.v('Error loading soundscapes: $e');
    } finally {
      // isSoundscapeLoading.value = false;
      isLoadingMoreSoundscapes.value = false;
    }
  }

  /// * on mp3 more pressed
  void onMp3MorePressed(LocalMp3 mp3) {
    return AppDialogs.showBlurred(
      Obx(
        () => Stack(
          children: [
            Mp3OverlayMenu(
              titleText: mp3.name,
              subtitleText: formatDuration(mp3.duration),
              customItemsList: [
                OverlayMenuItem(
                  titleText: 'Play now',
                  iconPath: IconConstants.play,
                  onTap: () {
                    Get.off(
                      AudioPlayerScreen(
                        coverImage: AssetImage(ImageConstants.musicCover),
                        audioFile: File(mp3.path),
                        title: mp3.name,
                        onPlayerSettingsTap: () => _buildOverlayMenu(mp3),
                      ),
                    );
                  },
                ),
                OverlayMenuItem(
                  titleText: 'Add to my soundscape',
                  iconPath: IconConstants.add,
                  onTap: () async {
                    await addToMySoundscape(mp3);

                    /// * refresh the soundscape list
                    await getSoundscapes();
                  },
                ),
                OverlayMenuItem(
                  titleText: 'Rename MP3',
                  iconPath: IconConstants.rename,
                  onTap: () => AppBottomSheet.showNamingBottomSheet(
                    title: 'Rename MP3',
                    existingTitle: mp3.name,
                    onConfirm: (newName) async {
                      await Get.find<ByYouByAlokController>()
                          .renameMp3(mp3.id, newName);

                      /// * close the rename bottom sheet
                      Get.back();

                      /// * close the options menu
                      Get.back();

                      /// * close the audio player
                      Get.back();
                    },
                  ),
                ),
                OverlayMenuItem(
                  titleText: 'Delete MP3',
                  iconPath: IconConstants.delete,
                  iconColor: Colors.red,
                  onTap: () async {
                    await Get.find<ByYouByAlokController>().deleteMp3(mp3.id);

                    /// * close the options menu
                    Get.back();

                    /// * close the audio player
                    Get.back();
                  },
                ),
              ],
            ),
            if (isAddingToMySoundscape.value)
              BlurScreen(
                child: Center(
                  child: dotsWaveLoading(),
                ),
              )
          ],
        ),
      ),
    );
  }

  /// * build overlay menu
  void _buildOverlayMenu(mp3) {
    return AppDialogs.showBlurred(
      Mp3OverlayMenu(
        titleText: mp3.name,
        subtitleText: formatDuration(mp3.duration),
        onRenameTap: () => AppBottomSheet.showNamingBottomSheet(
          title: 'Rename MP3',
          existingTitle: mp3.name,
          onConfirm: (newName) async {
            await Get.find<ByYouByAlokController>().renameMp3(mp3.id, newName);

            /// * close the rename bottom sheet
            Get.back();

            /// * close the options menu
            Get.back();

            /// * close the audio player
            Get.back();
          },
        ),
        onDeleteTap: () async {
          await Get.find<ByYouByAlokController>().deleteMp3(mp3.id);

          /// * close the options menu
          Get.back();

          /// * close the audio player
          Get.back();
        },
      ),
    );
  }

  /// * get featured playlists
  Future<void> getFeaturedPlaylists() async {
    try {
      // isFeaturedLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getFeaturedData}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Data fetching of Featured Tab: ${data['message']}');
        featuredPlaylists.value = FeaturedListTabModel.fromJson(data);
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
      } else {
        LogUtil.e(
            'Error while getting Feature data of Explore: ${data['message']}');
      }
    } catch (e) {
      LogUtil.e('Error while getting Feature data of Explore: $e');
    } finally {
      // isFeaturedLoading.value = false;
    }
  }

  /// * add to mySoundscape
  Future<void> addToMySoundscape(LocalMp3 mp3) async {
    /// todo: add to mySoundscape
    try {
      isAddingToMySoundscape.value = true;
      final response = await apiService.uploadAudio(
        apiEndPoint: ApiService.createSoundScape,
        audioFile: File(mp3.path),
        additionalFields: {
          'name': mp3.name,
          'device_id': LocalStorage.deviceID.toString(),

          /// todo: add user_id
          'user_id': '',
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        /// * close the overlay menu
        Get.back();

        /// * show success message
        ToastUtil.success(data['message']);
      } else {
        /// * close the overlay menu
        Get.back();

        /// * show error message
        ToastUtil.error(data['message']);
      }
      isAddingToMySoundscape.value = false;
    } catch (e) {
      isAddingToMySoundscape.value = false;
      LogUtil.e('Error while adding to mySoundscape: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();

    /// * get data for [explore, featured, soundscapes] tabs
    getFeaturedPlaylists();
    getSoundscapes();
  }
}
