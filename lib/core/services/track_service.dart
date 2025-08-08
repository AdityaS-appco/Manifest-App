import 'package:get/get.dart';
import 'package:manifest/core/error/failures.dart';
import 'package:manifest/core/network/result.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/core/base/base_service.dart';

import '../shared/controllers/profile_controller.dart';

/// Service for handling track-related operations
class TrackService extends BaseService {
  /// Get all tracks
  /// Returns a map containing success status and list of tracks
  Future<Map<String, dynamic>> getTracks() async {
    return await makeRequest(
      endpoint: ApiService.getTracks,
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Get track details by ID
  /// Returns a map containing success status and track details
  Future<Map<String, dynamic>> getTrackDetails(String trackId) async {
    return await makeRequest(
      endpoint:
          '${ApiService.trackById}$trackId?device_id=${LocalStorage.deviceID.toString()}&language=${LocalStorage.appLanguage.toString()}',
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Add track to favorites
  /// Returns a map containing success status and message
  Future<Result<bool>> toggleFavorite(
    String trackId, {
    int? userId,
  }) async {
    try {
      final body = {
        'track_id': trackId,
        'user_id': userId,
        'device_id': LocalStorage.deviceID.toString(),
        'type': 'track',
      };

      final response = await makeRequest(
        endpoint: ApiService.addTrackToFavorite,
        data: body,
        isPost: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        responseParser: (response) => response,
      );

      if (response['success']) {
        return Result.success(response['data']['is_favorite']);
      }
      return Result.failure(ServerFailure('Failed to fetch profile'));
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Get favorite tracks
  /// Returns a map containing success status and list of favorite tracks
  Future<Map<String, dynamic>> getFavorites() async {
    return await makeRequest(
      endpoint: ApiService.getFavoriteTracks,
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Remove track from favorites
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> removeFromFavorite(String trackId) async {
    final body = {
      'track_id': trackId,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.removeTrackFromFavorite,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Add track to recently played
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> addToRecentlyPlayed(String trackId) async {
    final body = {
      'track_id': trackId,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.addToRecentPlayed,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }
}
