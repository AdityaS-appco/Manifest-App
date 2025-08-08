import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';

class CustomReminderSetAffirmationBottomsheet extends StatelessWidget {
  final Function(String) onSave;
  const CustomReminderSetAffirmationBottomsheet({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reminderAffirmationTextController = TextEditingController();
    final canSave = false.obs;

    /// * handle join click
    void _validateAffirmationText(String? email) {
      /// * validate the email textfield
      canSave.value = FormValidatorUtil.affirmationName(email) == null;
    }

    void dispose() {
      reminderAffirmationTextController.dispose();
    }

    return Obx(
      () => CustomBottomSheet(
          title: "Affirmation",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField.multiline(
                hintText: "input your affirmation to be displayed here",
                controller: reminderAffirmationTextController,
                validator: (email) => FormValidatorUtil.email(email),
                onChanged: (email) => _validateAffirmationText(email),
                hasCounter: true,
              ),
            ],
          ),
          primaryButtonText: "Save",
          onPrimaryButtonPressed: () {
            onSave.call(reminderAffirmationTextController.text);
            dispose();
            Get.back();
          },
          isPrimaryButtonEnabled: canSave.value),
    );
  }
}
