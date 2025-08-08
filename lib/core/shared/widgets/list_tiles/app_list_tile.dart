import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/audio_cover_image.dart';
import 'package:manifest/core/shared/widgets/buttons/secondary_page_button.dart';
import 'package:manifest/core/shared/widgets/buttons/tag_x_button.dart';
import 'package:manifest/core/shared/widgets/gradient_icon.dart';
import 'package:manifest/core/shared/widgets/gradient_progress_bar.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';

/// * A flexible ListTile widget that supports multiple designs
/// * Use factory constructors to create different variations
class AppListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final List<Widget>? trailing;
  final VoidCallback? onTap;
  final bool showForwardArrow;
  final bool isSelected;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? titleSubtitleSpacing;
  final double? pastLeadingSpacing;
  final Border? border;
  final BorderRadius? borderRadius;
  final Color? activeTileColor;
  final Color? inactiveTileColor;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final double? titleLineHeight;
  final double? subtitleLineHeight;
  final double? titleLetterSpacing;
  final double? subtitleLetterSpacing;
  final Widget? customBody;
  final TextAlign? textAlign;
  final int? maxTitleLines;
  final int? maxSubtitleLines;
  const AppListTile._({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showForwardArrow = false,
    this.isSelected = false,
    this.contentPadding,
    this.titleStyle,
    this.subtitleStyle,
    this.titleSubtitleSpacing,
    this.pastLeadingSpacing,
    this.border,
    this.borderRadius,
    this.activeTileColor,
    this.inactiveTileColor,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleLineHeight,
    this.subtitleLineHeight,
    this.titleLetterSpacing,
    this.subtitleLetterSpacing,
    this.customBody,
    this.textAlign,
    this.maxTitleLines,
    this.maxSubtitleLines,
  }) : super(key: key);

  /// * Factory for Collection/Playlist tile
  /// * Shows icon/image, title, subtitle with items count and duration
  factory AppListTile.collection({
    Key? key,
    required String title,
    required String itemCount,
    required String duration,
    required String iconPath,
    VoidCallback? onTap,
    bool isSelected = false,
  }) {
    return AppListTile._(
      key: key,
      leading: Container(
        width: 56.r,
        height: 56.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 24.r,
            height: 24.r,
            color: Colors.white,
          ),
        ),
      ),
      title: title,
      subtitle: '$itemCount · $duration',
      showForwardArrow: true,
      onTap: onTap,
      isSelected: isSelected,
    );
  }

  /// * Factory for Playlist tile with creator name
  /// * Shows artwork, title, "Playlist · Creator Name", and more options
  factory AppListTile.playlistWithCreatorName({
    Key? key,
    required String title,
    required String creatorName,
    required String artworkUrl,
    VoidCallback? onTap,
    VoidCallback? onMoreTap,
    bool isSelected = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppListTile._(
      key: key,
      leading: AppCachedImage(
        width: 60.r,
        height: 60.r,
        imageUrl: artworkUrl,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      title: title,
      subtitle: 'Playlist · $creatorName',
      trailing: [
        GestureDetector(
          onTap: onMoreTap,
          child: SvgPicture.asset(
            IconAllConstants.verticalMenu,
            color: Colors.white.withOpacity(0.5),
            width: 16.r,
            height: 16.r,
          ),
        ),
      ],
      onTap: onTap,
      isSelected: isSelected,
      titleFontSize: 15,
      subtitleFontSize: 11,
      titleSubtitleSpacing: 4,
      titleLineHeight: 1.4,
      subtitleLineHeight: 1.18,
      titleLetterSpacing: -0.4,
      subtitleLetterSpacing: -0.4,
      contentPadding:
          contentPadding ?? const EdgeInsets.symmetric(horizontal: 20).r,
    );
  }

  /// * Factory for Track tile with creator name
  /// * Shows artwork, title, "Track · Creator Name", and more options
  factory AppListTile.trackWithCreatorName({
    Key? key,
    required String title,
    required String creatorName,
    required String artworkUrl,
    VoidCallback? onTap,
    VoidCallback? onMoreTap,
    bool isSelected = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppListTile._(
      key: key,
      leading: AppCachedImage(
        width: 60.r,
        height: 60.r,
        imageUrl: artworkUrl,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      title: title,
      subtitle: 'Track · $creatorName',
      trailing: [
        GestureDetector(
          onTap: onMoreTap,
          child: SvgPicture.asset(
            IconAllConstants.verticalMenu2,
            color: Colors.white.withOpacity(0.5),
            width: 16.r,
            height: 16.r,
          ),
        ),
      ],
      onTap: onTap,
      isSelected: isSelected,
      titleFontSize: 15,
      subtitleFontSize: 11,
      titleSubtitleSpacing: 4,
      titleLineHeight: 1.4,
      subtitleLineHeight: 1.18,
      titleLetterSpacing: -0.4,
      subtitleLetterSpacing: -0.4,
      contentPadding:
          contentPadding ?? const EdgeInsets.symmetric(horizontal: 20).r,
    );
  }

  /// * Factory for selectable tile with type and duration
  /// * Shows artwork, title, type and duration with selection state
  factory AppListTile.selectableWithTypeAndDuration({
    Key? key,
    required String title,
    required String type,
    required String duration,
    required String artworkUrl,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return AppListTile._(
      key: key,
      leading: AppCachedImage(
        width: 60.r,
        height: 60.r,
        imageUrl: artworkUrl,
        borderRadius: BorderRadius.circular(8.r),
      ),
      title: title,
      subtitle: '$type · $duration',
      titleFontSize: 17,
      titleLineHeight: 1.29,
      titleLetterSpacing: -0.4,
      subtitleFontSize: 11,
      subtitleLineHeight: 1.18,
      subtitleLetterSpacing: -0.4,
      titleSubtitleSpacing: 4,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 11).r,
      trailing: isSelected
          ? [
              SvgPicture.asset(
                IconAllConstants.checkCircle,
                color: AppColors.success,
                width: 24.r,
                height: 24.r,
              ),
            ]
          : [
              SvgPicture.asset(
                IconAllConstants.circle,
                color: Colors.white,
                width: 24.r,
                height: 24.r,
              )
            ],
      onTap: onTap,
    );
  }

  /// * Factory for simple selectable tile
  /// * Shows artwork, title, subtitle with selection state
  factory AppListTile.selectable({
    Key? key,
    required String title,
    required String subtitle,
    required String artworkUrl,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return AppListTile._(
      key: key,
      titleSubtitleSpacing: 4,
      leading: Container(
        width: 56.r,
        height: 56.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            AppCachedImage(
              imageUrl: artworkUrl,
              borderRadius: BorderRadius.circular(12.r),
            ),
            if (isSelected)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 24.r,
                  ),
                ),
              ),
          ],
        ),
      ),
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      isSelected: isSelected,
    );
  }

  /// * Factory for Collection tile with affirmation count
  /// * Shows artwork, title, affirmation count and duration with forward arrow
  factory AppListTile.contentTile({
    Key? key,
    required String title,
    required String affirmationCount,
    required String duration,
    required String artworkUrl,
    VoidCallback? onTap,
  }) {
    return AppListTile._(
      key: key,
      leading: Container(
        width: 56.r,
        height: 56.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: AppCachedImage(
          imageUrl: artworkUrl,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      title: title,
      titleStyle: Get.appTextTheme.contentTileTitleSmall.copyWith(
        height: 1,
        letterSpacing: 0,
      ),
      subtitle: '$affirmationCount affirmations · $duration',
      subtitleStyle: Get.appTextTheme.contentTileSubtitleSmall.copyWith(
        height: 1.18,
        color: Colors.white.withOpacity(0.3),
        letterSpacing: 0,
      ),
      showForwardArrow: false,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  /// * Factory for Track tile with duration
  /// * Shows artwork, title, "Track · Duration", and more options
  /// * In editing mode, shows reorder and remove icons
  factory AppListTile.trackWithDuration({
    Key? key,
    required String title,
    required String duration,
    required String artworkUrl,
    VoidCallback? onTap,
    VoidCallback? onMoreTap,
    VoidCallback? onRemoveTap,
    bool isEditing = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppListTile._(
      key: key,
      leading: AppCachedImage(
        width: 60.r,
        height: 60.r,
        imageUrl: artworkUrl,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      title: title,
      subtitle: 'Track · $duration',
      contentPadding:
          contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
      titleFontSize: 15,
      subtitleFontSize: 11,
      titleSubtitleSpacing: 4,
      titleLineHeight: 1.4,
      subtitleLineHeight: 1.18,
      titleLetterSpacing: -0.4,
      subtitleLetterSpacing: -0.4,
      trailing: [
        if (isEditing) ...[
          IconButton(
            icon: SvgPicture.asset(
              IconAllConstants.minusCircle,
              width: 20.r,
              height: 20.r,
              color: AppColors.error,
            ),
            onPressed: onRemoveTap,
          ),
          SvgPicture.asset(
            IconAllConstants.menu01,
            color: Colors.white.withOpacity(0.6),
            width: 20.r,
            height: 20.r,
          ),
        ] else
          GestureDetector(
            onTap: onMoreTap,
            child: SvgPicture.asset(
              IconAllConstants.verticalMenu,
              color: Colors.white.withOpacity(0.5),
              width: 16.r,
              height: 16.r,
            ),
          ),
      ],
      onTap: isEditing ? null : onTap,
    );
  }

  /// * Factory for Track tile with controls
  /// * Shows artwork, title, duration, close and more options
  factory AppListTile.trackWithControls({
    Key? key,
    required String title,
    required String duration,
    required String artworkUrl,
    VoidCallback? onTap,
    VoidCallback? onCloseTap,
    VoidCallback? onMoreTap,
  }) {
    return AppListTile._(
      key: key,
      leading: AppCachedImage(
        width: 56.r,
        height: 56.r,
        imageUrl: artworkUrl,
        borderRadius: BorderRadius.circular(12.r),
      ),
      title: title,
      subtitle: duration,
      trailing: [
        IconButton(
          icon: SvgPicture.asset(
            IconAllConstants.voiceActivationDeleteCross5,
            width: 20.r,
            height: 20.r,
            color: Colors.white,
          ),
          onPressed: onCloseTap,
        ),
        IconButton(
          icon: SvgPicture.asset(
            IconAllConstants.verticalMenu,
            width: 20.r,
            height: 20.r,
            color: Colors.white,
          ),
          onPressed: onMoreTap,
        ),
      ],
      onTap: onTap,
    );
  }

  /// * Factory for audio tile
  /// * Shows icon or artwork, title, duration with flexible trailing
  /// * Can be used for recordings or mp3s, group or individual items
  factory AppListTile.audio({
    Key? key,
    required String title,
    required String duration,
    required AudioType type,
    String? artworkUrl,
    bool isGroup = false,
    VoidCallback? onTap,
    VoidCallback? onMoreTap,
  }) {
    return AppListTile._(
      key: key,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 11).r,
      leading: AudioCoverImage(
        artworkUrl,
        type: type,
        borderRadius: 9.3,
      ),
      title: title,
      titleStyle:
          Get.appTextTheme.contentTileTitleSmall.copyWith(letterSpacing: 0),
      subtitle: duration,
      subtitleStyle:
          Get.appTextTheme.contentTileSubtitleSmall.copyWith(letterSpacing: 0),
      titleSubtitleSpacing: 4,
      trailing: isGroup
          ? [
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.6),
                size: 24.r,
              ),
            ]
          : [
              IconButton(
                icon: SvgPicture.asset(
                  IconAllConstants.menuVerticalDots1,
                  color: Colors.white,
                  width: 16.r,
                  height: 16.r,
                ),
                onPressed: onMoreTap,
              ),
            ],
      onTap: onTap,
    );
  }

  /// * Factory for Create New tile
  /// * Shows plus icon and title with forward arrow
  factory AppListTile.createNew({
    Key? key,
    required String title,
    VoidCallback? onTap,
  }) {
    return AppListTile._(
      key: key,
      leading: Container(
        width: 60.r,
        height: 60.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white.withOpacity(0.1),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Center(
          child: SvgPicture.asset(
            IconAllConstants.plus,
            color: Colors.white,
            width: 32.r,
            height: 32.r,
          ),
        ),
      ),
      title: title,
      showForwardArrow: false,
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 11).r,
      titleFontSize: 17,
      titleLineHeight: 1.29,
      titleLetterSpacing: -0.4,
    );
  }

  /// * Factory for Download tile with progress
  /// * Shows icon/artwork, title, progress bar and percentage
  factory AppListTile.download({
    Key? key,
    required String title,
    required String duration,
    required RxDouble progress,
    String? artworkUrl,
    bool isDownloadInProgress = false,
    VoidCallback? onTap,
    VoidCallback? onMoreTap,
  }) {
    return AppListTile._(
      key: key,
      leading: AudioCoverImage(
        artworkUrl,
        borderRadius: 9.23,
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 11).r,
      customBody: isDownloadInProgress
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: Get.appTextTheme.contentTileTitleSmall
                          .copyWith(letterSpacing: 0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    9.width,
                    Obx(
                      () {
                        final progressPercentage =
                            "${(progress * 100).toInt()}%";
                        return Text(
                          progressPercentage,
                          style: Get.appTextTheme.bodySmall.copyWith(
                            color: Colors.white.withAlpha(153),
                            height: 1.75,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ],
                ),
                8.height,
                Obx(
                  () => GradientProgressBar(
                    progress: progress.value,
                    gradientColors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.3),
                    ],
                  ),
                ),
              ],
            )
          : null,
      title: title,
      subtitle: duration,
      trailing: [
        TransparentSvgCircleButton(
          IconAllConstants.menuVerticalDots1_v1,
          onPressed: onMoreTap,
          iconSize: 16,
          padding: const EdgeInsets.all(10).r,
        ),
      ],
      titleSubtitleSpacing: 4,
      onTap: onTap,
    );
  }

  /// * Factory for gradient icon tile
  /// * Shows gradient icon, title, subtitle with forward arrow
  factory AppListTile.gradientIcon({
    Key? key,
    required String icon,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    VoidCallback? onTap,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppListTile._(
      key: key,
      leading: Container(
        width: 60.r,
        height: 60.r,
        padding: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white.withOpacity(0.1),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Center(
          child: GradientIcon(
            icon: icon,
            iconSize: 30.r,
            gradientColors: gradientColors,
            begin: begin,
            end: end,
          ),
        ),
      ),
      title: title,
      subtitle: subtitle,
      titleSubtitleSpacing: 2,
      titleLineHeight: 1.31,
      subtitleLineHeight: 1.33,
      showForwardArrow: true,
      titleLetterSpacing: -0.4,
      subtitleLetterSpacing: -0.4,
      onTap: onTap,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 11,
          ).r,
    );
  }

  /// * Factory for player setting header tile
  /// * Shows artwork, title, subtitle without any interaction
  factory AppListTile.playerSettingHeader({
    Key? key,
    required String title,
    required String subtitle,
    String? artworkUrl,
    EdgeInsetsGeometry? contentPadding,
    AudioType? type,
    bool isArtworkEditable = false,
  }) {
    return AppListTile._(
      key: key,
      onTap: null,
      leading: AudioCoverImage(
        artworkUrl,
        type: type,
        imageSize: 88,
        iconSize: 50,
        isCoverImageEditable: isArtworkEditable,
      ),
      pastLeadingSpacing: 22,
      title: title,
      subtitle: subtitle,
      contentPadding: contentPadding ?? EdgeInsets.zero,
      titleSubtitleSpacing: 12,
      titleStyle: Get.appTextTheme.titleMediumRounded.copyWith(
        height: 1,
      ),
      subtitleStyle: Get.appTextTheme.bottomsheetSubtitle.copyWith(
        height: 1,
      ),
    );
  }

  /// * Factory for player setting option tile
  /// * Shows icon and title with forward arrow
  factory AppListTile.playerSettingOption({
    Key? key,
    required String title,
    required String iconPath,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppListTile._(
      key: key,
      leading: SvgPicture.asset(
        iconPath,
        width: 20.r,
        height: 20.r,
        color: iconColor,
      ),
      title: title,
      showForwardArrow: false,
      onTap: onTap,
      contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 8.r),
      titleStyle: Get.appTextTheme.tileWithIconTitle,
    );
  }

  /// * Factory for affirmation tile
  /// * Shows affirmation text with more options and selection state
  factory AppListTile.affirmation({
    Key? key,
    required String text,
    bool isSelected = false,
    VoidCallback? onTap,
    VoidCallback? onMoreTap,
    bool isHidden = false,
  }) {
    return AppListTile._(
        key: key,
        title: text,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 12.r),
        trailing: [
          if (isHidden)
            GestureDetector(
              onTap: onMoreTap,
              child: SvgPicture.asset(
                IconAllConstants.verticalMenu,
                color: Colors.white.withOpacity(0.5),
                width: 16.r,
                height: 16.r,
              ),
            )
          else
            SvgPicture.asset(
              IconAllConstants.invisible1_1_v1,
              color: Colors.white.withOpacity(0.5),
              width: 16.r,
              height: 16.r,
            ),
        ],
        onTap: onTap,
        isSelected: isSelected,
        titleStyle: helveticaPageTitleTextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        activeTileColor: Colors.white.withOpacity(0.08),
        inactiveTileColor: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: isSelected
            ? Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              )
            : Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1,
              ));
  }

  /// * Factory for affirmation tile
  /// * Shows affirmation text with more options and selection state
  factory AppListTile.likedAffirmation({
    Key? key,
    required String affirmationText,
    VoidCallback? onLike,
  }) {
    return AppListTile._(
      key: key,
      title: affirmationText,
      maxTitleLines: 2,
      contentPadding: const EdgeInsets.all(16).r,
      trailing: [
        Transform.scale(
          scale: 2,
          child: TransparentSvgCircleButton(
            IconAllConstants.heartRounded,
            onPressed: onLike,
            padding: const EdgeInsets.all(8),
            iconSize: 8.r,
            iconColor: Colors.white,
          ),
        )
      ],
      onTap: null,
      titleStyle: Get.appTextTheme.contentTileTitleSmall.copyWith(
        height: 1.33,
        letterSpacing: 0,
      ),
      activeTileColor: Colors.white.withOpacity(0.08),
      inactiveTileColor: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: Colors.white.withOpacity(0.08),
      ),
    );
  }

  /// * Factory for affirmation tile
  /// * Shows affirmation text with more options and selection state
  factory AppListTile.hiddenAffirmation({
    Key? key,
    required String affirmationText,
    VoidCallback? onHide,
  }) {
    return AppListTile._(
      key: key,
      title: affirmationText,
      maxTitleLines: 2,
      contentPadding: const EdgeInsets.all(16).r,
      trailing: [
        Transform.scale(
          scale: 2,
          child: TransparentSvgCircleButton(
            IconAllConstants.eyeOff,
            onPressed: onHide,
            padding: const EdgeInsets.all(8),
            iconSize: 8.r,
            iconColor: Colors.white.withOpacity(0.4),
          ),
        )
      ],
      onTap: null,
      titleStyle: Get.appTextTheme.contentTileTitleSmall.copyWith(
        height: 1.33,
        letterSpacing: 0,
      ),
      activeTileColor: Colors.white.withOpacity(0.08),
      inactiveTileColor: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: Colors.white.withOpacity(0.08),
      ),
    );
  }

  /// * Factory for setting tile
  /// * Shows affirmation text with more options and selection state
  factory AppListTile.setting({
    Key? key,
    required String text,
    required String leadingIcon,
    bool hasRightArrow = true,
    required VoidCallback onTap,
    Color? textColor,
    Color? trailingColor,
    Color? leadingColor,
  }) {
    return AppListTile._(
      key: key,
      title: text,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 16.r),
      trailing: hasRightArrow
          ? [
              SvgPicture.asset(
                IconAllConstants.chevronRight,
                color: trailingColor ?? Colors.white.withOpacity(0.7),
                width: 20.r,
                height: 20.r,
              ),
            ]
          : [],
      leading: SvgPicture.asset(
        leadingIcon,
        color: leadingColor ?? Colors.white.withOpacity(0.3),
        width: 21.r,
        height: 21.r,
      ),
      pastLeadingSpacing: 15,
      onTap: onTap,
      titleStyle: Get.appTextTheme.contentTileTitleMedium.copyWith(
        letterSpacing: 0,
        color: textColor,
      ),
      activeTileColor: Colors.transparent,
      inactiveTileColor: Colors.transparent,
      borderRadius: BorderRadius.circular(0.r),
    );
  }

  /// * Factory for storage management page's tile
  /// * Shows delete button at trailing, a title and a subtitle at leading.
  factory AppListTile.storageManagement({
    Key? key,
    required String title,
    required String subtitle,
    required VoidCallback onDelete,
  }) {
    return AppListTile._(
      key: key,
      title: title,
      subtitle: subtitle,
      contentPadding: const EdgeInsets.symmetric(vertical: 12).r,
      trailing: [
        SizedBox(
          width: 65.w,
          child: SecondaryPageButton.text(
            text: "Delete",
            onPressed: onDelete,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            textStyle: Get.appTextTheme.buttonSmallText.copyWith(
              height: 1.43,
              color: AppColors.danger,
            ),
          ),
        )
      ],
      pastLeadingSpacing: 15,
      onTap: onDelete,
      titleSubtitleSpacing: 4,
      titleStyle: Get.appTextTheme.contentTileTitleMedium.copyWith(
        letterSpacing: 0,
        height: 1.38,
      ),
      subtitleStyle: Get.appTextTheme.contentTileSubtitleLarge.copyWith(
        color: const Color(0x4CEBEBF5),
        fontSize: 14,
        letterSpacing: 0,
        height: 1.29,
      ),
      activeTileColor: Colors.transparent,
      inactiveTileColor: Colors.transparent,
      borderRadius: BorderRadius.circular(0.r),
    );
  }

  /// * Factory for dropdown tile
  /// * Shows affirmation text with more options and selection state
  factory AppListTile.dropdown({
    Key? key,
    required String text,
    required String leadingIcon,
    bool hasRightArrow = true,
    required VoidCallback onTap,
    Color? textColor,
    Color? trailingColor,
    Color? leadingColor,
    required List<Color> gradientColors,
    Alignment gradientBegin = Alignment.centerLeft,
    Alignment gradientEnd = Alignment.centerRight,
  }) {
    return AppListTile._(
      key: key,
      title: text,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 18.r),
      trailing: hasRightArrow
          ? [
              Transform.rotate(
                angle: 1.5,
                child: SvgPicture.asset(
                  IconAllConstants.chevronRight,
                  color: trailingColor ?? Colors.white.withOpacity(0.7),
                  width: 20.r,
                  height: 20.r,
                ),
              ),
            ]
          : [],
      leading: GradientIcon(
        gradientColors: gradientColors,
        begin: gradientBegin,
        end: gradientEnd,
        icon: leadingIcon,
      ),
      pastLeadingSpacing: 15,
      onTap: onTap,
      titleStyle: Get.appTextTheme.bodyMedium.copyWith(
        height: 1.5,
      ),
      activeTileColor: Colors.transparent,
      inactiveTileColor: Colors.transparent,
      borderRadius: BorderRadius.circular(0.r),
    );
  }

  /// * Factory for profile tile
  /// * Shows a title and a trailing text with a chevron at the right.
  factory AppListTile.profile({
    Key? key,
    required String title,
    required String trailingText,
    bool hasRightArrow = true,
    required VoidCallback onTap,
  }) {
    return AppListTile._(
      key: key,
      title: title,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.r),
      trailing: hasRightArrow
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    trailingText,
                    style: Get.appTextTheme.titleExtraSmall.copyWith(
                      color: Colors.white.withAlpha(128),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  12.width,
                  SvgPicture.asset(
                    IconAllConstants.chevronRight,
                    color: Colors.white.withOpacity(0.3),
                    width: 15.r,
                    height: 15.r,
                  ),
                ],
              ),
            ]
          : [],
      pastLeadingSpacing: 15,
      onTap: onTap,
      titleStyle: Get.appTextTheme.contentTileTitleMedium.copyWith(
        letterSpacing: 0,
      ),
      activeTileColor: Colors.transparent,
      inactiveTileColor: Colors.transparent,
      borderRadius: BorderRadius.circular(0.r),
    );
  }

  /// * Factory for affirmation tile
  /// * Shows affirmation text with more options and selection state
  factory AppListTile.alertText({
    Key? key,
    required String title,
    required VoidCallback onTap,
  }) {
    return AppListTile._(
      key: key,
      title: title,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.r),
      onTap: onTap,
      titleStyle: Get.appTextTheme.titleExtraSmall.copyWith(
        color: AppColors.danger,
        letterSpacing: 0,
      ),
      activeTileColor: Colors.transparent,
      inactiveTileColor: Colors.transparent,
      borderRadius: BorderRadius.circular(0.r),
      textAlign: TextAlign.center,
    );
  }

  /// * Factory for image tile
  /// * Shows an image with a title and a subtitle
  factory AppListTile.pickedImage({
    Key? key,
    required File file,
    required VoidCallback onRemove,
  }) {
    final fileName = file.path.split('/').last;

    return AppListTile._(
      key: key,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: Image.file(
          file,
          width: 50.r,
          height: 50.r,
          fit: BoxFit.cover,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      trailing: [
        TagXButton(
          onTap: onRemove,
        ),
      ],
      title: fileName,
      titleStyle: Get.appTextTheme.contentTileTitleSmall.copyWith(height: 1.33),
      onTap: null,
    );
  }

  /// * Factory for header with see all button
  /// * Shows title, optional subtitle, and see all button
  factory AppListTile.headerWithSeeAll({
    Key? key,
    required String title,
    String? subtitle,
    String? leadingIcon,
    VoidCallback? onSeeAll,
    Color? textColor,
    Color? subtitleColor,
    Color? seeAllColor,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppListTile._(
      key: key,
      title: title,
      subtitle: subtitle,
      contentPadding: contentPadding ?? EdgeInsets.zero,
      customBody: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (leadingIcon != null) ...[
                SvgPicture.asset(
                  leadingIcon,
                  height: 20.r,
                  width: 20.r,
                ),
                4.width,
              ],
              Text(
                title,
                style: Get.appTextTheme.titleLargeRounded.copyWith(
                  letterSpacing: -0.32,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  "See All",
                  style: Get.appTextTheme.buttonSmallText.copyWith(
                    color: seeAllColor ?? Colors.white.withAlpha(128),
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null && subtitle.isNotEmpty) ...[
            8.height,
            Text(
              subtitle,
              style: Get.appTextTheme.buttonSmallText.copyWith(
                color: subtitleColor ?? Colors.white.withAlpha(128),
                letterSpacing: -0.32,
              ),
            ),
          ],
        ],
      ),
      onTap: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    const progressMarker = '_progress_';
    final bool showProgressBar = (subtitle ?? '').contains(progressMarker);
    final double progressValue = showProgressBar
        ? (double.tryParse(trailing!.first
                    .toString()
                    .replaceAll(RegExp(r'[^0-9.]'), '')) ??
                0) /
            100
        : 0.0;

    return onTap != null
        ? Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: _buildBody(showProgressBar, progressValue),
            ),
          )
        : _buildBody(showProgressBar, progressValue);
  }

  Widget _buildBody(bool showProgressBar, double progressValue) {
    return Container(
      padding: contentPadding ??
          EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      decoration: BoxDecoration(
        color: isSelected
            ? (activeTileColor ?? Colors.white.withOpacity(0.1))
            : (inactiveTileColor ?? Colors.transparent),
        borderRadius: borderRadius ?? BorderRadius.circular(12.r),
        border: border,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            (pastLeadingSpacing ?? 16).toInt().width,
          ],
          Expanded(
            child:

                /// * if bodyBuilder is not empty then display bodyBuilder, else display title, & subtitle
                customBody ??
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          style: titleStyle ??
                              Get.appTextTheme.contentTileTitleMedium.copyWith(
                                fontSize: titleFontSize ?? 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                height: titleLineHeight ?? 2.1,
                                letterSpacing: titleLetterSpacing ?? 0,
                              ),
                          maxLines: maxTitleLines ?? 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: textAlign,
                        ),
                        if (subtitle != null && !showProgressBar) ...[
                          (titleSubtitleSpacing ?? 4).toInt().height,
                          Text(
                            subtitle!,
                            style: subtitleStyle ??
                                Get.appTextTheme.contentTileSubtitleMedium
                                    .copyWith(
                                  fontSize: subtitleFontSize ?? 12,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                  height: subtitleLineHeight ?? 1.6,
                                  letterSpacing: subtitleLetterSpacing ?? 0,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
          ),
          16.width,
          if (trailing != null && customBody == null) ...trailing!,
          if (showForwardArrow && customBody == null)
            SvgPicture.asset(
              IconAllConstants.chevronRight,
              color: Colors.white.withOpacity(0.6),
              width: 24.r,
              height: 24.r,
            ),
        ],
      ),
    );
  }
}
