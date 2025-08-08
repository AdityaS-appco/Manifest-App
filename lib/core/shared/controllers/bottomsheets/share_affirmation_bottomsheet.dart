import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/buttons/facebook_circle_button.dart';
import 'package:manifest/core/shared/widgets/buttons/instagram_circle_button.dart';
import 'package:manifest/core/shared/widgets/buttons/transparent_button.dart';
import 'package:manifest/core/shared/widgets/buttons/x_circle_button.dart';
import 'package:manifest/core/shared/widgets/pill_tab_bar.dart';
import 'package:manifest/core/shared/widgets/touch_splash.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/core/controllers/share_affirmation_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:path_provider/path_provider.dart';

class ShareAffirmationBottomsheet extends StatelessWidget {
  ShareAffirmationBottomsheet({
    Key? key,
    required this.imageUrl,
    required this.affirmationText,
    required this.shareLink,
    this.gradientColors,
    required this.tag,
  }) {
    controller = Get.put(ShareAffirmationController(
      imageUrl: imageUrl,
      affirmationText: affirmationText,
      shareLink: shareLink,
      tag: tag,
    ));
    _imageUrl = imageUrl.obs;
    _gradientColors = gradientColors?.obs ?? RxList<Color>([]);
  }

  final String tag;
  final String imageUrl;
  final String affirmationText;
  final String shareLink;
  final List<Color>? gradientColors;
  final GlobalKey squarePreviewKey = GlobalKey();
  final GlobalKey fullscreenPreviewKey = GlobalKey();
  late ShareAffirmationController controller;
  late RxString _imageUrl;
  late RxList<Color> _gradientColors;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomBottomSheet(
        gradientColors: controller.gradientColors,
        hasBackButton: false,
        topPadding: 10.h,
        horizontalPadding: 0.w,
        buttonsTopPadding: 35.h,
        buttonsHorizontalPadding: 20.w,
        body: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                SizedBox(
                  height: 356.r,
                  child: TabBarView(
                    /// * Disable tab controller if edit mode is active
                    controller: controller.tabController,
                    children: [
                      RepaintBoundary(
                        key: squarePreviewKey,
                        child:
                            _buildPreviewContainer(controller, isSquare: true),
                      ),
                      RepaintBoundary(
                        key: fullscreenPreviewKey,
                        child:
                            _buildPreviewContainer(controller, isSquare: false),
                      ),
                    ],
                  ),
                ),
                30.height,
                if (!controller.isEditMode.value)
                  ..._buildEditModeOffView
                else
                  ..._buildEditModeOnView,
              ],
            ),
          ),
        ),
        primaryButtonText: controller.isEditMode.value ? 'Save' : null,
        onPrimaryButtonPressed: controller.isEditMode.value
            ? () => controller
                .onBackgroundSave(controller.selectedBackgroundImage.value!)
            : null,
      ),
    );
  }

  List<Widget> get _buildEditModeOnView {
    final selectedBackgroundImage = controller.selectedBackgroundImage;
    void changeBackground(ShareBackgroundImage image) {
      selectedBackgroundImage.value = image;
    }

    return [
      SizedBox(
        height: 185.h,
        child: ListView.separated(
          itemCount: controller.backgroundImages.length,
          separatorBuilder: (context, index) => 10.width,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final isSelected = selectedBackgroundImage.value ==
                controller.backgroundImages[index];
            final backgroundImage = controller.backgroundImages[index];
            return Container(
              padding: index == 0
                  ? const EdgeInsets.only(left: 16.0)
                  : index == controller.backgroundImages.length - 1
                      ? const EdgeInsets.only(right: 16.0)
                      : null,
              child: _shareBackgroundCard(
                backgroundImage,
                isSelected: isSelected,
                onBackgroundSelect: changeBackground,
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _shareBackgroundCard(
    ShareBackgroundImage image, {
    required bool isSelected,
    required Function(ShareBackgroundImage) onBackgroundSelect,
  }) {
    return Column(
      children: [
        TouchSplash(
          height: 139.r,
          borderRadius: BorderRadius.circular(10.r),
          onPressed: () => onBackgroundSelect(image),
          child: AppCachedImage(
            imageUrl: image.imageUrl,
            height: 139.r,
            width: 139.r,
            fit: BoxFit.cover,
            border: isSelected
                ? Border.all(
                    color: AppColors.light,
                    width: 2.r,
                    strokeAlign: BorderSide.strokeAlignInside,
                  )
                : Border.all(
                    color: Colors.white.withOpacity(0.05),
                  ),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        16.height,
        Text(
          image.title,
          style: helveticaPageTitleTextStyle(
            color:
                isSelected ? AppColors.light : AppColors.light.withOpacity(0.6),
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  List<Widget> get _buildEditModeOffView {
    return [
      _buildTabBar(controller),
      25.height,
      TransparentButton.icon(
        text: 'Edit Background',
        svgIcon: IconAllConstants.edit03,
        onPressed: controller.toggleEditMode,
      ),
      40.height,
      Text(
        'Share with your friends and family',
        textAlign: TextAlign.center,
        style: helveticaPageTitleTextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.38,
        ),
      ),
      24.height,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30).r,
        child: _buildShareOptions(controller),
      ),
      42.height,
    ];
  }

  Widget _buildTabBar(ShareAffirmationController controller) {
    return SizedBox(
      child: PillTabBar(
          controller: controller.tabController,
          width: 215.w,
          height: 40.h,
          padding: 2,
          activeTabTextStyle: Get.appTextTheme.pillActiveTabTextSmall,
          inactiveTabTextStyle: Get.appTextTheme.pillInactiveTabTextSmall,
          tabs: const [
            Tab(text: 'Square'),
            Tab(text: 'Fullscreen'),
          ]),
    );
  }

  Widget _buildPreviewContainer(
    ShareAffirmationController controller, {
    required bool isSquare,
  }) {
    return Center(
      child: SizedBox(
        height: isSquare ? 356.r : 415.r,
        width: isSquare ? 356.r : 261.r,
        child: Stack(
          children: [
            /// * Background
            AppCachedImage(
              imageUrl: controller.selectedBackgroundImage.value.imageUrl,
              height: isSquare ? 356.r : 415.r,
              width: isSquare ? 356.r : 261.r,
              borderRadius: BorderRadius.circular(20).r,
            ),

            /// * Text
            Center(
              child: Padding(
                padding: EdgeInsets.all(isSquare ? 27 : 23).r,
                child: Text(
                  affirmationText,
                  style: tanMemoriesPageTitleTextStyle(
                    color: controller.colorExtractor.textColor.value ??
                        Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            /// * Logo
            Positioned(
              top: 24.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25.h,
                    child: SvgPicture.asset(
                      "assets/logo/manifest_full_logo.svg",
                      color: controller.colorExtractor.textColor.value ??
                          Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Text(
                '@getmanifest.app',
                style: TextStyle(
                  fontFamily: 'Athletics',
                  color: (controller.colorExtractor.textColor.value ??
                          Colors.white)
                      .withOpacity(0.4),
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOptions(
    ShareAffirmationController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShareButton(
          'Copy Link',
          type: ShareButtonType.custom,
          iconPath: IconAllConstants.linkChain,
          onPressed: controller.copyLink,
        ),
        _buildShareButton(
          'X',
          type: ShareButtonType.x,
          onPressed: () => _handleShare(controller.shareToX),
        ),
        _buildShareButton(
          'Instagram',
          type: ShareButtonType.instagram,
          onPressed: () => _handleShare(controller.shareToInstagram),
        ),
        _buildShareButton(
          'Facebook',
          type: ShareButtonType.facebook,
          onPressed: () => _handleShare(controller.shareToFacebook),
        ),
        _buildShareButton(
          'More',
          type: ShareButtonType.custom,
          iconPath: IconAllConstants.menuHorizontalDots_v1,
          onPressed: () => _handleShare(controller.shareMore),
        ),
      ],
    );
  }

  Future<void> _handleShare(
    Future<void> Function({String? imagePath}) shareFunction,
  ) async {
    try {
      final imageBytes = await UiUtils.convertWidgetToImage(
        controller.isSquare ? squarePreviewKey : fullscreenPreviewKey,
      );
      if (imageBytes != null) {
        final tempDir = await getTemporaryDirectory();
        final file = File(
            '${tempDir.path}/share_image_${DateTime.now().millisecondsSinceEpoch}.png');
        await file.writeAsBytes(imageBytes);
        await shareFunction(imagePath: file.path);
      } else {
        await shareFunction();
      }
    } catch (e) {
      LogUtil.e('Error handling share: $e');
      await shareFunction();
    }
  }

  Widget _buildShareButton(
    String label, {
    String? iconPath,
    required VoidCallback onPressed,
    ShareButtonType? type,
  }) {
    return switch (type) {
      ShareButtonType.facebook => FacebookCircleButton(onPressed: onPressed),
      ShareButtonType.x => XCircleButton(onPressed: onPressed),
      ShareButtonType.instagram => InstagramCircleButton(onPressed: onPressed),
      _ => SvgCircleButton(
          iconPath!,
          enabledColor: AppColors.light.withOpacity(0.1),
          iconColor: AppColors.light,
          onPressed: onPressed,
          buttonSize: 50,
          iconSize: 20,
        ),
    };
  }
}

enum ShareButtonType {
  facebook,
  x,
  instagram,
  custom,
}
