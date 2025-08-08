import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/features/playlist/by_you/widgets/media_player_components/media_player_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/voice_recorder/voice_recorder_bottom_sheet_controller.dart';
import 'package:manifest/helper/import.dart';

class VoiceRecorderBottomSheet
    extends GetView<VoiceRecorderBottomSheetController> {
  int? byYouId;
  int? recordingIndex;
  bool isCreatingByYou;
  bool isAudioPlayer;
  Function(File file, String duration)? onRecordingStopped;
  VoidCallback? onBottomSheetClosed;

  VoiceRecorderBottomSheet({
    this.byYouId,
    this.recordingIndex,
    this.isCreatingByYou = false,
    this.onRecordingStopped,
    this.onBottomSheetClosed,
    this.isAudioPlayer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBottomSheet(
        hasBackButton: false,
        body: Column(
          children: [
            _buildMainContent(),
            33.height,
            _buildFooter(),
            Gap(64.h),
            if (controller.errorMessage.isNotEmpty) _buildErrorMessage(),
          ],
        ),
      );
    });
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(),
        15.height,
        _buildDescription(),
        Gap(30.h),
        _buildWaveForm(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      controller.isRecording.value ? 'Recording...' : 'My Recording',
      style: Get.appTextTheme.bottomsheetTitle
          .copyWith(color: Colors.white, fontSize: 22),
    );
  }

  Widget _buildDescription() {
    return Obx(
      () => Text(
        controller.formattedDuration,
        style: Get.appTextTheme.subtitleMedium.copyWith(
          color: Colors.white.withAlpha(178),
          height: 1,
        ),
      ),
    );
  }

  Widget _buildWaveForm() {
    return SizedBox(
      height: 108.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: AudioWaveforms(
          size: Size(kSize.width, 108.h),
          recorderController: controller.recorderController,
          waveStyle: WaveStyle(
            waveColor: AppColors.recorderRed,
            showMiddleLine: false,
            extendWaveform: true,
            showBottom: true,
            scaleFactor: 120,
          ),
          shouldCalculateScrolledPosition: true,
          // padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        MediaPlayerButton(
          iconSize: 40,
          buttonSize: 64,
          isPlaying: controller.isRecording,
          onPlay: () async {
            await controller.startRecording();
          },
          onStop: () async {
            await controller.stopRecording();
            onRecordingStopped?.call(
              File(controller.recordingPath.value),
              controller.formattedDuration,
            );
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        controller.errorMessage.value,
        style: TextStyle(
          color: Colors.red,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
