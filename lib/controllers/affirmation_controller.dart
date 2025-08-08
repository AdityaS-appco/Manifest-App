import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/controllers/theme_controller.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/created_playlist_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';

class AffirmationController extends GetxController with ProfileControllerMixin {
  HomeTwoController homeController = Get.find<HomeTwoController>();
  ThemeController themeController = Get.find<ThemeController>();
  PlaylistTabController playlistTabController =
      Get.find<PlaylistTabController>();

  final RxInt _currentTab = 0.obs;
  int get getCurrentTab => _currentTab.value;
  void setCurrentTab(int index) {
    _currentTab.value = index;
    update();
  }

  final RxInt _selectCreatedPlaylist = 0.obs;
  int get getSelectCreatedPlaylist => _selectCreatedPlaylist.value;
  void setSelectedPlaylist({required int value}) {
    _selectCreatedPlaylist.value = value;
    update();
  }

  RxBool isProfileLoading = false.obs;
  ApiService apiService = ApiService();

  TextEditingController nameOfPlaylistController = TextEditingController();

  Rx<PlaylistResponseModel> playlistResponse = PlaylistResponseModel().obs;

  RxBool isNewPlaylistLoading = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    // getPlayLists();
  }

  Future<void> createNewPlayList() async {
    LoadingUtil.show();
    try {
      Map<String, dynamic> body = {
        'name': nameOfPlaylistController.text,
        'device_id': LocalStorage.deviceID.toString(),
      };
      var response = await apiService.request(
          apiEndPoint: ApiService.createPlaylist,
          data: body,
          isPost: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('successfully PlayList created');
        ToastUtil.success(data['message']);
        nameOfPlaylistController.clear();
        getPlayLists();
        LoadingUtil.dismiss();
        Get.back();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        LogUtil.e('Error while trying to add playlist in recent');
        ToastUtil.error(
            'Something went wrong from server side please try again');
        LoadingUtil.dismiss();
      }
    } catch (e) {
      LogUtil.e('Error while creating playlist: $e');
      LoadingUtil.dismiss();
    }
  }

  Future<void> getPlayLists() async {
    try {
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getPlaylists}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      if (response.statusCode == 200) {
        playlistResponse.value =
            PlaylistResponseModel.fromJson(json.decode(response.body));
        LogUtil.e('getting created playlists by users');
      } else {
        LogUtil.e('something error while getting created playlists');
      }
    } catch (e) {
      LogUtil.e('error while getting created playlists: $e');
    }
  }

  Future<void> addAffirmationToPlaylist({required var affirmationID}) async {
    Map<String, dynamic> body = {
      'device_id': LocalStorage.deviceID.toString(),
      'user_id': profile.id,
      'play_list_id': getSelectCreatedPlaylist,
      'affirmation_content_id': affirmationID,
    };
    try {
      LoadingUtil.show();
      var response = await apiService.request(
          apiEndPoint: ApiService.addAffirmationToCreatedPlaylist,
          data: body,
          isPost: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('affirmation add to playlist : ${response.body}');
        LoadingUtil.dismiss();
        ToastUtil.success(data['message']);
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        LogUtil.e(
            'unsuccessful operation to add affirmation in playlist: ${data['message']} ');
        LoadingUtil.dismiss();
        ToastUtil.error(data['message']);
      } else {
        LogUtil.e('unsuccessful operation to add affirmation in playlist');
        LoadingUtil.dismiss();
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.e('Error while adding to favorite in playlist: $e');
      LoadingUtil.dismiss();
      ToastUtil.error('Something is wrong');
    }
  }
}
