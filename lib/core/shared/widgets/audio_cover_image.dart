import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';

class AudioCoverImage extends StatelessWidget {
  const AudioCoverImage(
    this.artworkUrl, {
    this.type = AudioType.mp3,
    this.imageSize = 60,
    this.borderRadius = 10,
    this.iconColor = Colors.white,
    this.iconSize = 24,
    this.backgroundColor,
    this.isCoverImageEditable = false,
    this.hasBorder = true,
    this.overlayWidget,
  });

  /// The URL of the artwork image
  final String? artworkUrl;

  /// The type of audio (mp3 or recording)
  final AudioType? type;

  /// size of the image container
  final double imageSize;

  /// Border radius for the image container
  final double borderRadius;

  /// Color of the fallback icon
  final Color iconColor;

  /// Size of the fallback icon
  final double iconSize;

  /// Background color of the container
  final Color? backgroundColor;

  final bool isCoverImageEditable;
  final bool hasBorder;
  final Widget? overlayWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: imageSize.r,
          height: imageSize.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius).r,
            border: !(artworkUrl != null && artworkUrl != "") && hasBorder
                ? Border.all(
                    color: Colors.white.withOpacity(0.05),
                    width: 1,
                  )
                : null,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                const Color(0xFF999999).withOpacity(0.1)
              ],
              begin: const Alignment(0.50, -0.00),
              end: const Alignment(0.50, 1.00),
            ),
          ),
          child: (artworkUrl != null && artworkUrl != "")
              ? AppCachedImage(
                  imageUrl: artworkUrl!,
                  borderRadius: BorderRadius.circular(borderRadius).r,
                  height: imageSize.r,
                  width: imageSize.r,
                  border: hasBorder
                      ? Border.all(
                          color: Colors.white.withOpacity(0.1),
                          strokeAlign: BorderSide.strokeAlignInside,
                          width: 1,
                        )
                      : null,
                )
              : Center(
                  child: SvgPicture.asset(
                    type == AudioType.recording
                        ? IconAllConstants.microphone01
                        : IconAllConstants.musicNote01,
                    color: iconColor,
                    width: iconSize.r,
                    height: iconSize.r,
                  ),
                ),
        ),
        if (isCoverImageEditable)
          Transform.translate(
            offset: Offset((imageSize - 24), (imageSize - 24)),
            child: overlayWidget ??
                SvgCircleButton(
                  IconAllConstants.camera01,
                  iconSize: 19,
                  padding: const EdgeInsets.all(8),
                  onPressed: () {},
                  enabledColor: Colors.white.withOpacity(0.2),
                  borderColor: Colors.white.withOpacity(0.1),
                  blurAmount: 30,
                ),
          )
      ],
    );
  }
}
