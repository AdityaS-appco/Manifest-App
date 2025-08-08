import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/views/blur_screen.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/audio_cover_image.dart';
import 'package:manifest/core/shared/widgets/dialogs/custom_dialog.dart';
import 'package:manifest/core/shared/widgets/dialogs/custom_confirmation_dialog.dart';
import 'package:manifest/core/shared/widgets/dialogs/upload_audio_option_dialog.dart';
import 'package:manifest/features/paywall/manifest_entity.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/features/soundscape/views/soundscape_preview_dialog.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/home/widgets/home_entity_card_playlist_icon.dart';
import 'package:manifest/view/navbar_screens/home/widgets/home_entity_card_premium_icon.dart';
import 'package:manifest/view/navbar_screens/home/widgets/manifest_entity_card_duration_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class AppDialogs {
  static void show(Widget dialog) {
    Get.dialog(dialog);
  }

  static void showBlurred(Widget dialog) {
    AppDialogs.show(
      BlurScreen(
        child: dialog,
      ),
    );
  }

  /// * Discord community dialog
  static Future<void> showDiscordCommunity({
    required VoidCallback onJoinPressed,
  }) async {
    await CustomDialog.show(
      headerWidget: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Image.asset(ImageConstants.discord),
      ),
      title: 'Join our Discord community',
      subtitle:
          'Join our growing Manifest Discord community and connect with thousands of Manifestors like you!',
      dialogButtonText: 'Join Now',
      onDialogButtonPressed: onJoinPressed,
    );
  }

  /// * New Releases dialog
  static Future<void> showNewReleases({
    VoidCallback? onClose,
    required List<ManifestEntity> entities,
  }) async {
    await CustomDialog.show(
        title: 'Newly Released',
        subtitle:
            'This week\'s freshest tracks and playlists are here! Discover your next favorite affirmations.',
        content: Column(
          children: [
            FlutterCarousel(
              options: FlutterCarouselOptions(
                height: 200.0,
                showIndicator: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: entities.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: Get.size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              width: Get.size.width,
                              height: 200.0,
                              i.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const HomeEntityCardPremiumIcon(),
                          const HomeEntityCardPlaylistIcon(),
                          const ManifestEntityCardDurationWidget(
                            duration: '00:00',
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'The Zen Way of Living',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Playlist · Rishi Shukla',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ));
  }

  /// Premium Features dialog with video header
  static Future<void> showPremiumFeatures({
    required VoidCallback onExplorePressed,
  }) async {
    // Create the controller outside the dialog to have access to it for disposal
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.asset(
      'assets/manifest-dark-star-splash-small.mp4',
      videoPlayerOptions: VideoPlayerOptions(),
    );

    // Create a mutable state to track initialization
    final isInitialized = false.obs;

    // Initialize the video
    videoPlayerController.initialize().then((_) {
      videoPlayerController.setVolume(0);
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
      isInitialized.value = true;
    }).catchError((error) {
      print('Error initializing video: $error');
    });

    // Show the dialog with an Obx widget to reactively update when video is ready
    await CustomDialog.show(
      headerWidget: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Obx(
          () => AnimatedOpacity(
            opacity: isInitialized.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: isInitialized.value
                ? SizedBox(
                    width: videoPlayerController.value.size.width,
                    height: 180,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: videoPlayerController.value.size.width,
                        height: videoPlayerController.value.size.height,
                        child: VideoPlayer(videoPlayerController),
                      ),
                    ),
                  )
                : const SizedBox(height: 180),
          ),
        ),
      ),
      title: 'Use all the features for free',
      subtitle:
          'Embark on the ultimate journey of mindfulness and self-improvement with Manifest Alpha! Enjoy unlimited access to over 20,000 powerful affirmations, 100+ immersive soundscapes, breathtaking scenes, and a variety of features designed to elevate your well-being. Dive in now and explore it all for free during the alpha phase!',
      dialogButtonText: 'Explore now',
      onDialogButtonPressed: () {
        // Dispose of the controller when dialog is closed
        videoPlayerController.dispose();
        onExplorePressed();
      },
    ).then((_) {
      // Make sure to dispose of the controller when dialog is closed
      videoPlayerController.dispose();
    });
  }

  /// * Shows a reusable iOS-style action sheet dialog
  /// * @param children List of action items to display
  /// * @param title Optional title text
  /// * @param subtitle Optional subtitle text
  /// * @param cancelText Text for the cancel button (defaults to "Cancel")
  /// * @param onCancelPressed Optional callback when cancel is pressed
  static Future<void> showIOSActionSheet({
    required List<IOSActionSheetItem> children,
    String? title,
    String? subtitle,
    String cancelText = "Cancel",
    VoidCallback? onCancelPressed,
  }) async {
    return await showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: title != null
              ? Text(
                  title,
                  style: Get.appTextTheme.dialogExtraSmallTitle,
                )
              : null,
          message: subtitle != null
              ? Text(
                  subtitle,
                  style: Get.appTextTheme.dialogExtraSmallTitle
                      .copyWith(fontWeight: FontWeight.normal),
                )
              : null,
          actions: children.map((item) {
            return CupertinoActionSheetAction(
              isDestructiveAction: item.isDestructive,
              isDefaultAction: item.isDefault,
              onPressed: () {
                Get.back();
                item.onPressed();
              },
              child: Text(
                item.text,
                style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
                  fontWeight:
                      item.isDefault ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
              onCancelPressed?.call();
            },
            child: Text(
              cancelText,
              style: Get.appTextTheme.iosSurveyFormOptionText
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  /// * Shows a reusable iOS-style alert dialog
  /// * @param title The title text of the dialog
  /// * @param subtitle The subtitle/message text of the dialog
  /// * @param continueText Text for the continue button (defaults to "Continue")
  /// * @param onContinuePressed Callback when continue is pressed
  static Future<void> showIOSDialog({
    required String title,
    required String subtitle,
    String continueText = "Continue",
    required VoidCallback onContinuePressed,
    Color? continueTextColor,
  }) async {
    return await showCupertinoDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          subtitle,
          style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
            color: Colors.white,
            fontSize: 13,
            height: 1.38,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              "Cancel",
              style: Get.appTextTheme.iosSurveyFormOptionText,
            ),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(
              continueText,
              style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
                color: continueTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Get.back();
              onContinuePressed();
            },
          ),
        ],
      ),
    );
  }

  /// * Shows Facebook sign-in confirmation dialog
  static Future<void> showFacebookConnectDialog({
    required VoidCallback onContinuePressed,
  }) async {
    return await showIOSDialog(
      title: "\"Manifest\" Wants to Use \"facebook.com\" to Sign In",
      subtitle: "A message should be a short, complete sentence.",
      onContinuePressed: onContinuePressed,
    );
  }

  /// * Shows Facebook sign-in confirmation dialog
  static Future<void> showXConnectDialog({
    required VoidCallback onContinuePressed,
  }) async {
    return await showIOSDialog(
      title: "\"Manifest\" Wants to Use \"x.com\" to Sign In",
      subtitle: "A message should be a short, complete sentence.",
      onContinuePressed: onContinuePressed,
    );
  }

  /// * Shows Facebook sign-in confirmation dialog
  static Future<void> showGoogleConnectDialog({
    required VoidCallback onContinuePressed,
  }) async {
    return await showIOSDialog(
      title: "\"Manifest\" Wants to Use \"google.com\" to Sign In",
      subtitle: "A message should be a short, complete sentence.",
      onContinuePressed: onContinuePressed,
    );
  }

  /// * Shows a survey dialog when user is not taking premium subscription
  static Future<void> showIOSPremiumNotTakingSurvey({
    void Function(String reason)? onReasonSelected,
  }) async {
    return await showIOSActionSheet(
      title: "Aww... are we saying goodbye?",
      subtitle: "If you'd like to cancel, let us know why 😢💔",
      children: [
        IOSActionSheetItem(
          text: "Too expensive",
          onPressed: () => onReasonSelected?.call("Too expensive"),
        ),
        IOSActionSheetItem(
          text: "Don't know how to use/navigate the app",
          onPressed: () =>
              onReasonSelected?.call("Don't know how to use/navigate the app"),
        ),
        IOSActionSheetItem(
          text: "Not satisfied with content/services",
          onPressed: () =>
              onReasonSelected?.call("Not satisfied with content/services"),
        ),
        IOSActionSheetItem(
          text: "Not getting results",
          onPressed: () => onReasonSelected?.call("Not getting results"),
        ),
        IOSActionSheetItem(
          text: "Found a better/more relevant app",
          onPressed: () =>
              onReasonSelected?.call("Found a better/more relevant app"),
        ),
        IOSActionSheetItem(
          text: "Frequent app crashes or bugs",
          onPressed: () =>
              onReasonSelected?.call("Frequent app crashes or bugs"),
        ),
        IOSActionSheetItem(
          text: "Slow loading times",
          onPressed: () => onReasonSelected?.call("Slow loading times"),
        ),
        IOSActionSheetItem(
          text: "Other",
          onPressed: () => onReasonSelected?.call("Other"),
        ),
        IOSActionSheetItem(
          text: "No! I just want to check subscription",
          onPressed: () =>
              onReasonSelected?.call("No! I just want to check subscription"),
        ),
      ],
      cancelText: "Close",
    );
  }

  /// * Shows a survey dialog for "Not interested" reasons
  static Future<void> showIOSDeleteAccountSurvey({
    void Function(String reason)? onReasonSelected,
  }) async {
    return await showIOSActionSheet(
      title: "Not interested?",
      subtitle: "Please share why",
      children: [
        IOSActionSheetItem(
          text: "Tired of the app",
          onPressed: () => onReasonSelected?.call("Tired of the app"),
        ),
        IOSActionSheetItem(
          text: "Don’t need it now",
          onPressed: () => onReasonSelected?.call("Don’t need it now"),
        ),
        IOSActionSheetItem(
          text: "Don’t know what it is",
          onPressed: () => onReasonSelected?.call("Don’t know what it is"),
        ),
        IOSActionSheetItem(
          text: "Too tiring",
          onPressed: () => onReasonSelected?.call("Too tiring"),
        ),
        IOSActionSheetItem(
          text: "Other",
          onPressed: () => onReasonSelected?.call("Other"),
        ),
      ],
      cancelText: "Cancel",
    );
  }

  /// * Shows a dialog asking the user to rate the app with stars
  /// * @param onStarTap Callback with the selected star index (1-5)
  /// * @param onNotNow Optional callback for "Not now"
 static Future<void> showRateAppDialog({
  required void Function(int starCount) onStarTap,
  VoidCallback? onNotNow,
}) async {
  await showCupertinoModalPopup(
    barrierDismissible: true,
    context: Get.context!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          int selectedStars = 0;
          
          return CupertinoAlertDialog(
            title: Column(
              children: [
                Text(
                  "Enjoying Manifest?",
                  style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            content: Text(
              "Tap a star to rate it on App store.",
              style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        final starNumber = index + 1;
                        final isSelected = starNumber <= selectedStars;
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedStars = starNumber;
                            });
                            // Don't close automatically - just update the UI
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              IconAllConstants.rateAppStar,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                isSelected 
                                  ? AppColors.iosBlue 
                                  : AppColors.iosBlue.withOpacity(0.3),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Add a Submit button that appears when stars are selected
              if (selectedStars > 0)
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Get.back();
                    onStarTap(selectedStars);
                  },
                  child: Text(
                    "Submit Rating",
                    style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
                      color: AppColors.iosBlue,
                    ),
                  ),
                ),
              CupertinoDialogAction(
                isDefaultAction: selectedStars == 0,
                onPressed: () {
                  Get.back();
                  onNotNow?.call();
                },
                child: Text(
                  "Not now",
                  style: Get.appTextTheme.iosSurveyFormOptionText.copyWith(
                    color: AppColors.iosBlue,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

  static Future<void> showBannerImageWithContent({
    required String image,
    String? title,
    String? subtitle,
    VoidCallback? onPressed,
    bool hasCloseButton = true,
    VoidCallback? onClosePressed,
  }) async {
    return CustomDialog.show(
      title: title ?? '',
      subtitle: subtitle ?? '',
      dialogButtonText: 'Close',
      headerWidget: Transform.scale(
        scale: 1.05,
        child: Transform.translate(
          offset: const Offset(0, -15),
          child: Image.asset(
            image,
            width: 351.w,
            height: 228.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
      onDialogButtonPressed: onClosePressed,
      contentPadding: const EdgeInsets.symmetric(vertical: 16).r,
      // content: SizedBox(width: 35.w),
    );
  }

  static Future<void> showBoosterDialog() async {
    return showBannerImageWithContent(
      image: 'assets/booster.gif',
      title: 'Boost Your Results Instantly!',
      subtitle:
          'Boost your focus, confidence, and relaxation with quick affirmations and binaural beats, tailored to elevate your results instantly.',
    );
  }

  static Future<void> showUploadAudioOptionsDialog() async {
    show(UploadAudioOptionDialog());
  }

  static Future<void> showDeleteRecordingConfirmationDialog() async {
    show(
      CustomConfirmationDialog(
        primaryButtonColor: AppColors.danger,
        primaryButtonTextColor: Colors.white,
        primaryButtonText: "Yes, delete",
        headerChildren: [
          AudioCoverImage(
            null,
            type: AudioType.recording,
            imageSize: 160,
            iconSize: 84,
            overlayWidget: Container(
              padding: const EdgeInsets.all(12).r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.danger,
                  border: Border.all(color: Colors.white.withOpacity(0.1))),
              child: SvgPicture.asset(
                IconAllConstants.trash03,
                height: 24.r,
                width: 24.r,
                color: Colors.white,
              ),
            ),
          ),
          20.height,
          Text(
            "Recording 1",
            style: Get.appTextTheme.headingExtraSmallRounded.copyWith(
              height: 1.05,
            ),
          ),
          6.height,
          Text(
            "10:10",
            style: Get.appTextTheme.pageSubtitle.copyWith(
              color: const Color(0x99EBEBF5),
              height: 1.14,
            ),
            textAlign: TextAlign.center,
          ),
          24.height,
          SizedBox(
            width: 243.w,
            child: Text(
              "Are you sure want to delete this recording?",
              style: Get.appTextTheme.headingExtraSmallRounded.copyWith(
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          12.height,
          SizedBox(
            width: 253.w,
            child: Text(
              "This action cannot be undone. Once deleted, you won’t be able to recover it",
              style: Get.appTextTheme.pageSubtitle.copyWith(
                color: const Color(0x7FEBEBF5),
                height: 1.29,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showRenameRecordingConfirmationDialog() async {
    show(
      CustomConfirmationDialog(
        headerChildren: [
          const AudioCoverImage(
            null,
            type: AudioType.recording,
            imageSize: 166,
            iconSize: 84,
          ),
          24.height,
          SizedBox(
            height: 55.h,
            child: AppTextField(
                textAlign: TextAlign.center,
                hasPrefix: false,
                textStyle: Get.appTextTheme.headingExtraSmall.copyWith(
                  height: 1.05,
                )),
          )
        ],
      ),
    );
  }

  static Future<void> showSoundscapePreviewDialog(
      {required String title, required String subtitle}) async {
    show(SoundscapePreviewDialog(title: title, subtitle: subtitle));
  }
}

/// * A class to represent an item in the iOS action sheet
class IOSActionSheetItem {
  final String text;
  final VoidCallback onPressed;
  final bool isDestructive;
  final bool isDefault;

  const IOSActionSheetItem({
    required this.text,
    required this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  });
}
