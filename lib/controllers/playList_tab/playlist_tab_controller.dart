import 'dart:convert';
import 'dart:io';
import 'package:manifest/controllers/download/download_controller.dart';
import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/features/explore/views/playlist_details_screen.dart';
import 'package:manifest/features/playlist/by_you/controllers/by_you_by_alok_controller.dart';
import 'package:manifest/features/playlist/by_you/models/local_recording.dart';
import 'package:manifest/features/playlist/playlist_type.enum.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/explore_tab_model/explore_tab/explore_playlist_by_id_model.dart';
import 'package:manifest/models/explore_tab_model/featured_tab_model/get_tracks_by_id_model.dart';
import 'package:manifest/models/playlist_tab_model/admin_playlist_model.dart';
import 'package:manifest/models/playlist_tab_model/by_you/recorded_list_model.dart';
import 'package:manifest/models/playlist_tab_model/by_you/recordings_list_of_model_by_id.dart';
import 'package:manifest/models/playlist_tab_model/create_or_update_playlist_model.dart';
import 'package:manifest/models/playlist_tab_model/favorite_playlist_model/favorite_playlist_model.dart';
import 'package:manifest/models/playlist_tab_model/favorite_tracks_playlist_model/favorite_tracks_playlist_model.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/affirmation_list_model.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/collection_by_id_model.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/my_collections_model.dart';
import 'package:manifest/models/playlist_tab_model/palyList_home_model.dart';
import 'package:manifest/models/playlist_tab_model/playlist_by_id_model.dart';
import 'package:manifest/models/playlist_tab_model/tracks_list_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/view/navbar_screens/playlist/explore_playlist_page.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/collection_detail_screen.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/playlist_service.dart';
import 'package:manifest/core/utils/mixins/playlist_loading_state_mixin.dart';
import 'package:manifest/models/playlist_tab_model/playlist_metadata_models.dart';

class PlaylistTabController extends BaseController
    with
        GetTickerProviderStateMixin,
        PlaylistLoadingStateMixin,
        ProfileControllerMixin {
  // * @author: alok singh
  // * recording duration for voice recorder
  RxList<LocalRecording> recordingsList = RxList.empty();

  // edt bool for playlist or collection
  RxBool isEdit = false.obs;
  void setEditValue({required bool value}) {
    isEdit.value = value;
    LogUtil.v('aaa $isEdit');
  }

  RxBool isRenameEdit = false.obs;
  void setRenameEditValue({required bool value}) {
    isRenameEdit.value = value;
  }

  // selected tracks id:  for add tracks to playlist
  final List<int> selectedTrackIds = [];

  // selected affirmation id: for add affirmation to collection
  final List<int> selectedAffirmationIDs = [];

  final RxBool _isAppBarPinned = true.obs;
  get isAppBarPinned => _isAppBarPinned.value;

  //finding controller
  HomeTwoController homeController = Get.find<HomeTwoController>();
  ApiService apiService = ApiService();

  // for create new playlist
  TextEditingController newPlaylistName = TextEditingController();
  // for create new collection
  TextEditingController newCollectionName = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // Create New Playlist Model
  final Rx<CreateOrUpdatePlaylist> _createOrUpdatePlaylist =
      CreateOrUpdatePlaylist().obs;
  CreateOrUpdatePlaylist get createOrUpdatePlaylist =>
      _createOrUpdatePlaylist.value;

  // Created Playlists by users
  final Rx<CreatedPlaylistsModel> _createdPlaylist =
      CreatedPlaylistsModel().obs;
  CreatedPlaylistsModel get createdPlaylistsModel => _createdPlaylist.value;

  // favorite affirmations  playlist
  final Rx<FavoritePlaylistModel> _favoritePlaylist =
      FavoritePlaylistModel().obs;
  FavoritePlaylistModel get favoritePlaylist => _favoritePlaylist.value;

  // favorite tracks playlist
  final Rx<FavoriteTracksPlaylistModel> _favoriteTracks =
      FavoriteTracksPlaylistModel().obs;
  FavoriteTracksPlaylistModel get favoriteTracks => _favoriteTracks.value;

  // Playlists by Admin
  final Rx<AdminPlaylistModel> _adminPlaylists = AdminPlaylistModel().obs;
  AdminPlaylistModel get adminPlaylists => _adminPlaylists.value;
  Rx<AdminPlaylistModel> filteredAdminPlaylists = AdminPlaylistModel().obs;
  // play list by id
  final Rx<PlaylistByIDModel> _playlistByID = PlaylistByIDModel().obs;
  PlaylistByIDModel get playlistByID => _playlistByID.value;

  // Tracks List
  final Rx<TracksListModel> _tracksList = TracksListModel().obs;
  TracksListModel get tracksList => _tracksList.value;

  // My Collections List
  final Rx<CollectionResponseModel> _myCollections =
      CollectionResponseModel().obs;
  CollectionResponseModel get myCollections => _myCollections.value;

  // collections by id
  final Rx<CollectionByIDModel> _getCollectionByID = CollectionByIDModel().obs;
  CollectionByIDModel get collectionByID => _getCollectionByID.value;

  final Rx<AffirmationListModel> _getAffirmationList =
      AffirmationListModel().obs;
  AffirmationListModel get affirmationList => _getAffirmationList.value;

  // Get list of Recorded Voice
  final Rx<RecordingsListModel> _recordedLists = RecordingsListModel().obs;
  RecordingsListModel get recordedList => _recordedLists.value;

  // Get list of Recorded Voice by id
  final Rx<RecordingsListModelByID> _recordedListsByID =
      RecordingsListModelByID().obs;
  RecordingsListModelByID get recordedListByID => _recordedListsByID.value;
  // tracks by id
  final Rx<TracksListResponseModel> _getTracksByID =
      TracksListResponseModel().obs;
  TracksListResponseModel get getTracksByID => _getTracksByID.value;

  // Search functionality
  RxString searchQuery = ''.obs;
  RxBool showSearchResults = false.obs;

  // Tab Controller
  late TabController tabController;
  RxInt currentTabIndex = 0.obs;

  // Initialize PlaylistService within the class
  final PlaylistService _playlistService = PlaylistService();

  // Playlist data from service
  final Rxn<PlaylistDataMetaModel> _myPlaylistData =
      Rxn<PlaylistDataMetaModel>();

  /// Getter for favorite affirmations metadata
  FavoriteAffirmationsMetaModel get favoriteAffirmationsMeta =>
      _myPlaylistData.value?.favoriteAffirmations ??
      const FavoriteAffirmationsMetaModel();

  /// Getter for favorite tracks metadata
  FavoriteTracksMetaModel get favoriteTracksMeta =>
      _myPlaylistData.value?.favoriteTracks ?? const FavoriteTracksMetaModel();

  /// Getter for my collections metadata
  MyCollectionsMetaModel get myCollectionsMeta =>
      _myPlaylistData.value?.myCollections ?? const MyCollectionsMetaModel();

  /// Getter for favorite playlists metadata
  FavoritePlaylistsMetaModel get favoritePlaylistsMeta =>
      _myPlaylistData.value?.favoritePlaylists ??
      const FavoritePlaylistsMetaModel();

  /// Getter for playlist content
  List<Playlist> get playlistContent => _myPlaylistData.value?.content ?? [];

  List<dynamic> byYouContent = [];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    tabController.addListener(_handleTabChange);
    selectedTrackIds.clear();

    getMyPlaylistData();
  }

  /// * Get the data for the all tab of my playlist
  Future<void> getMyPlaylistData({bool isRefresh = false}) async {
    try {
      // Reset error message
      errorMessage.value = '';

      // Start loading state
      if (isRefresh) {
        startRefreshingPlaylistData();
      } else {
        startInitialLoading();
        startFetchingPlaylistData();
      }

      // Call service method to fetch playlist data
      final result = await _playlistService.getMyPlaylistData(profile.id!);

      result.fold(
        onFailure: (failure) {
          // Stop loading and handle failure
          if (isRefresh) {
            stopRefreshingPlaylistData();
          } else {
            stopInitialLoading();
            stopFetchingPlaylistData();
          }
          handleFailure(failure.message, showToast: true);
        },
        onSuccess: (data) {
          _myPlaylistData.value = data;

          // Stop loading
          if (isRefresh) {
            stopRefreshingPlaylistData();
          } else {
            stopInitialLoading();
            stopFetchingPlaylistData();
          }
        },
      );
    } catch (e) {
      // Handle any unexpected errors
      if (isRefresh) {
        stopRefreshingPlaylistData();
      } else {
        stopInitialLoading();
        stopFetchingPlaylistData();
      }
      LogUtil.e('Error fetching playlist data: $e');
      ToastUtil.error('Failed to load playlist data');
    }
  }

  void _handleTabChange() {
    if (tabController.indexIsChanging) {
      currentTabIndex.value = tabController.index;
      update();
    }
  }

  /// All Tab

  /// Add affirmations to favorite playlist
  Future<void> addAffirmationToFavorite({required String affirmationID}) async {
    Map<String, dynamic> body = {
      'device_id': LocalStorage.deviceID.toString(),
      'affirmation_content_id': affirmationID,
    };
    try {
      isLoading.value = true;
      var response = await apiService.request(
          apiEndPoint: ApiService.addAffirmationToFavorite,
          data: body,
          isPost: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LogUtil.v('affirmation ${data['message']}');
        getFavoriteAffirmations();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        isLoading.value = false;
        LogUtil.v('unsuccessful operation favorites: ${data['message']} ');
      } else {
        isLoading.value = false;
        LogUtil.v('unsuccessful operation about favorites');
      }
    } catch (e) {
      LogUtil.v('Error while adding to favorite: $e');
    }
  }

  /// Get Favorite Affirmations
  RxBool isFavoriteAffirmationLoading = false.obs;
  Future<void> getFavoriteAffirmations() async {
    try {
      isFavoriteAffirmationLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getFavoriteAffirmations}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isFavoriteAffirmationLoading.value = false;
        LogUtil.v(
            'Data fetching of favorite affirmation playlist: ${data['message']}');
        _favoritePlaylist.value = FavoritePlaylistModel.fromJson(data);
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        isFavoriteAffirmationLoading.value = false;
        ToastUtil.error(data['message']);
      } else {
        isFavoriteAffirmationLoading.value = false;
        LogUtil.e('Error while Data fetching favorite affirmation playlist');
        ToastUtil.error(
            'Something went wrong while favorite affirmation playlist from server side please try again');
      }
    } catch (e) {
      LogUtil.v('error while getting favorite affirmation playlist: $e');
    }
  }

  /// Add tracks to favorite
  RxBool isAddTrackToFavoriteLoading = false.obs;
  Future<void> addTrackToFavorite({required String affirmationID}) async {
    Map<String, dynamic> body = {
      'device_id': LocalStorage.deviceID.toString(),
      'track_id': affirmationID,
    };
    try {
      isAddTrackToFavoriteLoading.value = true;
      var response = await apiService.request(
          apiEndPoint: ApiService.addTrackToFavorite,
          data: body,
          isPost: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        isAddTrackToFavoriteLoading.value = false;
        LogUtil.v('Track added to favorite track playlist: ${data['message']}');
        getFavoriteAffirmations();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        isAddTrackToFavoriteLoading.value = false;
        LogUtil.v('unsuccessful operation favorites: ${data['message']} ');
      } else {
        isAddTrackToFavoriteLoading.value = false;
        LogUtil.v('unsuccessful operation about favorites');
      }
    } catch (e) {
      isAddTrackToFavoriteLoading.value = false;
      LogUtil.v('Error while adding to favorite: $e');
    }
  }

  /// Get Favorite Tracks
  RxBool isFavoriteTrackLoading = false.obs;
  Future<void> getFavoriteTracks() async {
    try {
      isFavoriteTrackLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getFavoriteTracks}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isFavoriteTrackLoading.value = false;
        LogUtil.v('Data fetching of favorite Track playlist');
        _favoriteTracks.value = FavoriteTracksPlaylistModel.fromJson(data);
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        isFavoriteTrackLoading.value = false;
        ToastUtil.error(data['message']);
      } else {
        isFavoriteTrackLoading.value = false;
        LogUtil.e('Error while Data fetching favorite track playlist');
        ToastUtil.error(
            'Something went wrong while favorite track playlist getting: from server side please try again');
      }
    } catch (e) {
      LogUtil.v('error while getting favorite affirmation playlist: $e');
    }
  }

  /// Get tracks by id
  RxBool isTrackByIdLoading = false.obs;
  Future<void> getTrackByID({required String trackID}) async {
    try {
      LogUtil.v('Track Id $trackID');
      isTrackByIdLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              "${ApiService.trackById}$trackID?device_id=${LocalStorage.deviceID.toString()}&language=${LocalStorage.appLanguage.toString()}",
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v(
            'successful operation for getting track id: ${data['message']}');
        _getTracksByID.value = TracksListResponseModel.fromJson(data);
        isTrackByIdLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        LogUtil.v(
            'Network error while getting track by id: ${data['message']}');
        isTrackByIdLoading.value = false;
        ToastUtil.error(data['message']);
      } else {
        LogUtil.v('error while getting track by id');
        isTrackByIdLoading.value = false;
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.v('error while getting track by id: $e');
      isTrackByIdLoading.value = false;
    }
  }

  /// Admin Playlists
  RxBool isAdminPlaylistLoading = false.obs;
  Future<void> getAdminPlaylists() async {
    try {
      isAdminPlaylistLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getAdminPlaylists}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Data fetching of Admin playlist tab');
        _adminPlaylists.value = AdminPlaylistModel.fromJson(data);
        isAdminPlaylistLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        isAdminPlaylistLoading.value = false;
      } else {
        LogUtil.e('Error while Data fetching of playlist tab');
        ToastUtil.error(
            'Something went wrong from server side please try again');
        isAdminPlaylistLoading.value = false;
      }
    } catch (e) {
      LogUtil.v('error while getting ready playlists: $e');
    }
  }

  int? createdPlaylistID;

  /// Create or update New Playlist
  Future<void> createOrUpdateNewPlaylist({
    String? name,
    String? playlistID,
    bool isEditing = false,
    File? image,
  }) async {
    Map<String, dynamic> body = {
      'id': isEditing == false ? '' : playlistID.toString(),
      'name': isEditing == false ? newPlaylistName.text : name.toString(),
      'device_id': LocalStorage.deviceID.toString(),
      'user_id': profile.id.toString(),
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.request(
        apiEndPoint:
            '${ApiService.createPlaylist}?device_id=${LocalStorage.deviceID.toString()}&user_id=${profile.id.toString()}',
        isPost: true,
        data: body,
        withToken: LocalStorage.userAccessToken == '' ? false : true,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (isEditing == false) {
          // createdPlaylistID = data['data']['id'];
          // // _createOrUpdatePlaylist.value = CreateOrUpdatePlaylist.fromJson(data);
          // LogUtil.v('successfully PlayList created');
          // Navigator.pop(Get.context!);
          // ToastUtil.success(data['message']);
          // newPlaylistName.clear();
          // getListOfTracks(needLoading: true);
          // getCreatedPlaylists();
          // getPlaylistByID(playlistID: createdPlaylistID.toString());
          // CustomLoading().dismiss();
          // Get.to(() => const ExplorePlaylistPage());
          /// * parse the response data to new playlist
          final newPlaylist = Playlist.fromJson(data['data']);

          /// * add the playlist to the content list
          _myPlaylistData.value?.content.add(newPlaylist);

          /// * refresh the playlist list
          _myPlaylistData.refresh();

          /// * close the bottomsheet
          await NavigationUtil.backWithDelay();

          /// * clear the textfield
          newPlaylistName.clear();

          /// * display success toast
          ToastUtil.success(data['message']);

          /// * navigate to the playlist page
          NavigationUtil.toWithDelay(
            navigateTo: () => const PlaylistDetailsScreen(),
            arguments: {
              ArgumentConstants.playlistType: PlaylistType.custom,
              ArgumentConstants.playlistId: newPlaylist.id,
            },
          );
        } else {
          _createOrUpdatePlaylist.value = CreateOrUpdatePlaylist.fromJson(data);
          getListOfTracks(needLoading: false);
          getCreatedPlaylists();
          getPlaylistByID(playlistID: playlistID.toString());
          setRenameValue(value: false);
          CustomLoading().dismiss();
        }
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        CustomLoading().dismiss();
      } else {
        ToastUtil.error('${data['message']}');
        LogUtil.e(
            'Error while trying to creating playlist: ${data['message']}');
        ToastUtil.error(
          'Something went wrong, Please try again later',
        );
        CustomLoading().dismiss();
      }
    } catch (e) {
      LogUtil.v('error while creating playlist: $e');
    }
  }

  /// Get Created Playlists
  Future<void> getCreatedPlaylists() async {
    try {
      isLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getPlaylists}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Data fetching of created playlists: ${data['message']}');
        _createdPlaylist.value = CreatedPlaylistsModel.fromJson(data);
        isLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        isLoading.value = false;
        LogUtil.v('Error while getting created playlist: ${data['message']}');
      } else {
        LogUtil.v(
            'Error while getting created playlist data: ${data['message']}');
        isLoading.value = false;
      }
    } catch (e) {
      LogUtil.v('error while getting created playlist data: $e');
    }
  }

  /// Get playlist by id
  Future<void> getPlaylistByID({required String playlistID}) async {
    try {
      isLoading.value = true;
      var response = await apiService.request(
          apiEndPoint: "${ApiService.getPlaylists}/$playlistID",
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        LogUtil.v(
            'successful operation for getting playlist by id: ${data['message']}');
        _playlistByID.value = PlaylistByIDModel.fromJson(data);
        if (playlistByID.data!.tracks!.isEmpty) {
          getListOfTracks(needLoading: false);
        }
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        LogUtil.v('Network error while getting playlist by id');
        isLoading.value = false;
        ToastUtil.error(data['message']);
      } else {
        LogUtil.v('error while getting playlist by id');
        isLoading.value = false;
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.v('error while getting playlist by id: $e');
    }
  }

  /// Delete created playlist
  Future<void> deleteCreatedPlaylist({required String id}) async {
    try {
      LoadingUtil.show();
      var response = await apiService.request(
          apiEndPoint: "${ApiService.deletePlaylist}/$id",
          isDelete: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Playlist deleted successfully');
        LoadingUtil.dismiss();
        ToastUtil.success(data['message']);
        getCreatedPlaylists();
        Navigator.pop(Get.context!);
        Navigator.pop(Get.context!);
      } else {
        LogUtil.e('Failed to delete playlist. Status code: ${data['message']}');
        LoadingUtil.dismiss();
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.v('error while deleting playlist');
    }
  }

  /// Get List of Tracks
  Future<void> getListOfTracks({bool needLoading = true}) async {
    try {
      if (needLoading == true) {
        CustomLoading().show(Get.context!);
      }
      isLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getTracks}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Data fetching of playlist tab');
        _tracksList.value = TracksListModel.fromJson(data);
        isLoading.value = false;
        if (needLoading == true) {
          CustomLoading().dismiss();
        }
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        isLoading.value = false;
        if (needLoading == true) {
          CustomLoading().dismiss();
        }
      } else {
        LogUtil.v('error while getting tracks list');
        ToastUtil.error(data['message']);
        isLoading.value = false;
        if (needLoading == true) {
          CustomLoading().dismiss();
        }
      }
    } catch (e) {
      LogUtil.v('error while getting list of tracks: $e');
    }
  }

  /// Add tracks to playlist
  Future<void> addTracksToPlaylist({
    required String playlistID,
  }) async {
    Map<String, dynamic> body = {
      'playlist_id': playlistID,
      'tracks': selectedTrackIds.join(' ,'),
      'device_id': LocalStorage.deviceID.toString(),
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.request(
          apiEndPoint: ApiService.addTrackToPlaylist,
          isPost: true,
          data: body,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomLoading().dismiss();
        getPlaylistByID(playlistID: playlistID);
        getCreatedPlaylists();
        Navigator.pop(Get.context!);
        LogUtil.v('Tracks successfully added to  playlist');
        ToastUtil.success(data['message']);
        selectedTrackIds.clear();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        LogUtil.v('Error: ${data['message']}');
        CustomLoading().dismiss();
        ToastUtil.success(data['message']);
      } else {
        LogUtil.v('error while adding tracks to playlist');
        CustomLoading().dismiss();
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.v('error while adding tracks to playlist: $e ');
    }
  }

  /// Remove tracks from playlist
  Future<void> removeTracksToPlaylist(
      {required String id, required String tID, required int index}) async {
    try {
      var response = await apiService.request(
          apiEndPoint:
              "${ApiService.removeTracksFromPlaylist}?playlist_id=$id&tracks=$tID&device_id=${LocalStorage.deviceID.toString()}",
          isDelete: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('track deleted successfully: ${data['message']}');
        playlistByID.data!.tracks!.removeAt(index);
        _playlistByID.refresh();
        update();
        ToastUtil.success(data['message']);
        getCreatedPlaylists();
      } else {
        LogUtil.e(
            'Failed to delete playlist track. Status code: ${response.statusCode} : ${data['message']}');
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.e('catch error error while deleting playlist track');
    }
  }

  /// Get my collections
  Future<void> getMyCollections() async {
    try {
      isLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getCollections}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('data fetching of myCollections list: ${data['message']}');
        _myCollections.value = CollectionResponseModel.fromJson(data);
        isLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        LogUtil.v(
            'error while fetching of myCollections list: ${data['message']}');
        ToastUtil.error(data['message']);
        isLoading.value = false;
      } else {
        LogUtil.v('error while getting myCollections list: ${data['message']}');
        ToastUtil.error(data['message']);
        isLoading.value = false;
      }
    } catch (e) {
      LogUtil.v('error while getting collections: $e');
    }
  }

  int? createdCollectionID;

  /// Create new Collection
  Future<void> createOrUpdateNewCollection(
      {String? name, String? collectionID, bool isEditing = false}) async {
    Map<String, dynamic> body = {
      'id': isEditing == false ? '' : collectionID.toString(),
      'name': isEditing == false ? newCollectionName.text : name.toString(),
      'device_id': LocalStorage.deviceID.toString(),
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.request(
          apiEndPoint: ApiService.createCollection,
          isPost: true,
          data: body,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        createdCollectionID = data['data']['id'];
        LogUtil.v(
            'successfully collection Update/created: $createdCollectionID');
        Navigator.pop(Get.context!);
        ToastUtil.success(data['message']);
        newCollectionName.clear();
        getMyCollections();
        CustomLoading().dismiss();
        Get.to(() => const CollectionDetailScreen());
        getCollectionByID(collectionID: createdCollectionID.toString());
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LogUtil.e(
            'Error while trying to Update/creating collection: ${data['message']}');
        CustomLoading().dismiss();
      } else {
        ToastUtil.error("${data['message']}");
        LogUtil.e(
            'Error while trying to Update/creating collection: ${data['message']}');
        ToastUtil.error(data['message']);
        CustomLoading().dismiss();
      }
    } catch (e) {
      LogUtil.v('error while Update/creating collection: $e');
    }
  }

  /// Get Collection By ID
  RxBool isCollectionLoading = false.obs;
  Future<void> getCollectionByID({required String collectionID}) async {
    try {
      isCollectionLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              "${ApiService.getCollections}/${collectionID.toString()}?device_id=${LocalStorage.deviceID.toString()}",
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('getting collection by id: ${data['message']}');
        _getCollectionByID.value = CollectionByIDModel.fromJson(data);
        if (collectionByID.data!.affirmations!.isEmpty) {
          getListOfAffirmations();
        }
        isCollectionLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        LogUtil.v(
            'Network error while getting collection by id: ${data['message']}');
        ToastUtil.error(data['message']);
        isCollectionLoading.value = false;
      } else {
        LogUtil.v('error while getting collection by id: ${data['message']}');
        ToastUtil.error(data['message']);
        isCollectionLoading.value = false;
      }
    } catch (e) {
      LogUtil.v('error while getting collection by id: $e');
      isCollectionLoading.value = false;
    }
  }

  /// delete created collection by user
  Future<void> deleteCreatedCollection({required String id}) async {
    try {
      LoadingUtil.show();
      var response = await apiService.request(
          apiEndPoint:
              "${ApiService.deleteCollection}/$id?device_id=${LocalStorage.deviceID.toString()}",
          isDelete: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('collection deleted successfully: ${data['message']}');
        getMyCollections();
        LoadingUtil.dismiss();
        ToastUtil.success(data['message']);
      } else {
        print('Failed to delete playlist. Status code: ${data['message']}');
        LoadingUtil.dismiss();
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.v('error while deleting playlist');
    }
  }

  ///  Get Affirmation for new collections
  Future<void> getListOfAffirmations() async {
    try {
      isLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getAffirmationsList}?device_id=${LocalStorage.deviceID.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Data fetching of affirmation for new Collection');
        _getAffirmationList.value = AffirmationListModel.fromJson(data);
        isLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        isLoading.value = false;
      } else {
        LogUtil.v('error while getting affirmations list');
        ToastUtil.error(data['message']);
        isLoading.value = false;
      }
    } catch (e) {
      LogUtil.v('error while getting list of tracks: $e');
    }
  }

  /// Add affirmations to collection
  Future<void> addAffirmationsToCollection(
      {required String collectionID}) async {
    Map<String, dynamic> body = {
      'collection_id': collectionID,
      //'affirmations': selectedAffirmationIDs.join(' ,'),
      "affirmations_id": selectedAffirmationIDs.join(' ,'),
      'device_id': LocalStorage.deviceID.toString(),
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.request(
          apiEndPoint: ApiService.addAffirmationsToCollection,
          isPost: true,
          data: body,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CustomLoading().dismiss();
        LogUtil.v('Affirmations successfully added to playlist');
        getCollectionByID(collectionID: collectionID);
        Navigator.pop(Get.context!);
        ToastUtil.success(data['message']);
        selectedAffirmationIDs.clear();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        LogUtil.v('Error: ${data['message']}');
        CustomLoading().dismiss();
        ToastUtil.error(data['message']);
      } else {
        LogUtil.v('error while adding affirmation to playlist');
        CustomLoading().dismiss();
        ToastUtil.success(data['message']);
      }
    } catch (e) {
      LogUtil.v('error while adding affirmation to playlist: $e ');
    }
  }

  /// Remove affirmations from collection
  Future<void> removeAffirmationToCollection(
      {required String id, required String aID, required int index}) async {
    try {
      var response = await apiService.request(
          apiEndPoint:
              "${ApiService.removeAffirmationsFromCollection}?collection_id=$id&affirmations=$aID&device_id=${LocalStorage.deviceID.toString()}",
          isDelete: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('affirmation removing successfully: ${data['message']}');
        collectionByID.data!.affirmations!.removeAt(index);
        _getCollectionByID.refresh();
        update();
        getMyCollections();
        ToastUtil.success(data['message']);
      } else {
        LogUtil.e(
            'Failed to affirmation removing. Status code: ${response.statusCode} : ${data['message']}');
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.e('catch error error while affirmation removing');
    }
  }

  /// By You Tab

  /// Create or Update new by you
  Future<void> createOrUpdateByYou(
      {String? filePath, required int recordingIndex}) async {
    if (filePath == null || filePath.isEmpty) {
      LogUtil.e('File path is null or empty.');
      return;
    }
    Map<String, String> body = {
      'description': 'My recording $recordingIndex',
      'device_id': LocalStorage.deviceID.toString(),
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.uploadAudio(
        apiEndPoint: ApiService.byYouCreate,
        audioFile: File(filePath),
        additionalFields: body,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(Get.context!);
        LogUtil.v('Successfully By You created');
        ToastUtil.success(data['message']);
        // getListOfRecordedVoices();
        CustomLoading().dismiss();
        update();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LogUtil.e(
            'Error while trying to create collection: ${data['message']}');
        CustomLoading().dismiss();
      } else {
        ToastUtil.error("${data['message']}");
        LogUtil.e('Error while trying to create By You: ${data['message']}');
        ToastUtil.error(data['message']);
        CustomLoading().dismiss();
      }
    } catch (e) {
      LogUtil.e('Unsuccessful operation to upload audio: $e');
      CustomLoading().dismiss();
    }
  }

  /// Get list of Recordings
  Future<void> getListOfRecordedVoices() async {
    try {
      isLoading.value = true;
      var response = await apiService.request(
          // apiEndPoint: '${ApiService.getListOfRecordings}?device_id=${LocalStorage.deviceID.toString()}',
          apiEndPoint:
              '${ApiService.getListOfRecordings}?device_id=SP1A.210812.003',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Data fetching of Recorded list');
        _recordedLists.value = RecordingsListModel.fromJson(data);
        isLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        isLoading.value = false;
      } else {
        LogUtil.v('error while getting Recorded list');
        ToastUtil.error(data['message']);
        isLoading.value = false;
      }
    } catch (e) {
      LogUtil.v('error while getting list of Recordings: $e');
    }
  }

  /// Get list of Recordings by id
  Future<void> getListOfRecordedVoicesByID({required String idOfList}) async {
    try {
      isLoading.value = true;
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.getListOfRecordingsByID}${idOfList.toString()}',
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Data fetching of Recorded list by ID');
        _recordedListsByID.value = RecordingsListModelByID.fromJson(data);
        isLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        isLoading.value = false;
      } else {
        LogUtil.v('error while getting Recorded list by using ID');
        ToastUtil.error(data['message']);
        isLoading.value = false;
      }
    } catch (e) {
      LogUtil.v('error while getting list of Recordings By ID: $e');
    }
  }

  /// Add or remove affirmation in by you
  Future<void> addAffirmationInByYou(
      {required String filePath,
      required String idOfByYou,
      required int recordingIndex}) async {
    if (filePath.isEmpty) {
      ToastUtil.error('Something is missing path empty.');
      LogUtil.e('File path is null or empty.');
      return;
    }
    Map<String, String> body = {
      'description': 'My recording $recordingIndex',
      'device_id': LocalStorage.deviceID.toString(),
      'by_you_content_id': idOfByYou.toString(),
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.uploadAudio(
        apiEndPoint: ApiService.addOrRemoveAffirmationByID,
        audioFile: File(filePath),
        additionalFields: body,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(Get.context!);
        // getListOfRecordedVoices();
        // getListOfRecordedVoicesByID(idOfList: idOfByYou.toString());
        LogUtil.v('successfully operation: ${data['message']}');
        ToastUtil.success(data['message']);
        CustomLoading().dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LogUtil.e(
            'Error while trying to creating collection: ${data['message']}');
        CustomLoading().dismiss();
      } else {
        ToastUtil.error("${data['message']}");
        LogUtil.e('Error while trying to creating by You: ${data['message']}');
        ToastUtil.error(data['message']);
        CustomLoading().dismiss();
      }
    } catch (e) {
      LogUtil.v('error while creating by You: $e');
    }
  }

  /// Remove By you that created
  Future<void> removeByYou({required String byYouID}) async {
    Map<String, dynamic> body = {
      'device_id': LocalStorage.deviceID.toString(),
      'by_you': byYouID,
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.request(
          apiEndPoint: ApiService.removeAffirmationOrByYou,
          isPost: true,
          data: body,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('successfully operation: ${data['message']}');
        ToastUtil.error(data['message']);
        // getListOfRecordedVoices();
        CustomLoading().dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LogUtil.e('Error while trying to removing by You: ${data['message']}');
        CustomLoading().dismiss();
      } else {
        ToastUtil.error("${data['message']}");
        LogUtil.e('Error while trying to removing by You: ${data['message']}');
        ToastUtil.error(data['message']);
        CustomLoading().dismiss();
      }
    } catch (e) {
      LogUtil.v('error while to removing by You: $e');
    }
  }

  //from menu
  RxBool isMenu = false.obs;
  void setIsMenuValue({required bool value}) {
    isMenu.value = value;
    LogUtil.v('delete : $isMenu');
  }

  /// Remove affirmation from By you that created
  Future<void> removeAffirmationOrByYou(
      {String? byYouID,
      String? byYouAffirmationID,
      required bool isByYou}) async {
    Map<String, dynamic> body = {
      'device_id': LocalStorage.deviceID.toString(),
      'remove': isByYou == true ? 'by_you' : 'by_you_aff',
      'id': isByYou == true ? byYouID.toString() : byYouAffirmationID.toString()
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.request(
          apiEndPoint: ApiService.removeAffirmationOrByYou,
          isPost: true,
          data: body,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('successfully operation: ${data['message']}');
        ToastUtil.error(data['message']);
        if (isByYou == true) {
          Navigator.pop(Get.context!);
          // getListOfRecordedVoices();
        } else if (isByYou == false) {
          // getListOfRecordedVoices();
          // getListOfRecordedVoicesByID(idOfList: byYouID.toString());
          if (isMenu.value == true) {
            Navigator.pop(Get.context!);
            isMenu.value == false;
          }
        }
        CustomLoading().dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LogUtil.e(
            'Error while trying to removing affirmation: ${data['message']}');
        CustomLoading().dismiss();
      } else {
        ToastUtil.error("${data['message']}");
        LogUtil.e(
            'Error while trying to removing affirmation: ${data['message']}');
        ToastUtil.error(data['message']);
        CustomLoading().dismiss();
      }
    } catch (e) {
      LogUtil.v('Error while trying to removing affirmation:: $e');
    }
  }

  ///Rename affirmations
  RxBool isRename = false.obs;
  void setRenameValue({required bool value}) {
    isRename.value = value;
    LogUtil.v('rename is: $isRename');
  }

  TextEditingController newNameOfRecording = TextEditingController();

  /// Rename by you Content or Rename affirmations
  Future<void> renameAffirmationOrByYou(
      {required String name,
      String? byYouId,
      String? byYouAffId,
      required bool isByYou}) async {
    Map<String, dynamic> body = {
      'device_id': LocalStorage.deviceID.toString(),
      'description': name.toString(),
      if (isByYou == true) 'by_you_content_id': byYouId.toString(),
      if (isByYou == false) 'by_you_affirmation_id': byYouAffId.toString()
    };
    try {
      CustomLoading().show(Get.context!);
      var response = await apiService.request(
          apiEndPoint: ApiService.renameContentOrAffirmationInByYou,
          isPost: true,
          data: body,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('successfully operation: ${data['message']}');
        ToastUtil.success(data['message']);
        // getListOfRecordedVoices();
        Navigator.pop(Get.context!);
        if (isByYou == false) {
          // getListOfRecordedVoicesByID(idOfList: byYouId.toString());
        }
        CustomLoading().dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LogUtil.e(
            'Error while trying to creating collection: ${data['message']}');
        CustomLoading().dismiss();
      } else {
        ToastUtil.error("${data['message']}");
        LogUtil.e('Error while trying to creating by You: ${data['message']}');
        ToastUtil.error(data['message']);
        CustomLoading().dismiss();
      }
    } catch (e) {
      LogUtil.v('error while creating by You: $e');
    }
  }
}
