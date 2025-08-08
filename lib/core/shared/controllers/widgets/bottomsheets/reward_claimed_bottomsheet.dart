import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';
import 'package:video_player/video_player.dart';

class RewardClaimedBottomSheet extends StatelessWidget {
  const RewardClaimedBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      hasBackButton: false,
      body: Stack(
        children: [
          _buildVideoPlayer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              350.height,
              _buildClaimMessage(),
              158.height,
            ],
          ),
        ],
      ),
      primaryButtonText: "Explore Now",
      onPrimaryButtonPressed: () {},
    );
  }

  Widget _buildVideoPlayer() {
    // Create the controller outside the dialog to have access to it for disposal
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.asset(
      'assets/gift_unboxing.webm',
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

    return Obx(
      () => AnimatedOpacity(
        opacity: isInitialized.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: isInitialized.value
            ? Transform.translate(
                offset: const Offset(25, 0),
                child: Transform.scale(
                  scale: 1.8,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: 550.w,
                      height: 570.h,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                ),
              )
            : const SizedBox(height: 320),
      ),
    );
  }

  Widget _buildClaimMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 325.w,
          child: Text(
            'Congrats! You’ve Earned 60 Days of Manifest+',
            style: Get.appTextTheme.dialogTitle,
            textAlign: TextAlign.center,
          ),
        ),
        14.height,
        SizedBox(
          width: 301.w,
          child: Text(
            "Access 20,000+ affirmations, thousands of tracks, 100+ background music options, and manifestation boosters—free for 90 days!",
            textAlign: TextAlign.center,
            style: Get.appTextTheme.dialogSubtitle,
          ),
        ),
      ],
    );
  }
}
