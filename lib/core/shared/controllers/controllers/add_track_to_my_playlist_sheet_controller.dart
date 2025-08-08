import 'package:get/get.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/playlist_service.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/core/utils/toast_util.dart';
import 'package:manifest/models/explore_tab_model/explore_tab/explore_playlist_by_id_model.dart';

class AddTrackToMyPlaylistController extends BaseController
    with ProfileControllerMixin {
  final PlaylistService _playlistService = Get.find();

  /// * Selected track ID
  final RxString selectedPlaylistId = ''.obs;

  /// * Search query
  final RxString searchQuery = ''.obs;

  /// * Tracks list
  List<Playlist> get playlists =>
      Get.find<PlaylistTabController>().playlistContent;

  /// * Add track to playlist
  Future<void> addTrackToMyPlaylist({
    required String playlistId,
    required int trackId,
  }) async {
    try {
      startLoading();
      final result = await _playlistService.addTracksToPlaylist(
        playlistId: playlistId,
        trackIds: [trackId.toString()],
      );

      Get.back();
      Get.back();
      if (result) {
        ToastUtil.success("Track added to playlist");
      }
    } catch (e) {
      handleFailure(e.toString());
    } finally {
      stopLoading();
    }
  }

  /// * Set track selection
  void togglePlaylistSelection(String playlistId) {
    if (selectedPlaylistId.value == playlistId) {
      selectedPlaylistId.value = '';
    } else {
      selectedPlaylistId.value = playlistId;
    }
  }

  /// * Handle search
  void onSearchChanged(String query) {
    searchQuery.value = query;
  }
}
