import 'package:manifest/core/base/base_service.dart';
import 'package:manifest/core/error/failures.dart';
import 'package:manifest/core/network/result.dart';
import 'package:manifest/features/explore/models/explore_category_response_model.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/features/explore/models/explore_category_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/features/explore/models/explore_subcategory_response_model.dart';

/// Service for handling explore-related operations
class ExploreService extends BaseService {
  /// Get all explorer categories
  /// Returns a Result with ExploreListItemModel or a Failure
  Future<Result<List<ExploreCategoryModel>>> getCategories() async {
    try {
      final response = await makeRequest(
        endpoint: "${ApiService.explorerCategories}?device_id=${LocalStorage.deviceID.toString()}",
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      if (response['success']) {
        final categories = (response['data'] as List).map((item) {
          return ExploreCategoryModel.fromJson(item);
        }).toList();
        return Result.success(categories);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to fetch explore categories'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Get category details by ID
  /// Returns a Result with category details or a Failure
  Future<Result<ExploreCategoryResponseModel>> getCategoryById(
    String categoryId,
  ) async {
    try {
      final response = await makeRequest(
        endpoint:
            '${ApiService.explorerCategoriesById}$categoryId?device_id=${LocalStorage.deviceID.toString()}',
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        responseParser: (response) => response,
      );

      if (response['success']) {
        return Result.success(
            ExploreCategoryResponseModel.fromJson(response['data']));
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to fetch category details'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Get featured data
  /// Returns a Result with featured content or a Failure
  Future<Result<dynamic>> getFeaturedData() async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.getFeaturedData,
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      if (response['success']) {
        return Result.success(response['data']);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to fetch featured data'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Get goals categories
  /// Returns a Result with goal categories or a Failure
  Future<Result<dynamic>> getGoalsCategories() async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.getGoalsCategories,
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
      );

      if (response['success']) {
        return Result.success(response['data']);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to fetch goal categories'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Save goals categories
  /// Returns a Result indicating success or Failure
  Future<Result<void>> saveGoalsCategories(List<String> categoryIds) async {
    try {
      final body = {
        'categories': categoryIds.join(','),
        'device_id': LocalStorage.deviceID.toString(),
      };

      final response = await makeRequest(
        endpoint: ApiService.saveGoalsCategories,
        data: body,
        isPost: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        showLoader: true,
      );

      if (response['success']) {
        return Result.success(null);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to save goal categories'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Get subcategories by tag ID
  /// Returns a Result with subcategory details or a Failure
  Future<Result<ExploreSubcategoryResponseModel>> getSubcategoriesByTagId(
    int tagId,
    int categoryId,
  ) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.explorerSubcategoryByTagId(tagId, categoryId),
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        responseParser: (response) => response,
      );

      if (response['success']) {
        return Result.success(
            ExploreSubcategoryResponseModel.fromJson(response['data']));
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to fetch subcategory details'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Get playlists by category ID
  /// Returns a Result with list of playlists or a Failure
  Future<Result<List<ExploreCategoryPlaylist>>> getPlaylistsByCategoryId(
    int categoryId,
  ) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.explorePlaylistsByCategoryId(categoryId),
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        responseParser: (response) => response,
      );

      if (response['success']) {
        final playlists = (response['data']['data']['playlists'] as List?)
            ?.map((item) => ExploreCategoryPlaylist.fromJson(item))
            .toList() ?? [];
        return Result.success(playlists);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to fetch playlists by category'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// Get tracks by category ID
  /// Returns a Result with list of tracks or a Failure
  Future<Result<List<ExploreCategoryTrack>>> getTracksByCategoryId(
    int categoryId,
  ) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.exploreTracksByCategoryId(categoryId),
        isGet: true,
        withToken: LocalStorage.userAccessToken.isNotEmpty,
        responseParser: (response) => response,
      );

      if (response['success']) {
        final tracks = (response['data']['data']['track'] as List?)
            ?.map((item) => ExploreCategoryTrack.fromJson(item))
            .toList() ?? [];
        return Result.success(tracks);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to fetch tracks by category'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }
}
