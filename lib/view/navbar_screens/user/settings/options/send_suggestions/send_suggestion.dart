import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/send_results_successfull_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/suggestion_submitted_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/buttons/blur_button.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/send_suggestions/suggestion_option_model.dart';

class SendSuggestionsScreen extends StatelessWidget {
  const SendSuggestionsScreen({
    required this.selectedOption,
  });
  final SuggestionOption selectedOption;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SendSuggestionsController());

    return CommonAuthFormScaffold(
      title: "Send Suggestion",
      subtitle:
          "All feedback is heard, and we consistently enhance the app based on your input.",
      bottomsheet: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PrimaryPageButton.text(
            text: "Submit",
            onPressed: controller.onSave,
          ),
          24.height,
          Text(
            AppStrings.bySubmittingYouAgree,
            style: Get.appTextTheme.settingFooterText,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DividerSection.containeredForSetting(children: [
            AppListTile.dropdown(
              text: selectedOption.label,
              leadingIcon: selectedOption.iconPath,
              gradientColors: selectedOption.gradientColors,
              onTap: () {},
            )
          ]),
          20.height,
          AppTextField.multiline(
            controller: controller.messageController,
            maxLines: 7,
            hintText: AppStrings.enterYourMessage,
          ),
          20.height,
          Obx(() {
            return Column(
              children: <Widget>[
                ...controller.attachedFiles
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 20.0).r,
                        child: AppListTile.pickedImage(
                          file: entry.value,
                          onRemove: () => controller.removeFile(entry.key),
                        ),
                      ),
                    )
                    .toList()
              ],
            );
          }),
          Row(
            children: [
              BlurButton(
                icon: IconAllConstants.paperclip,
                text: AppStrings.attachFiles,
                onPressed: controller.attachFiles,
                iconSize: 14,
              ),
            ],
          ),
          50.height,
        ],
      ),
    );
  }
}

class SendSuggestionsController extends GetxController {
  // final MyRepository repository;
  // SendResultsController(this.repository);

  /// * Controllers
  final TextEditingController messageController = TextEditingController();

  /// * Observables
  final RxList<File> _attachedFiles = <File>[].obs;
  final RxBool _isLoading = false.obs;

  /// * Getters
  List<File> get attachedFiles => _attachedFiles;
  bool get isLoading => _isLoading.value;

  /// * Handle file attachment
  Future<void> attachFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result != null) {
        _attachedFiles.addAll(result.files.map((file) => File(file.path!)));
      }
    } catch (e) {
      ToastUtil.error('Failed to attach images');
    }
  }

  /// * Remove attached file
  void removeFile(int index) {
    if (index >= 0 && index < _attachedFiles.length) {
      _attachedFiles.removeAt(index);
    }
  }

  /// * Handle save submission
  Future<void> onSave() async {
    if (FormValidatorUtil.message(messageController.text) != null) {
      ToastUtil.error(
          FormValidatorUtil.message(messageController.text).toString());
      return;
    }

    try {
      _isLoading.value = true;

      // TODO: Implement save logic using repository
      // await repository.saveResults(
      //   message: messageController.text,
      //   files: _attachedFiles,
      // );

      /// * success bottomsheet
      await AppBottomSheet.show(const SuggestionSubmittedBottomsheet());

      Get.back();
    } catch (e) {
      ToastUtil.error('Failed to send results');
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
