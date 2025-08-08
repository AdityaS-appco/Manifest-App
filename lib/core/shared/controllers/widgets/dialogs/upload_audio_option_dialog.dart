import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/views/blur_screen.dart';
import 'package:manifest/core/shared/widgets/touch_splash.dart';
import 'package:manifest/features/playlist/by_you/controllers/audio_upload_controller.dart';
import 'package:manifest/features/playlist/by_you/controllers/by_you_by_alok_controller.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/import.dart';

class UploadAudioOptionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlurScreen(
        blurAmount: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildOptionRow(),
            24.height,
            SvgCircleButton(
              IconAllConstants.xClose,
              iconSize: 32,
              padding: const EdgeInsets.all(14),
              enabledColor: Colors.transparent,
              borderColor: Colors.white.withOpacity(0.2),
              onPressed: () {
                Get.back();
              },
            ),
            58.height,
          ],
        ));
  }

  Row _buildOptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildOptions("Record affirmation",
            iconPath: IconAllConstants.microphone01Outlined,
            onTap: () =>
                Get.find<ByYouByAlokController>().navigateToAffirmationList()),
        10.width,
        _buildOptions(
          "Upload via URL",
          iconPath: IconAllConstants.link03,
          isLocked: true,
          onTap: () {},
        ),
        10.width,
        _buildOptions(
          "Upload from device",
          iconPath: IconAllConstants.upload02,
          onTap: () => Get.find<AudioUploadController>().pickAudio(
            onMp3sUploaded: (mp3s) {
              Get.back();

              Get.find<ByYouByAlokController>().loadMp3s();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(
    String text, {
    required String iconPath,
    bool isLocked = false,
    required VoidCallback onTap,
  }) {
    return Stack(
      children: [
        TouchSplash(
          splashColor: Colors.white.withOpacity(0.2),
          onPressed: onTap,
          borderRadius: BorderRadius.circular(10).r,
          child: Container(
            width: 114.w,
            height: 116.h,
            padding: const EdgeInsets.all(15.0).r,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(10).r),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(iconPath,
                      height: 26.r,
                      width: 26.r,
                      color: Colors.white.withOpacity(0.8)),
                  10.height,
                  Text(
                    text,
                    style: Get.appTextTheme.blurOverlayButtonText
                        .copyWith(color: Colors.white.withOpacity(0.8)),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
        if (isLocked)
          Positioned(
            top: 8.h,
            right: 8.w,
            child: SvgPicture.asset(
              IconAllConstants.newLock01,
              height: 16.r,
              width: 16.r,
              color: Colors.white.withOpacity(0.3),
            ),
          )
      ],
    );
  }
}
