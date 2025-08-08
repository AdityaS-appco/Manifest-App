import 'package:get/get.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/services/collection_service.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/my_collections_model.dart';

class CollectionDetailScreenController extends BaseController {
  CollectionService _collectionService;
  CollectionDetailScreenController(this._collectionService);

  Rxn<Collection> collection = Rxn<Collection>();

  @override
  void onInit() async {
    startLoading();
    collection.value = await _collectionService.getCollectionById(
      Get.arguments?[ArgumentConstants.collectionId],
      showLoader: false,
    );
    stopLoading();

    super.onInit();
  }

  /// * editing state variables
  final RxBool isEditingEnabled = false.obs;

  /// * toggle editing [accept optional positional parameter]
  void toggleEditing([bool? value]) {
    isEditingEnabled.value = value ?? !isEditingEnabled.value;
  }

  /// * save edits
  void saveEdits() {
    /// todo: save edit values
    
    /// * toggle editing state
    toggleEditing();
  }
}
