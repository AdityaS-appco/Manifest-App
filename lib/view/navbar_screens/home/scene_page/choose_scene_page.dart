import 'package:cached_network_image/cached_network_image.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/home/scene_page/choose_scene_controller.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';

class ChooseScenePage extends GetView<ChooseSceneController> {
  final String selectedImage;

  const ChooseScenePage({required this.selectedImage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lazy init controller with the selected image
    Get.lazyPut(() => ChooseSceneController(selectedImage: selectedImage));

    return Container(
      width: kSize.width,
      decoration: const BoxDecoration(
        color: Color(0xff1d2125),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Stack(
        children: [
          // Image container with gradient overlay
          _buildImageContainer(),
    
          // Bottom action buttons
          _buildActionButtons(),
    
          // Close button
          _buildCloseButton(context),
    
          // Loading overlay when processing
          Obx(() => controller.isProcessing.value
              ? _buildLoadingOverlay()
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      decoration: BoxDecoration(
        color: blackColor,
      ),
      foregroundDecoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.01, 2.0],
        ),
      ),
      child: AppCachedImage(
        imageUrl: selectedImage,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 20,
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            kPrimaryButton(
              text: AppStrings.chooseScene,
              textColor: blackColor,
              onPressed: controller.handleChooseScene,
            ),
            12.height,
            kPrimaryButton(
              text: AppStrings.removeScene,
              color: cardColor,
              textColor: kWhiteColor,
              onPressed: controller.handleRemoveScene,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CircleAvatar(
        backgroundColor: const Color.fromRGBO(127, 127, 127, 0.4),
        child: IconButton(
          icon: Icon(
            Icons.close,
            color: kWhiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ).paddingOnly(top: kSize.height * 0.06, right: 16),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            dotsWaveLoading(),
            const SizedBox(height: 16),
            const Text(
              'Generating theme...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
