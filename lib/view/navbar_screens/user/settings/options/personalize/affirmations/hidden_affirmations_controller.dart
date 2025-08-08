import 'package:get/get.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/affirmation_service.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/core/utils/toast_util.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/hidden_affirmation_response_model.dart';

class HiddenAffirmationController extends BaseController
    with ProfileControllerMixin {
  final RxList<HiddenAffirmation> hiddenAffirmations =
      <HiddenAffirmation>[].obs;

  final AffirmationService _affirmationService;

  HiddenAffirmationController(
    this._affirmationService,
  );

  @override
  void onInit() async {
    super.onInit();
    await getHiddenAffirmations();
  }

  Future<void> getHiddenAffirmations() async {
    try {
      final response = await _affirmationService.getHiddenAffirmations();
      if (response['success']) {
        /// * parse the response data
        final hiddenAffirmationsResponse =
            HiddenAffirmationResponseModel.fromJson(response['data']);

        /// * update the list
        hiddenAffirmations.assignAll(
          hiddenAffirmationsResponse.data!,
        );
      }
    } catch (e) {
      handleFailure(e.toString());
    }
  }

  void toggleHiddenAffirmation(HiddenAffirmation affirmation) async {
    if (hiddenAffirmations.contains(affirmation)) {
      await _affirmationService.hideUnhideAffirmation(affirmation.id.toString(),
          userId: "1");
      hiddenAffirmations.remove(affirmation);

      ToastUtil.success("Affirmation removed from \"Hidden\" successfully");
    }
  }
}
