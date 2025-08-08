import 'dart:io';

import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/services/storage_management_service.dart';
import 'package:manifest/helper/import.dart';

class StorageManagementController extends BaseController {
  final _storageService = Get.find<StorageManagementService>();

  // Observable storage sizes for each directory
  final soundscapesSize = '0.00 MB'.obs;
  final affirmationsSize = '0.00 MB'.obs;
  final tracksSize = '0.00 MB'.obs;
  final playlistsSize = '0.00 MB'.obs;
  final mp3sSize = '0.00 MB'.obs;
  final voiceRecordsSize = '0.00 MB'.obs;

  // Loading states
  final isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    calculateStorageSizes();
  }

  /// Calculate storage sizes for all directories
  Future<void> calculateStorageSizes() async {
    startLoading();
    try {
      soundscapesSize.value = await _getDirectorySize(StorageDirectory.soundscapes);
      affirmationsSize.value = await _getDirectorySize(StorageDirectory.affirmations);
      tracksSize.value = await _getDirectorySize(StorageDirectory.tracks);
      playlistsSize.value = await _getDirectorySize(StorageDirectory.playlists);
      mp3sSize.value = await _getDirectorySize(StorageDirectory.mp3s);
      voiceRecordsSize.value = await _getDirectorySize(StorageDirectory.voiceRecords);
    } catch (e) {
      LogUtil.log('Error calculating storage sizes: $e');
    } finally {
      stopLoading();
    }
  }

  /// Get formatted size string for a directory
  Future<String> _getDirectorySize(StorageDirectory directory) async {
    try {
      final files = await _storageService.getDirectoryContents(directory);
      int totalSize = 0;

      for (final file in files) {
        if (file is File) {
          final size = await _storageService.getFileSize(file.path) ?? 0;
          totalSize += size;
        }
      }

      // Convert bytes to MB with 2 decimal places
      final sizeInMB = (totalSize / (1024 * 1024)).toStringAsFixed(2);
      return '$sizeInMB MB';
    } catch (e) {
      LogUtil.log('Error getting directory size: $e');
      return '0.00 MB';
    }
  }
  Future<void> handleDelete(StorageDirectory directory) async {
    String directoryName = directory.name;
    String title = "Delete ${directoryName.capitalize}";
    String subtitle = "Downloaded ${directoryName.toLowerCase()} will be deleted";

    await _handleDelete(directory, title, subtitle);
  }

  Future<void> _handleDelete(StorageDirectory directory, String title, String subtitle) async {
    await AppDialogs.showIOSDialog(
      title: title,
      subtitle: subtitle,
      onContinuePressed: () async {
        final success = await clearDirectory(directory);
        if (success) {
          ToastUtil.success('$title cleared successfully');
        } else {
          ToastUtil.error('Failed to clear $title');
        }
      },
      continueText: "Ok",
    );
  }

  /// Clear a specific directory
  Future<bool> clearDirectory(StorageDirectory directory) async {
    isDeleting.value = true;
    try {
      final success = await _storageService.clearDirectory(directory);
      if (success) {
        // Update the size after clearing
        switch (directory) {
          case StorageDirectory.soundscapes:
            soundscapesSize.value = '0.00 MB';
            break;
          case StorageDirectory.affirmations:
            affirmationsSize.value = '0.00 MB';
            break;
          case StorageDirectory.tracks:
            tracksSize.value = '0.00 MB';
            break;
          case StorageDirectory.playlists:
            playlistsSize.value = '0.00 MB';
            break;
          case StorageDirectory.mp3s:
            mp3sSize.value = '0.00 MB';
            break;
          case StorageDirectory.voiceRecords:
            voiceRecordsSize.value = '0.00 MB';
            break;
        }
      }
      return success;
    } catch (e) {
      LogUtil.log('Error clearing directory: $e');
      return false;
    } finally {
      isDeleting.value = false;
    }
  }

  /// Get storage size for a specific directory type
  String getStorageSize(StorageDirectory directory) {
    switch (directory) {
      case StorageDirectory.soundscapes:
        return soundscapesSize.value;
      case StorageDirectory.affirmations:
        return affirmationsSize.value;
      case StorageDirectory.tracks:
        return tracksSize.value;
      case StorageDirectory.playlists:
        return playlistsSize.value;
      case StorageDirectory.mp3s:
        return mp3sSize.value;
      case StorageDirectory.voiceRecords:
        return voiceRecordsSize.value;
    }
  }
}
