import 'package:get/get.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/created_playlist_model.dart';
import 'package:manifest/models/playlist_tab_model/playlist_metadata_models.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/core/base/base_service.dart';
import 'package:manifest/core/error/failures.dart';
import 'package:manifest/core/network/result.dart';

/// Service for handling playlist-related operations
class PlaylistService extends BaseService with ProfileControllerMixin {
  /// persistent collection list
  final RxList<Data> playlists = RxList.empty();

  /// get collections list when controller is initialized
  // @override
  // void onInit() {
  //   super.onInit();
  //   getPlaylists();
  // }

  /// Create a new playlist
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> createPlaylist({
    required String name,
    String? description,
  }) async {
    final body = {
      'name': name,
      if (description != null) 'description': description,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.createPlaylist,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Get all playlists
  /// Returns a map containing success status and list of playlists
  Future<Map<String, dynamic>> getPlaylists() async {
    final response = await makeRequest(
      endpoint:
          '${ApiService.getPlaylists}?device_id=${LocalStorage.deviceID.toString()}',
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );

    if (response['success']) {
      final playlistResponse = PlaylistResponseModel.fromJson(response['data']);
      playlists.value = playlistResponse.data ?? [];
    }

    return response;
  }

  /// Get admin playlists
  /// Returns a map containing success status and list of admin playlists
  Future<Map<String, dynamic>> getAdminPlaylists() async {
    return await makeRequest(
      endpoint: ApiService.getAdminPlaylists,
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Get playlist by ID
  /// Returns a map containing success status and playlist details
  Future<Map<String, dynamic>> getPlaylistById(String playlistId) async {
    return await makeRequest(
      endpoint: '${ApiService.explorerPlaylistById}$playlistId',
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Delete a playlist
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> deletePlaylist(String playlistId) async {
    final body = {
      'playlist_id': playlistId,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.deletePlaylist,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Add tracks to a playlist
  /// Returns a map containing success status and message
  Future<bool> addTracksToPlaylist({
    required String playlistId,
    required List<String> trackIds,
  }) async {
    final body = {
      'playlist_id': playlistId,
      'tracks': trackIds.join(','),
      'device_id': LocalStorage.deviceID.toString(),
    };

    final response = await makeRequest(
      endpoint: ApiService.addTrackToPlaylist,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );

    return response['success'];
  }

  /// Remove tracks from a playlist
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> removeTracksFromPlaylist({
    required String playlistId,
    required List<String> trackIds,
  }) async {
    final body = {
      'playlist_id': playlistId,
      'tracks': trackIds.join(','),
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.removeTracksFromPlaylist,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Fetch user's complete playlist data
  Future<Result<PlaylistDataMetaModel>> getMyPlaylistData(int userId) async {
    try {
      // Parse metadata models using fromJson
      final result = await makeRequest(
        endpoint:
            '${ApiService.getMyPlaylistData}?device_id=${LocalStorage.deviceID.toString()}&user_id=$userId',
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      if (result['success']) {
        final data = result['data'];

        // Create and return PlaylistDataMetaModel using fromJson
        return Result.success(PlaylistDataMetaModel.fromJson(data));
      } else {
        return Result.failure(ServerFailure(
            result['message'] ?? 'Failed to fetch playlist data'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }
}
