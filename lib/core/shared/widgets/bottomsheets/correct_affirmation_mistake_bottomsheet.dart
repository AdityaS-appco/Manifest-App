import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/affirmation_service.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/helper/import.dart';

class CorrectAffirmationMistakeBottomSheetController extends BaseController
    with ProfileControllerMixin {
  final TextEditingController textEditingController = TextEditingController();
  final AffirmationService _affirmationService = Get.find();
  final formKey = GlobalKey<FormState>();
  final isReporting = false.obs;

  Future<void> reportAffirmationMistake(String affirmationId) async {
    if (!isFormValid) return;

    isReporting.value = true; // start loading animatio
    try {
      final response = await _affirmationService.reportAffirmation(
        userId: profile.id.toString(),
        affirmationId: affirmationId,
        reason: textEditingController.text,
      );

      response.fold(
        onFailure: (error) => handleFailure(error.message.toString()),
        onSuccess: (isSuccess) {
          NavigationUtil.backWithDelay(
            postNavigationCallback: () async {
              await NavigationUtil.backWithDelay();
              ToastUtil.success('Thanks for reporting');
            },
          );
        },
      );
    } catch (e) {
      ToastUtil.error(e.toString());
    } finally {
      isReporting.value = false;
    }
  }

  final _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;
  void validateForm(String? value) {
    _isFormValid.value = formKey.currentState?.validate() ?? false;
  }
}

class CorrectAffirmationMistakeBottomSheet extends StatelessWidget {
  const CorrectAffirmationMistakeBottomSheet({required this.affirmationId});
  final String affirmationId;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(CorrectAffirmationMistakeBottomSheetController());
    return Obx(
      () => CustomBottomSheet(
        title: 'Correct affirmation mistake',
        titleStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        topPadding: 16.r,
        horizontalPadding: 20.r,
        primaryButtonText: 'Report Mistake',
        isPrimaryButtonEnabled: controller.isFormValid,
        onPrimaryButtonPressed: () =>
            controller.reportAffirmationMistake(affirmationId),
        buttonsTopPadding: 24.r,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: controller.formKey,
              child: AppTextField.multiline(
                maxLength: 200,
                hintText: 'Type full affirmation sentence we should use',
                controller: controller.textEditingController,
                maxLines: 7,
                validator: FormValidatorUtil.affirmation,
                hasCounter: true,
                onChanged: (value) => controller.validateForm(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
