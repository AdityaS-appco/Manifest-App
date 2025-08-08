import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/download_service.dart';
import 'package:manifest/features/soundscape/controllers/download_soundscape_controller.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/downloaded_soundscape.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';

class DownloadedSoundscapesController extends BaseController {
  final DownloadSoundscapeController _downloadController = Get.find();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Track currently playing soundscape
  final Rx<DownloadedSoundscape?> currentlyPlayingSoundscape =
      Rx<DownloadedSoundscape?>(null);

  // Track currently loading soundscape
  final Rx<DownloadedSoundscape?> currentlyLoadingSoundscape =
      Rx<DownloadedSoundscape?>(null);

  // Get current soundscape
  final Rx<DownloadedSoundscape?> currentSoundscape =
      Rx<DownloadedSoundscape?>(null);

  // Stream subscription for download updates
  StreamSubscription<DownloadItem>? _downloadStatusSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  @override
  void onInit() {
    super.onInit();
    _initializeDownloadListener();
    _initializePlayerStateListener();
  }

  @override
  void onClose() {
    _downloadStatusSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    super.onClose();
  }

  /// Get downloaded soundscapes from download controller
  List<DownloadedSoundscape> get downloadedSoundscapes =>
      _downloadController.downloadedSoundscapes;

  /// Initialize listener for download status updates
  void _initializeDownloadListener() {
    final downloadService = Get.find<DownloadService>();

    _downloadStatusSubscription =
        downloadService.downloadStatusStream.listen((downloadItem) {
      if (downloadItem.contentType == DownloadContentType.soundscape) {
        _handleDownloadStatusUpdate(downloadItem);
      }
    });
  }

  /// Initialize listener for player state updates
  void _initializePlayerStateListener() {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      /// * if audio is processing (buffering or loading) then set it to currently loading soundscape
      if (state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering) {
        currentlyLoadingSoundscape.value = currentSoundscape.value;
        startLoading();
      }

      /// * if audio is not processing (idle or ready) then set currentlyLoadingSoundscape to null
      if (state.processingState == ProcessingState.idle ||
          state.processingState == ProcessingState.ready) {
        currentlyLoadingSoundscape.value = null;
        stopLoading();
      }

      /// * if audio is playing then set it to currently playing soundscape
      if (state.playing) {
        currentlyPlayingSoundscape.value = currentSoundscape.value;
      }

      /// * if audio is played completely then remove it from currently playing soundscape
      if (state.processingState == ProcessingState.completed) {
        currentlyPlayingSoundscape.value = null;
      }
    });
  }

  /// Handle download status updates and update the list accordingly
  void _handleDownloadStatusUpdate(DownloadItem downloadItem) {
    switch (downloadItem.status) {
      case DownloadStatus.pending:
      case DownloadStatus.downloading:
        _addPlaceholderIfNeeded(downloadItem);
        break;

      case DownloadStatus.completed:
        _replacePlaceholderWithCompleted(downloadItem);
        break;

      case DownloadStatus.failed:
      case DownloadStatus.cancelled:
        _removePlaceholder(downloadItem.id);
        break;
    }
  }

  /// Check if the given soundscape ID matches currently playing soundscape
  RxBool isCurrentlyPlaying(DownloadedSoundscape soundscape) {
    return (currentlyPlayingSoundscape.value?.id.toString() ==
            soundscape.id.toString())
        .obs;
  }

  /// Check if the given soundscape ID matches currently loading soundscape
  RxBool isCurrentlyLoading(DownloadedSoundscape soundscape) {
    return (currentlyLoadingSoundscape.value?.id.toString() ==
            soundscape.id.toString())
        .obs;
  }

  /// Play soundscape from local file
  Future<void> playSoundscape(String soundscapeId) async {
    try {
      final soundscape = downloadedSoundscapes
          .firstWhere((item) => item.id.toString() == soundscapeId);

      if (soundscape.filePath == null) return;

      final audioFile = File(soundscape.filePath!);
      if (!await audioFile.exists()) {
        throw Exception('Audio file not found');
      }

      if(currentlyPlayingSoundscape.value?.id.toString() == soundscapeId) {
        await _audioPlayer.stop();
        currentlyPlayingSoundscape.value = null;
        return;
      }

      // Stop current playback if any
      await _audioPlayer.stop();

      // Set up the audio source and play
      await _audioPlayer.setFilePath(audioFile.path);
      _audioPlayer.play();

      currentSoundscape.value = soundscape;
    } catch (e) {
      handleFailure(e.toString());
    }
  }

  /// Add a placeholder item for downloads in progress
  void _addPlaceholderIfNeeded(DownloadItem downloadItem) {
    final existsIndex = downloadedSoundscapes
        .indexWhere((item) => item.id.toString() == downloadItem.id);

    if (existsIndex == -1) {
      final soundscapeData = Soundscape.fromJson(downloadItem.metadata);
      final placeholder = DownloadedSoundscape(
        id: int.parse(downloadItem.id),
        name: downloadItem.name,
        description: soundscapeData.description,
        artCover: soundscapeData.artCover?.imageName,
        filePath: null,
        downloadProgress: downloadItem.progress,
        downloadStatus: downloadItem.status,
      );

      _downloadController.downloadedSoundscapes.insert(0, placeholder);
    }
  }

  /// Replace placeholder with completed download
  void _replacePlaceholderWithCompleted(DownloadItem downloadItem) {
    final index = downloadedSoundscapes
        .indexWhere((item) => item.id.toString() == downloadItem.id);

    if (index >= 0) {
      _downloadController.refreshDownloads();
    }
  }

  /// Remove placeholder for cancelled/failed downloads
  void _removePlaceholder(String downloadId) {
    _downloadController.downloadedSoundscapes.removeWhere(
        (item) => item.id.toString() == downloadId && item.filePath == null);
  }

  /// Handle soundscape tap - different behavior for completed vs downloading
  void onSoundscapeTap(DownloadedSoundscape soundscape) {
    if (soundscape.filePath != null) {
      playSoundscape(soundscape.id.toString());
    }
  }

  /// Remove a downloaded soundscape
  Future<void> removeSoundscapeFromDownloads(
      DownloadedSoundscape soundscape) async {
    try {
      if (soundscape.filePath != null) {
        await _downloadController.removeDownloadedSoundscape(soundscape);
      } else {
        await _downloadController.cancelDownload(soundscape.id.toString());
      }
    } catch (e) {
      handleFailure(e.toString());
    }
  }

  /// Check if a soundscape is currently downloading
  bool isDownloading(String soundscapeId) {
    return _downloadController.isDownloading(soundscapeId);
  }

  /// Get download progress for a soundscape
  double getDownloadProgress(String soundscapeId) {
    return _downloadController.getDownloadProgress(soundscapeId);
  }

  /// Get download status for a soundscape
  DownloadStatus? getDownloadStatus(String soundscapeId) {
    return _downloadController.getDownloadStatus(soundscapeId);
  }

  /// Refresh downloads
  Future<void> refreshDownloads() async {
    await _downloadController.refreshDownloads();
  }
}

/// Extension to add copyWith method to DownloadedSoundscape
extension DownloadedSoundscapeCopyWith on DownloadedSoundscape {
  DownloadedSoundscape copyWith({
    int? id,
    String? name,
    String? description,
    String? artCover,
    String? filePath,
    double? downloadProgress,
    DownloadStatus? downloadStatus,
  }) {
    return DownloadedSoundscape(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      artCover: artCover ?? this.artCover,
      filePath: filePath ?? this.filePath,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      downloadStatus: downloadStatus ?? this.downloadStatus,
    );
  }
}
