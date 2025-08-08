import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/services/download_service.dart';
import 'package:manifest/features/soundscape/controllers/download_soundscape_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';

/// * A bottomsheet for soundscape download with progress tracking
class DownloadSoundscapeSheet extends StatelessWidget {
  final Soundscape soundscape;
  final VoidCallback onDownload;

  const DownloadSoundscapeSheet({
    super.key,
    required this.soundscape,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final downloadController = Get.find<DownloadSoundscapeController>();

    return CustomBottomSheet(
      hasBackButton: false,
      backgroundColor: const Color(0xFF252525).withOpacity(0.7),
      blurAmount: 64,
      horizontalPadding: 0,
      topPadding: 0.r,
      contentPadding: EdgeInsets.symmetric(vertical: 42.r),
      titlePadding: EdgeInsets.zero,
      body: Obx(() {
        final soundscapeId = soundscape.id.toString();
        final isDownloaded = downloadController.isDownloaded(soundscapeId);
        final isInQueue = downloadController.isInDownloadQueue(soundscapeId);
        final downloadProgress =
            downloadController.getDownloadProgress(soundscapeId);
        final downloadStatus =
            downloadController.getDownloadStatus(soundscapeId);
        final downloadError = downloadController.getDownloadError(soundscapeId);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with artwork, title and subtitle
            AppListTile.playerSettingHeader(
              artworkUrl: soundscape.artCover?.imageName ?? "",
              title: soundscape.name ?? '',
              subtitle: soundscape.description ?? '',
              contentPadding: EdgeInsets.symmetric(horizontal: 30.r),
            ),

            18.height,

            // Download progress section (if downloading)
            if (isInQueue) ...[
              _buildDownloadProgress(
                  downloadProgress, downloadStatus, downloadError),
              16.height,
            ],

            // Options list with dynamic content based on download state
            if (isDownloaded) ...[
              AppListTile.playerSettingOption(
                title: "Play Soundscape",
                iconPath: IconAllConstants.play,
                onTap: () => Get.back(),
                iconColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
              ),
              AppListTile.playerSettingOption(
                title: "Remove from Downloads",
                iconPath: IconAllConstants.trash03,
                onTap: () async {
                  final downloadedSoundscape =
                      downloadController.downloadedSoundscapes.firstWhereOrNull(
                          (ds) => ds.id.toString() == soundscapeId);
                  if (downloadedSoundscape != null) {
                    await downloadController
                        .removeDownloadedSoundscape(downloadedSoundscape);
                    Get.back();
                  }
                },
                iconColor: AppColors.danger,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
              ),
            ] else if (isInQueue) ...[
              if (downloadStatus == DownloadStatus.failed) ...[
                AppListTile.playerSettingOption(
                  title: "Retry Download",
                  iconPath: IconAllConstants.refreshCcw02,
                  onTap: () async {
                    await downloadController.retryDownload(soundscapeId);
                  },
                  iconColor: Colors.orange,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
                ),
              ],
              AppListTile.playerSettingOption(
                title: "Cancel Download",
                iconPath: IconAllConstants.xClose,
                onTap: () async {
                  await downloadController.cancelDownload(soundscapeId);
                  Get.back();
                },
                iconColor: AppColors.danger,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
              ),
            ] else ...[
              AppListTile.playerSettingOption(
                title: downloadController.isDownloadQueueFull
                    ? "Download Queue Full"
                    : "Download Soundscape",
                iconPath: IconAllConstants.download02,
                onTap: downloadController.isDownloadQueueFull
                    ? () {}
                    : () {
                        onDownload();
                        Get.back();
                      },
                iconColor: downloadController.isDownloadQueueFull
                    ? Colors.grey
                    : Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
              ),
            ],
          ],
        );
      }),
    );
  }

  Widget _buildDownloadProgress(
      double progress, DownloadStatus? status, String? error) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStatusText(status),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    4.height,
                    Text(
                      _getProgressText(progress, status),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (status == DownloadStatus.downloading) ...[
                SizedBox(
                  width: 16.r,
                  height: 16.r,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 2,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ] else if (status == DownloadStatus.pending) ...[
                Icon(
                  Icons.schedule,
                  color: Colors.orange,
                  size: 16.r,
                ),
              ] else if (status == DownloadStatus.failed) ...[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 16.r,
                ),
              ],
            ],
          ),

          // Progress bar
          if (status == DownloadStatus.downloading) ...[
            12.height,
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 3.h,
            ),
          ],

          // Error message
          if (error != null && status == DownloadStatus.failed) ...[
            8.height,
            Text(
              error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 11.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  String _getStatusText(DownloadStatus? status) {
    switch (status) {
      case DownloadStatus.pending:
        return "Queued for Download";
      case DownloadStatus.downloading:
        return "Downloading...";
      case DownloadStatus.failed:
        return "Download Failed";
      case DownloadStatus.cancelled:
        return "Download Cancelled";
      default:
        return "Unknown Status";
    }
  }

  String _getProgressText(double progress, DownloadStatus? status) {
    switch (status) {
      case DownloadStatus.pending:
        final downloadController = Get.find<DownloadSoundscapeController>();
        final position = downloadController.pendingDownloadsCount;
        return position > 1 ? "$position in queue" : "Starting soon";
      case DownloadStatus.downloading:
        return "${(progress * 100).toInt()}% completed";
      case DownloadStatus.failed:
        return "Tap retry to try again";
      case DownloadStatus.cancelled:
        return "Download was cancelled";
      default:
        return "";
    }
  }
}
