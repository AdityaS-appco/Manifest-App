import 'package:manifest/core/shared/widgets/bottomsheets/add_track_to_my_playlist_sheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/shared/widgets/sliders/gradient_tick_slider.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/buttons/icon_button_with_badge.dart';
import 'package:manifest/core/shared/widgets/custom_switch.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/list_tiles/player_control_tile.dart';
import 'package:manifest/core/shared/widgets/sliders/volume_slider.dart';
import 'package:manifest/features/media_player/models/voice_option.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/explore_tab_model/featured_tab_model/featured_tab_model.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/downloaded_soundscape.dart';

class PlayerControlActionsValues {
  String? action1BadgeValue;
  String? action2BadgeValue;
  String? action3BadgeValue;
  String? action4BadgeValue;
  VoidCallback onAction1Tap;
  VoidCallback onAction2Tap;
  VoidCallback onAction3Tap;
  VoidCallback onAction4Tap;
  bool isFavorite;

  PlayerControlActionsValues({
    this.action1BadgeValue,
    this.action2BadgeValue,
    this.action3BadgeValue,
    this.action4BadgeValue,
    required this.onAction1Tap,
    required this.onAction2Tap,
    required this.onAction3Tap,
    required this.onAction4Tap,
    this.isFavorite = false,
  });
}

class PlayerControlBottomsheet extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final bool headerHasActionButtons;
  final PlayerControlActionsValues actionValues;

  const PlayerControlBottomsheet._({
    this.title,
    required this.children,
    required this.actionValues,
    this.headerHasActionButtons = false,
  });

  /// * Factory constructor for playlist controls
  factory PlayerControlBottomsheet.playlist({
    required PlayerControlActionsValues actionValues,
  }) {
    RxBool isMindMoviesEnabled = false.obs;
    RxBool isBoosterEnabled = false.obs;
    RxBool isNatureSoundEnabled = false.obs;
    RxBool isVoiceEnabled = false.obs;
    RxDouble currentSoundscapeVolume = 0.0.obs;
    RxDouble currentVoiceVolume = 0.0.obs;
    return PlayerControlBottomsheet._(
      title: "Playlist Controls",
      actionValues: actionValues,
      children: [
        Text(
          'Customize media control for all the tracks inside the playlist (it will ignore the individual track’s media preset)',
          style: helveticaPageTitleTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.light.withOpacity(0.5),
            height: 1.57,
            letterSpacing: -0.4,
          ),
        ),
        24.height,
        DividerSection(
          dividerPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          children: [
            PlayerControlTile.withIcon(
              title: 'Switch to mind movies',
              iconPath: IconAllConstants.tv03,
              infoOptions: InfoOptions(
                hasInfo: true,
                onInfoPressed: () {
                  LogUtil.log("mind movies info pressed");
                },
              ),
              switchOptions: AppSwitchOptions(
                switchValue: isMindMoviesEnabled.value,
                switchState: AppSwitchState.enabled,
                onSwitchToggle: (value) {
                  isMindMoviesEnabled.value = value;
                },
              ),
              trailingType: PlayerControlTileTrailingType.switchType,
            ),
            PlayerControlTile.withIcon(
              title: 'Booster',
              iconPath: IconAllConstants.localFireDepartment,
              infoOptions: InfoOptions(
                hasInfo: true,
                onInfoPressed: () {
                  LogUtil.log("booster info pressed");
                  AppDialogs.showBoosterDialog();
                },
              ),
              switchOptions: AppSwitchOptions(
                switchValue: isBoosterEnabled.value,
                switchState: AppSwitchState.locked,
                onSwitchToggle: (value) {
                  isBoosterEnabled.value = value;
                },
              ),
              trailingType: PlayerControlTileTrailingType.switchType,
            ),
          ],
        ),
        24.height,
        DividerSection.containered(
          dividerPadding: EdgeInsets.zero,
          children: [
            Obx(
              () => PlayerControlTile.withImage(
                title: 'Nature Sounds',
                subtitle: 'Background Music',
                imageUrl: 'https://dummyimage.com/150x150',
                switchOptions: AppSwitchOptions(
                  switchValue: isNatureSoundEnabled.value,
                  switchState: AppSwitchState.enabled,
                  onSwitchToggle: (value) {
                    isNatureSoundEnabled.value = value;
                  },
                ),
                trailingType: PlayerControlTileTrailingType.switchType,
              ),
            ),
          ],
        ),
        16.height,
        DividerSection.containered(
          dividerPadding: EdgeInsets.zero,
          children: [
            PlayerControlTile.withImage(
              title: 'Voice',
              subtitle: 'Male',
              imageUrl: 'https://dummyimage.com/150x150',
              switchOptions: AppSwitchOptions(
                switchValue: isVoiceEnabled.value,
                switchState: AppSwitchState.enabled,
                onSwitchToggle: (value) {
                  isVoiceEnabled.value = value;
                },
              ),
              trailingType: PlayerControlTileTrailingType.switchType,
            ),
          ],
        ),
        16.height,
        DividerSection.containered(
          dividerPadding: EdgeInsets.zero,
          children: [
            Obx(() => VolumeSlider(
                  title: 'Voice volume',
                  value: currentVoiceVolume.value,
                  onChanged: (value) {
                    currentVoiceVolume.value = value;
                  },
                  isStepper: true,
                  maxValue: 3 - 1,
                )),
            Obx(() => VolumeSlider(
                  title: 'Soundscape volume',
                  value: currentSoundscapeVolume.value,
                  onChanged: (value) {
                    currentSoundscapeVolume.value = value;
                  },
                )),
          ],
        ),
      ],
    );
  }

  /// * Factory constructor for track controls
  factory PlayerControlBottomsheet.track({
    required PlaylistOrTrack track,
    required PlayerControlActionsValues actionValues,
    required Function(double) onVoiceVolumeChanged,
    required Function(double) onAffirmationDelayChanged,
    required Function(double) onSoundscapeVolumeChanged,
    required Function(bool) onBoosterToggle,
    required Function(bool) onMindMoviesToggle,
    required Function(bool) onBackgroundMusicToggle,
    required Function() onVoiceSwitchTileTap,
    required RxDouble currentAffirmationDelay,
    required RxDouble currentSoundscapeVolume,
    required RxDouble currentVoiceVolume,
    required RxBool isBoosterEnabled,
    required RxBool isMindMoviesEnabled,
    required RxBool isBackgroundMusicEnabled,
    required RxBool isVoiceEnabled,
    required VoiceOption? currentVoice,
    required DownloadedSoundscape? currentSoundscape,
  }) {
    return PlayerControlBottomsheet._(
      headerHasActionButtons: true,
      actionValues: actionValues,
      children: [
        DividerSection(
          padding: EdgeInsets.zero,
          dividerPadding: EdgeInsets.zero,
          children: [
            PlayerControlTile.withIcon(
              title: 'Add to playlist',
              iconPath: IconAllConstants.layersThree02Outlined,
              trailingType: PlayerControlTileTrailingType.forwardIcon,
              onTileTap: () {
                LogUtil.log("add to playlist pressed");
                AppBottomSheet.show(
                  AddTrackToMyPlaylistSheet(
                    trackId: track.id,
                  ),
                );
              },
            ),
            PlayerControlTile.withIcon(
              title: 'Switch to mind movies',
              iconPath: IconAllConstants.tv03,
              infoOptions: InfoOptions(
                hasInfo: true,
                onInfoPressed: () {
                  LogUtil.log("mind movies info pressed");
                },
              ),
              switchOptions: AppSwitchOptions(
                switchValue: isMindMoviesEnabled.value,
                onSwitchToggle: onMindMoviesToggle,
              ),
              trailingType: PlayerControlTileTrailingType.switchType,
            ),
            PlayerControlTile.withIcon(
              title: 'Booster',
              iconPath: IconAllConstants.localFireDepartment,
              infoOptions: InfoOptions(
                hasInfo: true,
                onInfoPressed: () {
                  LogUtil.log("booster info pressed");
                  AppDialogs.showBoosterDialog();
                },
              ),
              switchOptions: AppSwitchOptions(
                switchValue: isBoosterEnabled.value,
                switchState: AppSwitchState.enabled,
                onSwitchToggle: onBoosterToggle,
              ),
              trailingType: PlayerControlTileTrailingType.switchType,
            ),
          ],
        ),
        24.height,
        DividerSection.containered(
          padding: EdgeInsets.zero,
          children: [
            PlayerControlTile.withImage(
              title: 'Soundscape',
              subtitle: currentSoundscape?.name ?? 'Select Soundscape',
              imageUrl: currentSoundscape?.artCover ??
                  'https://dummyimage.com/150x150',
              trailingType: PlayerControlTileTrailingType.switchType,
              switchOptions: AppSwitchOptions(
                switchValue: isBackgroundMusicEnabled.value,
                switchState: AppSwitchState.enabled,
                onSwitchToggle: (value) {
                  onBackgroundMusicToggle(value);
                },
              ),
              padding: const EdgeInsets.all(16).r,
            ),
          ],
        ),
        16.height,
        DividerSection.containered(
          padding: EdgeInsets.zero,
          children: [
            PlayerControlTile.withImage(
              title: 'Voice',
              subtitle: currentVoice?.name ?? 'Select Voice',
              imageUrl:
                  currentVoice?.imageUrl ?? 'https://dummyimage.com/150x150',
              trailingType: PlayerControlTileTrailingType.forwardIcon,
              onTileTap: onVoiceSwitchTileTap,
              padding: const EdgeInsets.all(16).r,
            ),
          ],
        ),
        16.height,
        DividerSection.containered(
          children: [
            Obx(
              () => VolumeSlider(
                title: 'Voice volume',
                value: currentVoiceVolume.value,
                onChanged: onVoiceVolumeChanged,
                isStepper: true,
                maxValue: 3 - 1,
              ),
            ),
            Obx(
              () => VolumeSlider(
                title: 'Soundscape volume',
                value: currentSoundscapeVolume.value,
                onChanged: (value) {
                  currentSoundscapeVolume.value = value;
                },
              ),
            ),
          ],
        ),
        16.height,
        DividerSection.containered(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Affirmation Delay",
                  style: bodyTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                16.height,
                Obx(
                  () => GradientTickSlider(
                    value: currentAffirmationDelay.value,
                    min: 0.0,
                    max: 30.0,
                    interval: 5.0,
                    onChanged: (value) {
                      currentAffirmationDelay.value = value;
                    },
                  ),
                ),
                4.height,
                Row(
                  children: <Widget>[
                    10.width,
                    Text(
                      "0s",
                      style: helveticaPageTitleTextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.light.withOpacity(0.5),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "30s",
                      style: helveticaPageTitleTextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.light.withOpacity(0.5),
                      ),
                    ),
                    10.width,
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: title,
      titlePadding: EdgeInsets.only(right: 20.r, left: 20.r, top: 35.r),
      hasBackButton: false,
      backgroundColor: const Color(0xFF252525).withOpacity(0.7),
      blurAmount: 64,
      horizontalPadding: 0,
      buttonsHorizontalPadding: 20.r,
      topPadding: 0.r,
      contentPadding: EdgeInsets.all(20.r),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action buttons if provided
          if (headerHasActionButtons) ...[
            10.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                    IconAllConstants.clockStopwatch,
                    actionValues.action1BadgeValue,
                    onTap: actionValues.onAction1Tap,
                  ),
                  _buildActionButton(
                    actionValues.isFavorite
                        ? IconAllConstants.heartRounded
                        : IconAllConstants.heartRoundedOutlined,
                    actionValues.action2BadgeValue,
                    onTap: actionValues.onAction2Tap,
                  ),
                  _buildActionButton(
                    IconAllConstants.refreshCcw02,
                    actionValues.action3BadgeValue,
                    onTap: actionValues.onAction3Tap,
                  ),
                  _buildActionButton(
                    IconAllConstants.share01,
                    actionValues.action4BadgeValue,
                    onTap: actionValues.onAction4Tap,
                  ),
                ],
              ),
            ),
            30.height,
          ],

          // Main content with dividers
          ...children,
        ],
      ),
    );
  }

  IconButtonWithBadge _buildActionButton(
    String svgPath,
    String? badgeValue, {
    required VoidCallback onTap,
  }) {
    return IconButtonWithBadge(
      svgPath: svgPath,
      badgeValue: badgeValue,
      iconSize: 24,
      padding: const EdgeInsets.all(15.5),
      badgeTop: -5,
      badgeRight: -5,
      onTap: onTap,
    );
  }
}
