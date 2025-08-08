import 'dart:io';

import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/collection_service.dart';
import 'package:manifest/core/utils/mixins/collection_loading_state_mixin.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/my_collections_model.dart';

class AddToCollectionController extends BaseController
    with ProfileControllerMixin, CollectionLoadingStateMixin {
  /// * Selected collection IDs
  final RxList<String> selectedCollectionIds = <String>[].obs;

  /// * Whether multiple collections can be selected
  final RxBool isMultiSelect = false.obs;

  /// * Selected filter index
  final RxInt selectedFilterIndex = 0.obs;

  /// * Search query
  final RxString searchQuery = ''.obs;

  /// * Collections list
  final RxList<Collection> collections = <Collection>[].obs;

  /// * Collection service
  final CollectionService _collectionService = Get.find<CollectionService>();

  /// * Add collections to playlist
  Future<void> addAffirmationToCollection(String affirmationId) async {
    try {
      startAddingToCollection();
      startAddingAffirmationToCollection();
      final result = await _collectionService.addAffirmationsToCollection(
        affirmationId: [affirmationId],
        collectionId: selectedCollectionIds.first,
      );
      result.fold(
        onFailure: (error) => handleFailure(error.message),
        onSuccess: (data) {
          NavigationUtil.backWithDelay(
            postNavigationCallback: () {
              Get.back();
              ToastUtil.success('Affirmation added to collection');
            },
          );
        },
      );
    } catch (e) {
      handleFailure(e.toString());
    } finally {
      stopAddingToCollection();
      stopAddingAffirmationToCollection();
    }
  }

  /// * Load collections
  Future<void> loadCollections({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        startRefreshingCollections();
      } else {
        startLoadingCollections();
      }

      final response = await _collectionService.getCollections(
        userId: profile.id?.toString() ?? '',
      );

      response.fold(
        onFailure: (error) => handleFailure(error.message),
        onSuccess: (data) => collections.value = data,
      );
    } catch (e) {
      handleFailure(e.toString());
    } finally {
      if (isRefresh) {
        stopRefreshingCollections();
      } else {
        stopLoadingCollections();
      }
    }
  }

  void onCreateCollection({required String name, File? image}) async {
    NavigationUtil.backWithDelay();
    try {
      startAddingToCollection();
      startCreatingNewCollection();
      final result = await _collectionService.createCollection(
        userId: profile.id?.toString() ?? '',
        name: name,
        image: image,
      );

      result.fold(
        onFailure: (error) => handleFailure(error.message, showToast: true),
        onSuccess: (data) {
          if (data != null) {
            collections.insert(0, data);
            ToastUtil.success('Collection created');
          } else {
            handleFailure('Something went wrong', showToast: true);
          }
        },
      );
    } catch (e) {
      handleFailure(e.toString(), showToast: true);
    } finally {
      stopAddingToCollection();
      stopCreatingNewCollection();
    }
  }

  /// * Toggle collection selection
  void toggleCollectionSelection(String collectionId) {
    if (selectedCollectionIds.contains(collectionId)) {
      selectedCollectionIds.remove(collectionId);
    } else {
      if (!isMultiSelect.value) {
        selectedCollectionIds.clear();
      }
      selectedCollectionIds.add(collectionId);
    }
  }

  // /// * Set filter
  // void setFilter(int index) {
  //   selectedFilterIndex.value = index;
  //   // TODO: Implement filter logic
  // }

  // /// * Handle search
  // void onSearchChanged(String query) {
  //   searchQuery.value = query;
  //   // TODO: Implement search logic
  // }

  @override
  void onInit() {
    super.onInit();
    loadCollections();
  }
}
