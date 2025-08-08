import 'package:get/get.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/collection_service.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/my_collections_model.dart';
import 'package:manifest/view/navbar_screens/home/media_player/affirmation_options/AffirmationCreateNewCollection.dart';

class MyCollectionPageController extends BaseController
    with ProfileControllerMixin {
  final CollectionService _collectionService;

  MyCollectionPageController(
    this._collectionService,
  );

  @override
  void onInit() async {
    startLoading();
    await _collectionService.getCollections(
        showLoader: false, userId: profile.id?.toString() ?? '');
    stopLoading();
    super.onInit();
  }

  RxList<Collection> get collections => _collectionService.collections;

  void onCreateCollectionTap() {
    Get.bottomSheet(
      AffirmationCreateNewCollectionScreen(),
      isScrollControlled: true,
      enableDrag: true,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
    );
  }
}
