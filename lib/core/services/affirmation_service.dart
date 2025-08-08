import 'package:get/get.dart';
import 'package:manifest/core/error/failures.dart';
import 'package:manifest/core/network/result.dart';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/core/base/base_service.dart';

/// Service for handling affirmation-related operations
class AffirmationService extends BaseService {
  /// persistent affirmation list
  // final RxList<Affirmation> affirmations = RxList.empty();

  /// getter for affirmations list
  // List<Affirmation> get affirmationsList => affirmations.toList();

  /// getter for favorite affirmations list
  // List<Affirmation> get favoriteAffirmations => affirmations.where((element) => element.isFavorite).toList();

  /// Add an affirmation to favorites
  /// Returns a map containing success status and message
  Future<Result<bool>> addToOrRemoveFromFavorite(
    String affirmationId, {
    int? userId,
  }) async {
    try {
      final body = {
        'device_id': LocalStorage.deviceID.toString(),
        'user_id': userId,
        'affirmation_content_id': affirmationId,
        'type': 'affirmation',
      };

      final response = await makeRequest(
        endpoint: ApiService.addAffirmationToFavorite,
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

  /// Hide an affirmation
  /// Returns a map containing success status and message
  Future<Result<bool>> hideUnhideAffirmation(
    String affirmationId, {
    required String userId,
  }) async {
    try {
      final body = {
        'user_id': userId,
        'device_id': LocalStorage.deviceID.toString(),
        'affirmation_id': affirmationId,
      };

      final response = await makeRequest(
        endpoint: ApiService.hideAffirmation,
        data: body,
        isPost: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      if (response['success']) {
        return Result.success((response['data'] as List).first['is_hidden']);
      } else {
        return Result.failure(ServerFailure('Failed to fetch profile'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// get hidden affirmations
  /// Returns a map containing success status and list of hidden affirmations
  Future<Map<String, dynamic>> getHiddenAffirmations({int? userId}) async {
    return await makeRequest(
      endpoint:
          "${ApiService.getHiddenAffirmations}?device_id=${LocalStorage.deviceID.toString()}&user_id=$userId",
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Get favorite affirmations
  /// Returns a map containing success status and list of favorite affirmations
  Future<Map<String, dynamic>> getFavorites({int? userId}) async {
    return await makeRequest(
      endpoint:
          "${ApiService.getFavoriteAffirmations}?device_id=${LocalStorage.deviceID.toString()}&user_id=$userId",
      isGet: true,
      withToken: false,
    );
  }

  /// Get all affirmations
  /// Returns a map containing success status and list of affirmations
  Future<Map<String, dynamic>> getAllAffirmations({int? userId}) async {
    return await makeRequest(
      endpoint:
          '${ApiService.getAffirmationsList}?device_id=${LocalStorage.deviceID.toString()}&user_id=$userId&language=${LocalStorage.appLanguage.toString()}',
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Add affirmation to a playlist
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> addToPlaylist({
    required String playlistId,
    required String affirmationId,
  }) async {
    final body = {
      'playlist_id': playlistId,
      'affirmation_id': affirmationId,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.addAffirmationToPlaylist,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Add affirmation to "By You" section
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> addToByYou({
    required String affirmationId,
    required String title,
    String? description,
  }) async {
    final body = {
      'affirmation_id': affirmationId,
      'title': title,
      if (description != null) 'description': description,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.addOrRemoveAffirmationByID,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Remove affirmation from "By You" section
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> removeFromByYou(String affirmationId) async {
    final body = {
      'affirmation_id': affirmationId,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.removeAffirmationOrByYou,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Rename affirmation in "By You" section
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> renameInByYou({
    required String affirmationId,
    required String newTitle,
    String? newDescription,
  }) async {
    final body = {
      'affirmation_id': affirmationId,
      'title': newTitle,
      if (newDescription != null) 'description': newDescription,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.renameContentOrAffirmationInByYou,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Add affirmations to a collection
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> addToCollection({
    required String collectionId,
    required List<String> affirmationIds,
  }) async {
    final body = {
      'collection_id': collectionId,
      'affirmations': affirmationIds.join(','),
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.addAffirmationsToCollection,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// report affirmation
  /// returns a boolean value
  Future<Result<bool>> reportAffirmation({
    required String affirmationId,
    required String userId,
    required String reason,
  }) async {
    try {
      final body = {
        'user_id': userId,
        'device_id': LocalStorage.deviceID.toString(),
        'content_id': affirmationId,
        'content': reason,
      };

      final response = await makeRequest(
        endpoint: ApiService.reportAffirmation,
        data: body,
        isPost: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        responseParser: (response) => response,
      );

      if (response['success']) {
        return Result.success(true);
      }
      return Result.failure(ServerFailure('Failed to report affirmation'));
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }
}
