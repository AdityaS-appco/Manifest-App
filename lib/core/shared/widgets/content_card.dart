import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants/argument_constants.dart';
import 'package:manifest/core/utils/extensions/get_context.extension.dart';
import 'package:manifest/core/utils/extensions/responsive_sized_box.extension.dart';
import 'package:manifest/core/utils/navigation_util.dart';
import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/features/explore/views/playlist_details_screen.dart';
import 'package:manifest/features/paywall/secondary_paywall_screen.dart';
import 'package:manifest/features/playlist/playlist_type.enum.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/navbar_screens/home/widgets/home_entity_card_playlist_icon.dart';
import 'package:manifest/view/navbar_screens/home/widgets/home_entity_card_premium_icon.dart';
import 'package:manifest/view/navbar_screens/home/widgets/manifest_entity_card_duration_widget.dart';
import 'package:manifest/features/media_player/media_player_screen.dart';

enum ContentCardType {
  rectangle,
  square,
}

/// A reusable content card widget for displaying playlist or affirmation items
class ContentCard extends StatelessWidget {
  /// Image URL to display
  final String? imageUrl;

  final ImageData? image;

  /// Title of the content
  final String title;

  /// Optional subtitle (e.g. track count, author)
  final String? subtitle;

  /// Whether the content is locked (premium)
  final bool isLocked;

  /// Whether the content is a playlist
  final bool isPlaylist;

  /// Duration of the content (if applicable)
  final String? duration;

  /// Card type (rectangle or square)
  final ContentCardType cardType;

  /// ID of the content (for navigation)
  final int? id;

  /// Playlist type (for navigation)
  final PlaylistType? playlistType;

  /// Custom onTap handler
  final VoidCallback? onTap;

  /// Crop data for the image
  final ImageData? cropData;

  const ContentCard({
    Key? key,
    this.imageUrl,
    this.image,
    required this.title,
    this.subtitle,
    this.isLocked = false,
    this.isPlaylist = false,
    this.duration,
    this.cardType = ContentCardType.square,
    this.id,
    this.playlistType,
    this.onTap,
    this.cropData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked
          ? () => Get.to(() => const SecondaryPaywall())
          : (onTap ?? _defaultOnTap),
      child: Container(
        width: cardType == ContentCardType.rectangle ? 272.w : 170.w,
        height: cardType == ContentCardType.rectangle ? 183.w : 170.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0).r,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Image container with overlays
            SizedBox(
              height: cardType == ContentCardType.rectangle ? 183.h : 170.h,
              width: cardType == ContentCardType.rectangle ? 272.w : 170.w,
              child: Stack(
                children: [
                  AppCachedImage(
                    image: image,
                    height:
                        cardType == ContentCardType.rectangle ? 183.h : 170.h,
                    width:
                        cardType == ContentCardType.rectangle ? 272.w : 170.w,
                    border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        strokeAlign: BorderSide.strokeAlignInside),
                    borderRadius: BorderRadius.circular(12.0.r),
                  ),
                  // * show the lock icon
                  if (isLocked) const HomeEntityCardPremiumIcon(),

                  // * show the collection icon
                  if (isPlaylist)
                    HomeEntityCardPlaylistIcon(
                      right: cardType == ContentCardType.square ? 10 : null,
                      left: cardType == ContentCardType.square ? null : 10,
                    ),

                  // * show the total track duration
                  if (duration != null)
                    ManifestEntityCardDurationWidget(
                      duration: duration!,
                      left: cardType == ContentCardType.square ? 10 : null,
                      right: cardType == ContentCardType.square ? null : 10,
                    ),
                ],
              ),
            ),
            15.height,

            // * show the title
            if (title.isNotEmpty) ...[
              Text(
                title.capitalize!,
                style: Get.appTextTheme.contentCardTitle,
              ),
              6.height,
            ],

            // * show the subtitle
            if (subtitle != null)
              Text(
                subtitle!.capitalize!,
                style: Get.appTextTheme.contentCardSubtitle,
              ),
          ],
        ),
      ),
    );
  }

  /// Default navigation action if no custom onTap is provided
  void _defaultOnTap() {
    if (id != null) {
      if (isPlaylist) {
        // Navigate to playlist details screen
        NavigationUtil.toWithDelay(
          navigateTo: () => PlaylistDetailsScreen(
            key: Key(id.toString()),
          ),
          arguments: {
            ArgumentConstants.playlistId: id,
            ArgumentConstants.playlistType: playlistType ?? PlaylistType.admin,
          },
        );
      } else {
        // Navigate to media player screen with track
        NavigationUtil.toWithDelay(
          navigateTo: () => MediaPlayerScreen(key: Key(id.toString())),
          arguments: {
            ArgumentConstants.trackID: id,
          },
        );
      }
    }
  }

  // ImageData _getImageCropData(ContentCardType cardType) {
  //   return switch (cardType) {
  //     ContentCardType.rectangle => ImageData.testFourXThree(),
  //     ContentCardType.square => ImageData.testOneXOne(),
  //   };
  // }
}
