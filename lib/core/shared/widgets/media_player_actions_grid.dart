import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/features/playlist/by_you/widgets/media_player_components/media_player_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';

/// * A grid layout widget for media player actions
class PlayerActionsGrid extends StatelessWidget {
  /// * Padding around the entire grid
  final EdgeInsetsGeometry? padding;

  /// * Size of the action icons
  final double? actionIconSize;

  /// * Size of the media player button
  final double? playerIconSize;

  /// * First action icon and callback
  final String? action1Icon;
  final VoidCallback? onAction1Tap;

  /// * Second action icon and callback
  final String? action2Icon;
  final VoidCallback? onAction2Tap;

  /// * Third action icon and callback
  final String? action3Icon;
  final VoidCallback? onAction3Tap;

  /// * Fourth action icon and callback
  final String? action4Icon;
  final VoidCallback? onAction4Tap;

  /// * Media player button properties
  final RxBool isPlaying;
  final Future<void> Function() onPlay;
  final Future<void> Function()? onPause;
  final Future<void> Function()? onStop;
  final bool isPlayPause;
  final bool showProgress;
  final double? progress;
  final Color? progressColor;
  final Color? progressBackgroundColor;
  final double? progressStrokeWidth;

  const PlayerActionsGrid({
    super.key,
    this.padding,
    this.actionIconSize,
    this.playerIconSize,
    this.action1Icon,
    this.onAction1Tap,
    this.action2Icon,
    this.onAction2Tap,
    this.action3Icon,
    this.onAction3Tap,
    this.action4Icon,
    this.onAction4Tap,
    required this.isPlaying,
    required this.onPlay,
    this.onPause,
    this.onStop,
    this.isPlayPause = true,
    this.showProgress = true,
    this.progress,
    this.progressColor,
    this.progressBackgroundColor,
    this.progressStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PlayerAction(
            icon: action1Icon ?? IconAllConstants.clockStopwatch,
            onTap: onAction1Tap ?? () {},
            actionIconSize: actionIconSize,
          ),
          PlayerAction(
            icon: action2Icon ?? IconAllConstants.arrowReloadHorizontal2,
            onTap: onAction2Tap ?? () {},
            actionIconSize: actionIconSize,
          ),
          MediaPlayerButton(
            isPlaying: isPlaying,
            onPlay: onPlay,
            onPause: onPause,
            onStop: onStop,
            isPlayPause: isPlayPause,
            showProgress: showProgress,
            progress: progress,
            buttonSize: playerIconSize ?? 60.w,
            iconSize: (playerIconSize ?? 60.w) - 20,
            iconColor: Colors.black,
            activeProgressTrackColor: progressColor ?? AppColors.light,
            inactiveProgressTrackColor: progressBackgroundColor ?? Colors.white24,
            progressTrackWidth: progressStrokeWidth ?? 3,
          ),
          PlayerAction(
            icon: action3Icon ?? IconAllConstants.heartsSymbol,
            onTap: onAction3Tap ?? () {},
            actionIconSize: actionIconSize,
          ),
          PlayerAction(
            icon: action4Icon ?? IconAllConstants.settings04,
            onTap: onAction4Tap ?? () {},
            actionIconSize: actionIconSize,
          ),
        ],
      ),
    );
  }
}

/// * A reusable widget for player actions
class PlayerAction extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final double? actionIconSize;

  const PlayerAction({
    Key? key,
    required this.icon,
    required this.onTap,
    this.actionIconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      height: 64.h,
      padding: EdgeInsets.all(8.w),
      child: Center(
        child: SvgCircleButton(
          icon,
          iconSize: actionIconSize ?? 30,
          iconColor: AppColors.light,
          enabledColor: Colors.transparent,
          disabledColor: Colors.transparent,
          padding: EdgeInsets.zero,
          onPressed: onTap,
        ),
      ),
    );
  }
}
