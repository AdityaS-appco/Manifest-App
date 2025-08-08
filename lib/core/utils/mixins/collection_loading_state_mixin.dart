import 'package:get/get.dart';

mixin CollectionLoadingStateMixin {
  // Loading state for collections
  final RxBool isLoadingCollections = false.obs;
  startLoadingCollections() {
    isLoadingCollections.value = true;
  }

  stopLoadingCollections() {
    isLoadingCollections.value = false;
  }

  // Refresh state for collections
  final RxBool isRefreshingCollections = false.obs;
  startRefreshingCollections() {
    isRefreshingCollections.value = true;
  }

  stopRefreshingCollections() {
    isRefreshingCollections.value = false;
  }

  // Loading state for adding affirmation to collection
  final RxBool isAddingAffirmationToCollection = false.obs;
  startAddingAffirmationToCollection() {
    isAddingAffirmationToCollection.value = true;
  }

  stopAddingAffirmationToCollection() {
    isAddingAffirmationToCollection.value = false;
  }

  // Loading state for creating new collection
  final RxBool isCreatingNewCollection = false.obs;
  startCreatingNewCollection() {
    isCreatingNewCollection.value = true;
  }

  stopCreatingNewCollection() {
    isCreatingNewCollection.value = false;
  }

  // Loading state for adding to collection
  final RxBool isAddingToCollection = false.obs;
  startAddingToCollection() {
    isAddingToCollection.value = true;
  }

  stopAddingToCollection() {
    isAddingToCollection.value = false;
  }
}
