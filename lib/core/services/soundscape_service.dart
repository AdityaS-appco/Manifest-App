import 'package:get/get.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/core/base/base_service.dart';

/// Service for handling soundscape-related operations (excluding downloads)
class SoundscapeService extends BaseService {
  RxList<Soundscape> soundscapes = <Soundscape>[].obs;

  /// Get all soundscapes with pagination support
  /// Returns a map with success status and soundscapes data
  Future<Map<String, dynamic>> getSoundscapes({
    int currentPage = 1,
    int perPage = 3,
    void Function(Pagination)? onPaginationUpdate,
    void Function(List<String>)? onTagsFetched,
  }) async {
    try {
      final response = await makeRequest(
        endpoint:
            '${ApiService.getSoundScapes}?device_id=${LocalStorage.deviceID.toString()}&page=$currentPage&per_page=$perPage',
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        responseParser: (response) => response,
      );

      if (response['success']) {
        final soundscapes = (response['data']['data'] as List)
            .map((item) => Soundscape.fromJson(item))
            .toList();

        // Call pagination update callback if provided
        if (onPaginationUpdate != null) {
          final pagination =
              Pagination.fromJson(response['data']['pagination']);
          onPaginationUpdate(pagination);
        }

        // Call tags fetched callback if provided
        if (onTagsFetched != null && response['data']['tag_list'] != null) {
          final tagList = (response['data']['tag_list'] as List)
              .map((tag) => tag.toString())
              .toList();
          onTagsFetched(tagList);
        }

        return {
          'success': true,
          'data': soundscapes,
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Failed to fetch soundscapes',
        };
      }
    } catch (e) {
      LogUtil.e('Error fetching soundscapes: $e');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Create a new soundscape
  /// Returns a map with success status
  Future<Map<String, dynamic>> createSoundscape({
    required String name,
    String? description,
    required List<String> trackIds,
  }) async {
    try {
      final body = {
        'name': name,
        if (description != null) 'description': description,
        'tracks': trackIds.join(','),
        'device_id': LocalStorage.deviceID.toString(),
      };

      final response = await makeRequest(
        endpoint: ApiService.createSoundScape,
        data: body,
        isPost: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      return response;
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Add soundscape to favorites
  /// Returns a map with success status
  Future<Map<String, dynamic>> addToFavorite(String soundscapeId) async {
    try {
      final body = {
        'soundscape_id': soundscapeId,
        'device_id': LocalStorage.deviceID.toString(),
      };

      final response = await makeRequest(
        endpoint: ApiService.addSoundscapeToFavorite,
        data: body,
        isPost: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      return response;
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Remove soundscape from favorites
  /// Returns a map with success status
  Future<Map<String, dynamic>> removeFromFavorite(String soundscapeId) async {
    try {
      final body = {
        'soundscape_id': soundscapeId,
        'device_id': LocalStorage.deviceID.toString(),
      };

      final response = await makeRequest(
        endpoint: ApiService.removeSoundscapeFromFavorite,
        data: body,
        isPost: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      return response;
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Get downloaded soundscapes from local storage
  /// Returns a map with success status and downloaded soundscapes
  Future<Map<String, dynamic>> getDownloaded() async {
    try {
      final soundscapes = LocalStorage.downloadedSoundscapes;
      return {
        'success': true,
        'data': soundscapes,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to get downloaded soundscapes: $e',
      };
    }
  }
}

class PaginationResponse {
  final int currentPage;
  final int perPage;
  final int total;
  final int lastPage;

  PaginationResponse({
    this.currentPage = 1,
    this.perPage = 10,
    this.total = 9,
    this.lastPage = 1,
  });

  factory PaginationResponse.fromJson(Map<String, dynamic> json) {
    return PaginationResponse(
      currentPage: json['current_page'] ?? 1,
      perPage: json['per_page'] ?? 10,
      total: json['total'] ?? 9,
      lastPage: json['last_page'] ?? 1,
    );
  }
}