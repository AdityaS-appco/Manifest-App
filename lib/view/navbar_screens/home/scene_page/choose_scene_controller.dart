import 'package:get/get.dart';
import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/controllers/theme_controller.dart';
import 'package:manifest/core/utils.dart';

class ChooseSceneController extends GetxController {
  final String selectedImage;
  final HomeTwoController homeController = Get.find<HomeTwoController>();
  final ThemeController themeController = Get.find<ThemeController>();

  // Observable state
  final RxBool isProcessing = false.obs;

  ChooseSceneController({required this.selectedImage});

  Future<void> handleChooseScene() async {
    isProcessing.value = true;

    try {
      // Generate theme from the selected image
      final success =
          await themeController.generateColorFromImage(selectedImage);

      if (success) {
        /// * close the choose scene bottomsheet
        Get.back();

        /// * close the scene settings bottomsheet
        Get.back();

        /// * show success snackbar
        ToastUtil.success(
          'Scene and colors have been applied'
        );
      } else {
        ToastUtil.error(
            'Could not generate colors from this image'
           );
      }
    } catch (e) {
      ToastUtil.error(
           'Something went wrong while updating the theme'
         );
    } finally {
      isProcessing.value = false;

      // // Close the bottomsheet
      // Get.back();
    }
  }

  void handleRemoveScene() {
    themeController.resetToDefaultColors();
    Get.back();

    ToastUtil.success('Default theme has been restored');
  }
}
