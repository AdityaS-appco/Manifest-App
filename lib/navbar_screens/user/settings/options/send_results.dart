import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/send_results_successfull_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/buttons/blur_button.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/helper/import.dart';

class SendResultsScreen extends StatelessWidget {
  const SendResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SendResultsController());

    return CommonAuthFormScaffold(
      title: AppStrings.sendResults,
      subtitle: AppStrings.weLoveToHearHowOur,
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

class SendResultsController extends GetxController {
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
      await AppBottomSheet.show(const SendResultsSuccessfullBottomsheet());

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
