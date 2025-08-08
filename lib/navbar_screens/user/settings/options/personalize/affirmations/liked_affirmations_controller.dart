import 'package:get/get.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/affirmation_service.dart';
import 'package:manifest/core/utils/toast_util.dart';
import 'package:manifest/models/explore_tab_model/featured_tab_model/featured_tab_model.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/liked_affirmations_response_model.dart';

class LikedAffirmationController extends BaseController {
  final RxList<LikedAffirmation> likedAffirmations = <LikedAffirmation>[].obs;

  final AffirmationService _affirmationService;

  LikedAffirmationController(
    this._affirmationService,
  );

  @override
  void onInit() async {
    super.onInit();
    await getLikedAffirmations();
  }

  Future<void> getLikedAffirmations() async {
    try {
      final response = await _affirmationService.getFavorites();
      if (response['success']) {
        /// * parse the response data
        final likedAffirmationsResponse =
            LikedAffirmationResponseModel.fromJson(response['data']);

        /// * update the list
        likedAffirmations.assignAll(
          likedAffirmationsResponse.data!,
        );
      }
    } catch (e) {
      handleFailure(e.toString());
    }
  }

  void toggleFavorite(LikedAffirmation affirmation) async {
    if (likedAffirmations.contains(affirmation)) {
      await _affirmationService
          .addToOrRemoveFromFavorite(affirmation.id.toString());
      likedAffirmations.remove(affirmation);

      ToastUtil.success("Affirmation removed from \"Liked\" successfully");
    }
  }
}
