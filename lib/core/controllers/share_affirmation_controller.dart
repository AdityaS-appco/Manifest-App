import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants/assets/image_constants.dart';
import 'package:manifest/core/services/share_service.dart';
import 'package:manifest/core/utils/color_extractor.dart';
import 'package:manifest/core/utils/helpers.dart';

class ShareBackgroundImage {
  final String title;
  final String imageUrl;

  ShareBackgroundImage({required this.title, required this.imageUrl});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShareBackgroundImage &&
        title == other.title &&
        imageUrl == other.imageUrl;
  }
  @override
  int get hashCode => title.hashCode ^ imageUrl.hashCode;
}

class ShareAffirmationController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final RxBool isEditMode = false.obs;
  final RxBool isConvertingToImage = false.obs;
  final ShareService shareService = Get.find<ShareService>();
  final ColorExtractorController colorExtractor =
      Get.put(ColorExtractorController());
  final temporarilySelectedBackgroundIndex = 0.obs;

  final Rx<ShareBackgroundImage> selectedBackgroundImage;
  final RxList<ShareBackgroundImage> backgroundImages;

  final String imageUrl;
  final String affirmationText;
  final String shareLink;
  final String tag;

  ShareAffirmationController({
    required this.imageUrl,
    required this.affirmationText,
    required this.shareLink,
    required this.tag,
  })  : selectedBackgroundImage = ShareBackgroundImage(
          title: affirmationText,
          imageUrl: imageUrl,
        ).obs,
        backgroundImages = [
          ShareBackgroundImage(
            title: tag.capitalize!,
            imageUrl: imageUrl,
          ),
          ShareBackgroundImage(
            title: 'Space',
            imageUrl: ImageConstants.shareBackground1,
          ),
          ShareBackgroundImage(
            title: 'Lake',
            imageUrl: ImageConstants.shareBackground2,
          ),
        ].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    // Extract colors from initial image
    _extractColorsFromImage(imageUrl);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  void onBackgroundSave(ShareBackgroundImage backgroundImage) {
    // Save the selected background
    selectedBackgroundImage.value = backgroundImage;
    _extractColorsFromImage(selectedBackgroundImage.value.imageUrl);
    toggleEditMode();
  }

  RxBool isBackgroundSelected(index) {
    return (selectedBackgroundImage.value == backgroundImages[index]).obs;
  }

  bool get isSquare => tabController.index == 0;

  /// * Extract colors from the given image URL
  Future<void> _extractColorsFromImage(String imageUrl) async {
    final imageType = getImageType(imageUrl);
    if (imageType == ImageType.network) {
      await colorExtractor.extractColorsFromNetworkImage(imageUrl);
    } else if (imageType == ImageType.asset) {
      await colorExtractor.extractColorsFromAssetImage(imageUrl);
    }
  }

  /// * Get the current gradient colors
  List<Color>? get gradientColors {
    if (colorExtractor.threeColorGradient.value != null) {
      return colorExtractor.threeColorGradient.value;
    } else if (colorExtractor.twoColorGradient.value != null) {
      return colorExtractor.twoColorGradient.value;
    }
    return null;
  }

  Color get textColor => colorExtractor.textColor.value ?? Colors.white;

  /// * social share
  Future<void> copyLink() async {
    await shareService.copyToClipboard(shareLink);
  }

  Future<void> shareToFacebook({String? imagePath}) async {
    await shareService.shareToFacebook(
      text: affirmationText,
      url: shareLink,
      imagePath: imagePath ?? '',
    );
  }

  Future<void> shareToInstagram({String? imagePath}) async {
    await shareService.shareToInstagramFeed(
      text: affirmationText,
      url: shareLink,
      imagePath: imagePath,
    );
  }

  Future<void> shareToX({String? imagePath}) async {
    await shareService.shareToX(
      text: affirmationText,
      url: shareLink,
      imagePath: imagePath,
    );
  }

  Future<void> shareMore({String? imagePath}) async {
    await shareService.shareMore(
      text: affirmationText,
      url: shareLink,
      imagePath: imagePath,
    );
  }
}
