import 'package:manifest/core/shared/views/blur_screen.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class BackgroundMusicBottomSheet extends StatelessWidget {
  const BackgroundMusicBottomSheet(
    this.soundscape, {
    this.onPlayTap,
    this.onAddToDownloadTap,
    this.onRemoveFromDownloadTap,
  });

  final Soundscape soundscape;
  final VoidCallback? onPlayTap;
  final VoidCallback? onAddToDownloadTap;
  final VoidCallback? onRemoveFromDownloadTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 10),
      child: BlurScreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: AppCachedImage(
                    imageUrl: soundscape.artCover?.imageName ?? '',
                    height: 60,
                    width: 60,
                  ),
                  title: Text(
                    soundscape.name ?? "Untitled",
                    style: secondaryWhiteTextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    soundscape.description ?? 'Soundscape',
                    style: secondaryWhiteTextStyle(
                        color: descriptionLightColor,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                20.height,
                if (onPlayTap != null) ...[
                  ListTile(
                    onTap: onPlayTap,
                    contentPadding: EdgeInsets.zero,
                    leading: TransparentSvgCircleButton(
                      AppIcons.play,
                      iconColor: AppColors.light,
                    ),
                    title: Text(
                      'Play',
                      style: secondaryWhiteTextStyle(
                        color: descriptionLightColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  20.height,
                ],
                if (onAddToDownloadTap != null) ...[
                  ListTile(
                    onTap: onAddToDownloadTap,
                    contentPadding: EdgeInsets.zero,
                    leading: TransparentSvgCircleButton(
                      IconAllConstants.downloadCircle19,
                      iconColor: AppColors.light,
                    ),
                    title: Text(
                      'Add to downloaded',
                      style: secondaryWhiteTextStyle(
                          color: descriptionLightColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  20.height,
                ],
                if (onRemoveFromDownloadTap != null) ...[
                  ListTile(
                    onTap: onRemoveFromDownloadTap,
                    contentPadding: EdgeInsets.zero,
                    leading:
                        showSvgIconWidget(iconPath: AppIcons.deleteDownload),
                    title: Text(
                      'Remove from downloaded',
                      style: secondaryWhiteTextStyle(
                          color: descriptionLightColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  20.height,
                ],
                Center(
                    child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: secondaryWhiteTextStyle(
                        color: descriptionLightColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500),
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
