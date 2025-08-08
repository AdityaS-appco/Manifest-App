import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/shared/widgets/buttons/icon_button_with_badge.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils/extensions/responsive_sized_box.extension.dart';
import 'package:manifest/features/playlist/by_you/widgets/media_player_components/media_player_button.dart';

/// * A grid layout widget for media player actions
class PlayerActionsGrid extends StatelessWidget {
  /// * Padding around the entire grid
  final EdgeInsetsGeometry? padding;

  /// * Size of the action icons
  final double? actionIconSize;

  /// * Size of the media player button
  final double? playerIconSize;

  /// * Color of the action icons
  final Color? actionIconColor;

  /// * First action icon and callback
  final String? action1Icon;
  final VoidCallback? onAction1Tap;
  final String? action1BadgeValue;

  /// * Second action icon and callback
  final String? action2Icon;
  final VoidCallback? onAction2Tap;
  final String? action2BadgeValue;

  /// * Third action icon and callback
  final String? action3Icon;
  final VoidCallback? onAction3Tap;
  final String? action3BadgeValue;

  /// * Fourth action icon and callback
  final String? action4Icon;
  final VoidCallback? onAction4Tap;
  final String? action4BadgeValue;

  /// * Media player button properties
  final RxBool isPlaying;
  final Future<void> Function() onPlay;
  final Future<void> Function()? onPause;
  final Future<void> Function()? onStop;
  final bool isPlayPause;
  final bool showProgress;
  final RxDouble? progress;
  final Color? activeProgressTrackColor;
  final Color? inactiveProgressTrackColor;
  final double? progressTrackWidth;

  const PlayerActionsGrid({
    super.key,
    this.padding,
    this.actionIconSize,
    this.playerIconSize,
    this.actionIconColor,
    this.action1Icon,
    this.onAction1Tap,
    this.action1BadgeValue,
    this.action2Icon,
    this.onAction2Tap,
    this.action2BadgeValue,
    this.action3Icon,
    this.onAction3Tap,
    this.action3BadgeValue,
    this.action4Icon,
    this.onAction4Tap,
    this.action4BadgeValue,
    required this.isPlaying,
    required this.onPlay,
    this.onPause,
    this.onStop,
    this.isPlayPause = true,
    this.showProgress = true,
    this.progress,
    this.activeProgressTrackColor,
    this.inactiveProgressTrackColor,
    this.progressTrackWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PlayerAction(
            icon: action1Icon ?? IconAllConstants.clockStopwatch,
            onTap: onAction1Tap ?? () {},
            actionIconSize: actionIconSize,
            actionIconColor: actionIconColor,
            badgeValue: action1BadgeValue,
          ),
          PlayerAction(
            icon: action2Icon ?? IconAllConstants.refreshCcw02,
            onTap: onAction2Tap ?? () {},
            actionIconSize: actionIconSize,
            actionIconColor: actionIconColor,
            badgeValue: action2BadgeValue,
          ),
          10.width,
          Obx(
            () => MediaPlayerButton(
              isPlaying: isPlaying,
              onPlay: onPlay,
              onPause: onPause,
              onStop: onStop,
              isPlayPause: isPlayPause,
              showProgress: showProgress,
              progress: progress?.value ?? 0,
              buttonSize: playerIconSize ?? 64,
              iconSize: (playerIconSize ?? 68) - 30,
              iconColor: Colors.black,
              activeProgressTrackColor:
                  activeProgressTrackColor ?? AppColors.light,
              inactiveProgressTrackColor:
                  inactiveProgressTrackColor ?? Colors.white24,
              progressTrackWidth: progressTrackWidth ?? 3,
            ),
          ),
          10.width,
          PlayerAction(
            icon: action3Icon ?? IconAllConstants.share01,
            onTap: onAction3Tap ?? () {},
            actionIconSize: actionIconSize,
            actionIconColor: actionIconColor,
            badgeValue: action3BadgeValue,
          ),
          PlayerAction(
            icon: action4Icon ?? IconAllConstants.sliders02,
            onTap: onAction4Tap ?? () {},
            actionIconSize: actionIconSize,
            actionIconColor: actionIconColor,
            badgeValue: action4BadgeValue,
          ),
        ],
      ),
    );
  }
}

/// * A reusable widget for player actions with flexible badge support
class PlayerAction extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final double? actionIconSize;
  final String? badgeValue;
  final Color? actionIconColor;

  const PlayerAction({
    Key? key,
    required this.icon,
    required this.onTap,
    this.actionIconSize,
    this.badgeValue,
    this.actionIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75.w,
      height: 64.h,
      child: Center(
        child: IconButtonWithBadge(
          svgPath: icon,
          onTap: onTap,
          isEnabled: true,
          iconSize: (actionIconSize ?? 24),
          enabledColor: Colors.transparent,
          disabledColor: Colors.transparent,
          buttonSize: 75,
          badgeValue: badgeValue,
          badgeTop: 15.r,
          badgeRight: 18.r,
          iconColor: actionIconColor ?? Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}
