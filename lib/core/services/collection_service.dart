import 'dart:io';

import 'package:get/get.dart';
import 'package:manifest/core/network/result.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/my_collections_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/core/base/base_service.dart';

/// Service for handling collection-related operations
/// persistent collection list
class CollectionService extends BaseService {
  final RxList<Collection> collections = RxList.empty();

  /// get collections list when controller is initialized
  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   await getCollections();
  // }

  /// Create a new collection
  /// Returns a map containing success status and message
  Future<Result<Collection?>> createCollection({
    required String name,
    String? description,
    required String userId,
    File? image,
  }) async {
    final body = {
      'name': name,
      if (description != null) 'description': description,
      'device_id': LocalStorage.deviceID.toString(),
      'user_id': userId,
    };

    final response = await makeRequest(
      endpoint: ApiService.createCollection,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );

    if (response['success']) {
      final collection = Collection.fromJson(response['data']);
      return Result.success(collection);
    }

    return Result.failure(response['message']);
  }

  /// Get all collections
  /// Returns a map containing success status and list of collections
  Future<Result<List<Collection>>> getCollections({
    bool showLoader = true,
    required String userId,
  }) async {
    final response = await makeRequest(
      endpoint:
          '${ApiService.getCollections}?device_id=${LocalStorage.deviceID.toString()}&user_id=$userId',
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
      showLoader: showLoader,
    );

    if (response['success']) {
      final _collections = ((response['data'] ?? []) as List)
          .map((e) => Collection.fromJson(e))
          .toList()
        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      collections.value = _collections;
      return Result.success(_collections);
    }
    return Result.failure(response['message']);
  }

  /// Get a specific collection by ID
  /// Returns a map containing success status and collection details
  Future<Collection?> getCollectionById(String collectionId,
      {bool showLoader = true}) async {
    final response = await makeRequest(
      endpoint:
          '${ApiService.getCollections}/$collectionId?device_id=${LocalStorage.deviceID.toString()}',
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
      showLoader: showLoader,
    );

    if (response['success']) {
      final collectionById = Collection.fromJson(response['data']['data']);
      return collectionById;
    }

    return null;
  }

  /// Delete a collection
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> deleteCollection(String collectionId) async {
    final response = await makeRequest(
      endpoint: '${ApiService.deleteCollection}/$collectionId',
      isDelete: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );

    /// update collection list
    if (response['success']) {
      collections
          .removeWhere((element) => element.id.toString() == collectionId);
    }

    return response;
  }

  /// Add affirmations to a collection
  /// Returns a map containing success status and message
  Future<Result<bool>> addAffirmationsToCollection({
    required String collectionId,
    required List<String> affirmationId,
  }) async {
    final body = {
      'collection_id': collectionId,
      'affirmations_id': affirmationId.join(','),
      'device_id': LocalStorage.deviceID.toString(),
    };

    final response = await makeRequest(
      endpoint: ApiService.addAffirmationsToCollection,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
      responseParser: (response) => response,
    );

    /// update collection list
    if (response['success']) {
      final isAdded = response['data']['status'];

      if (isAdded) {
        return Result.success(true);
      }
    }
    return Result.failure(response['message']);
  }

  /// Remove affirmations from a collection
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> removeAffirmationsFromCollection({
    required String collectionId,
    required List<String> affirmationIds,
  }) async {
    final response = await makeRequest(
      endpoint:
          '${ApiService.removeAffirmationsFromCollection}?affirmations_id=${affirmationIds.join(',')}&collection_id=$collectionId&user_id=&device_id=${LocalStorage.deviceID.toString()}',
      isDelete: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );

    /// update collection list
    if (response['success']) {
      collections.value = ((response['data']['data'] ?? []) as List)
          .map((e) => Collection.fromJson(e))
          .toList();
    }

    return response;
  }
}
