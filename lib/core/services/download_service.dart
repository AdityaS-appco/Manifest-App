import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:manifest/core/services/storage_management_service.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/downloaded_soundscape.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';
import 'package:http/http.dart' as http;

enum DownloadStatus {
  pending,    // In queue but not started
  downloading, // Currently downloading
  completed,  // Successfully downloaded
  failed,     // Download failed
  cancelled   // Download cancelled
}

enum DownloadContentType {
  soundscape,
  affirmation,
  track,
  playlist
}

class DownloadItem {
  final String id;
  final String name;
  final String url;
  final String fileName;
  final DownloadContentType contentType;
  final StorageDirectory storageDirectory;
  final Map<String, dynamic> metadata; // Additional data like Soundscape object
  
  DownloadStatus status;
  double progress;
  String? filePath;
  String? errorMessage;
  DateTime createdAt;
  DateTime? startedAt;
  DateTime? completedAt;

  DownloadItem({
    required this.id,
    required this.name,
    required this.url,
    required this.fileName,
    required this.contentType,
    required this.storageDirectory,
    this.metadata = const {},
    this.status = DownloadStatus.pending,
    this.progress = 0.0,
    this.filePath,
    this.errorMessage,
    DateTime? createdAt,
    this.startedAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'fileName': fileName,
      'contentType': contentType.name,
      'storageDirectory': storageDirectory.name,
      'metadata': metadata,
      'status': status.name,
      'progress': progress,
      'filePath': filePath,
      'errorMessage': errorMessage,
      'createdAt': createdAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory DownloadItem.fromJson(Map<String, dynamic> json) {
    return DownloadItem(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      fileName: json['fileName'],
      contentType: DownloadContentType.values.firstWhere(
        (e) => e.name == json['contentType'],
        orElse: () => DownloadContentType.soundscape,
      ),
      storageDirectory: StorageDirectory.values.firstWhere(
        (e) => e.name == json['storageDirectory'],
        orElse: () => StorageDirectory.soundscapes,
      ),
      metadata: json['metadata'] ?? {},
      status: DownloadStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => DownloadStatus.pending,
      ),
      progress: (json['progress'] ?? 0.0).toDouble(),
      filePath: json['filePath'],
      errorMessage: json['errorMessage'],
      createdAt: DateTime.parse(json['createdAt']),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
    );
  }
}

/// Service for handling all download operations with queue management and progress tracking
class DownloadService extends GetxService {
  static const int MAX_CONCURRENT_DOWNLOADS = 1;
  static const int MAX_DOWNLOAD_QUEUE = 3;
  static const String DOWNLOAD_QUEUE_KEY = 'download_queue';
  
  final StorageManagementService _storageService = Get.find();
  
  // Observable states
  final RxList<DownloadItem> _downloadQueue = <DownloadItem>[].obs;
  final RxList<DownloadItem> _activeDownloads = <DownloadItem>[].obs;
  final RxList<DownloadItem> _completedDownloads = <DownloadItem>[].obs;
  
  // Streams for real-time updates
  final _downloadProgressController = StreamController<DownloadItem>.broadcast();
  final _downloadStatusController = StreamController<DownloadItem>.broadcast();
  
  // Getters for reactive state
  List<DownloadItem> get downloadQueue => _downloadQueue;
  List<DownloadItem> get activeDownloads => _activeDownloads;
  List<DownloadItem> get completedDownloads => _completedDownloads;
  
  Stream<DownloadItem> get downloadProgressStream => _downloadProgressController.stream;
  Stream<DownloadItem> get downloadStatusStream => _downloadStatusController.stream;
  
  // HTTP client for downloads
  final http.Client _httpClient = http.Client();
  
  @override
  void onInit() {
    super.onInit();
    _loadPersistedDownloads();
    _startDownloadProcessor();
  }

  @override
  void onClose() {
    _downloadProgressController.close();
    _downloadStatusController.close();
    _httpClient.close();
    super.onClose();
  }

  /// Load persisted downloads from storage
  Future<void> _loadPersistedDownloads() async {
    try {
      final List<dynamic>? persistedDownloads = LocalStorage.kStorage.read(DOWNLOAD_QUEUE_KEY);
      
      if (persistedDownloads != null) {
        for (final downloadData in persistedDownloads) {
          final downloadItem = DownloadItem.fromJson(downloadData);
          
          switch (downloadItem.status) {
            case DownloadStatus.pending:
            case DownloadStatus.downloading:
              // Reset downloading items to pending on app restart
              downloadItem.status = DownloadStatus.pending;
              _downloadQueue.add(downloadItem);
              break;
            case DownloadStatus.completed:
              _completedDownloads.add(downloadItem);
              break;
            case DownloadStatus.failed:
            case DownloadStatus.cancelled:
              // Keep failed/cancelled items in queue for retry
              downloadItem.status = DownloadStatus.pending;
              _downloadQueue.add(downloadItem);
              break;
          }
        }
      }
      
      LogUtil.log('Loaded ${_downloadQueue.length} pending downloads and ${_completedDownloads.length} completed downloads');
    } catch (e) {
      LogUtil.e('Error loading persisted downloads: $e');
    }
  }

  /// Start the download processor that manages the queue
  void _startDownloadProcessor() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_downloadQueue.isNotEmpty && _activeDownloads.length < MAX_CONCURRENT_DOWNLOADS) {
        final nextDownload = _downloadQueue.firstWhereOrNull(
          (item) => item.status == DownloadStatus.pending,
        );
        
        if (nextDownload != null) {
          _startDownload(nextDownload);
        }
      }
    });
  }

  /// Add a download to the queue
  Future<bool> addToDownloadQueue({
    required String id,
    required String name,
    required String url,
    required String fileName,
    required DownloadContentType contentType,
    required StorageDirectory storageDirectory,
    Map<String, dynamic> metadata = const {},
  }) async {
    try {
      // Check if already downloading or completed
      if (_isItemInDownloads(id)) {
        ToastUtil.error('Item is already in downloads');
        return false;
      }

      // Check queue limit
      if (_downloadQueue.length >= MAX_DOWNLOAD_QUEUE) {
        ToastUtil.error('Download queue is full. Maximum $MAX_DOWNLOAD_QUEUE downloads allowed.');
        return false;
      }

      final downloadItem = DownloadItem(
        id: id,
        name: name,
        url: url,
        fileName: fileName,
        contentType: contentType,
        storageDirectory: storageDirectory,
        metadata: metadata,
      );

      _downloadQueue.add(downloadItem);
      await _persistDownloads();
      
      _downloadStatusController.add(downloadItem);
      LogUtil.log('Added download to queue: ${downloadItem.name}');
      
      return true;
    } catch (e) {
      LogUtil.e('Error adding download to queue: $e');
      return false;
    }
  }

  /// Start downloading an item
  Future<void> _startDownload(DownloadItem downloadItem) async {
    try {
      // Move from queue to active downloads
      _downloadQueue.remove(downloadItem);
      _activeDownloads.add(downloadItem);
      
      // Update status
      downloadItem.status = DownloadStatus.downloading;
      downloadItem.startedAt = DateTime.now();
      downloadItem.progress = 0.0;
      
      _downloadStatusController.add(downloadItem);
      await _persistDownloads();
      
      LogUtil.log('Starting download: ${downloadItem.name}');
      
      // Start the actual download
      await _downloadFile(downloadItem);
      
    } catch (e) {
      LogUtil.e('Error starting download: $e');
      await _handleDownloadFailure(downloadItem, e.toString());
    }
  }

  /// Download the actual file with progress tracking
  Future<void> _downloadFile(DownloadItem downloadItem) async {
    try {
      final request = http.Request('GET', Uri.parse(downloadItem.url));
      final response = await _httpClient.send(request);
      
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: Failed to download file');
      }

      final contentLength = response.contentLength ?? 0;
      final filePath = await _storageService.getStoragePath(downloadItem.storageDirectory);
      final file = File('$filePath/${downloadItem.fileName}');
      
      // Ensure directory exists
      await file.parent.create(recursive: true);
      
      final sink = file.openWrite();
      int downloadedBytes = 0;

      await for (final chunk in response.stream) {
        downloadedBytes += chunk.length;
        sink.add(chunk);
        
        // Update progress
        if (contentLength > 0) {
          final progress = downloadedBytes / contentLength;
          downloadItem.progress = progress.clamp(0.0, 1.0);
          _downloadProgressController.add(downloadItem);
        }
      }

      await sink.close();
      
      // Verify file was created and has content
      if (await file.exists() && await file.length() > 0) {
        await _handleDownloadSuccess(downloadItem, file.path);
      } else {
        throw Exception('Downloaded file is empty or was not created');
      }
      
    } catch (e) {
      LogUtil.e('Error downloading file: $e');
      await _handleDownloadFailure(downloadItem, e.toString());
    }
  }

  /// Handle successful download completion
  Future<void> _handleDownloadSuccess(DownloadItem downloadItem, String filePath) async {
    try {
      // Update download item
      downloadItem.status = DownloadStatus.completed;
      downloadItem.progress = 1.0;
      downloadItem.filePath = filePath;
      downloadItem.completedAt = DateTime.now();
      
      // Move from active to completed
      _activeDownloads.remove(downloadItem);
      _completedDownloads.add(downloadItem);
      
      // Add to appropriate local storage based on content type
      if (downloadItem.contentType == DownloadContentType.soundscape) {
        final soundscape = Soundscape.fromJson(downloadItem.metadata);
        final downloadedSoundscape = DownloadedSoundscape.fromSoundscape(soundscape, filePath);
        await LocalStorage.addDownloadedSoundscape(downloadedSoundscape);
      }
      
      _downloadStatusController.add(downloadItem);
      await _persistDownloads();
      
      LogUtil.log('Download completed successfully: ${downloadItem.name}');
      
    } catch (e) {
      LogUtil.e('Error handling download success: $e');
      await _handleDownloadFailure(downloadItem, 'Failed to finalize download: $e');
    }
  }

  /// Handle download failure
  Future<void> _handleDownloadFailure(DownloadItem downloadItem, String errorMessage) async {
    try {
      downloadItem.status = DownloadStatus.failed;
      downloadItem.errorMessage = errorMessage;
      downloadItem.completedAt = DateTime.now();
      
      // Move from active back to queue for potential retry
      _activeDownloads.remove(downloadItem);
      _downloadQueue.add(downloadItem);
      
      _downloadStatusController.add(downloadItem);
      await _persistDownloads();
      
      LogUtil.e('Download failed: ${downloadItem.name} - $errorMessage');
      
    } catch (e) {
      LogUtil.e('Error handling download failure: $e');
    }
  }

  /// Cancel a download
  Future<bool> cancelDownload(String id) async {
    try {
      final downloadItem = _findDownloadById(id);
      if (downloadItem == null) {
        ToastUtil.error('Download not found');
        return false;
      }

      downloadItem.status = DownloadStatus.cancelled;
      downloadItem.completedAt = DateTime.now();
      
      // Remove from appropriate list
      _downloadQueue.remove(downloadItem);
      _activeDownloads.remove(downloadItem);
      
      _downloadStatusController.add(downloadItem);
      await _persistDownloads();
      
      LogUtil.log('Download cancelled: ${downloadItem.name}');
      
      return true;
    } catch (e) {
      LogUtil.e('Error cancelling download: $e');
      return false;
    }
  }

  /// Retry a failed download
  Future<bool> retryDownload(String id) async {
    try {
      final downloadItem = _findDownloadById(id);
      if (downloadItem == null) {
        ToastUtil.error('Download not found');
        return false;
      }

      if (downloadItem.status != DownloadStatus.failed) {
        ToastUtil.error('Only failed downloads can be retried');
        return false;
      }

      // Reset download state
      downloadItem.status = DownloadStatus.pending;
      downloadItem.progress = 0.0;
      downloadItem.errorMessage = null;
      downloadItem.startedAt = null;
      downloadItem.completedAt = null;
      
      // Move to queue if not already there
      if (!_downloadQueue.contains(downloadItem)) {
        _downloadQueue.add(downloadItem);
      }
      
      _downloadStatusController.add(downloadItem);
      await _persistDownloads();
      
      LogUtil.log('Download retry queued: ${downloadItem.name}');
      
      return true;
    } catch (e) {
      LogUtil.e('Error retrying download: $e');
      return false;
    }
  }

  /// Remove a download completely
  Future<bool> removeDownload(String id) async {
    try {
      final downloadItem = _findDownloadById(id);
      if (downloadItem == null) {
        ToastUtil.error('Download not found');
        return false;
      }

      // Delete file if it exists
      if (downloadItem.filePath != null) {
        await _storageService.deleteFile(downloadItem.filePath!);
      }

      // Remove from appropriate storage based on content type
      if (downloadItem.contentType == DownloadContentType.soundscape) {
        await LocalStorage.removeDownloadedSoundscape(int.parse(downloadItem.id));
      }

      // Remove from all lists
      _downloadQueue.remove(downloadItem);
      _activeDownloads.remove(downloadItem);
      _completedDownloads.remove(downloadItem);
      
      await _persistDownloads();
      
      LogUtil.log('Download removed: ${downloadItem.name}');
      
      return true;
    } catch (e) {
      LogUtil.e('Error removing download: $e');
      return false;
    }
  }

  /// Get download status for a specific item
  DownloadItem? getDownloadStatus(String id) {
    return _findDownloadById(id);
  }

  /// Check if an item is in any download state
  bool _isItemInDownloads(String id) {
    return _findDownloadById(id) != null;
  }

  /// Find download item by ID across all lists
  DownloadItem? _findDownloadById(String id) {
    // Check all lists
    for (final list in [_downloadQueue, _activeDownloads, _completedDownloads]) {
      final item = list.cast<DownloadItem?>().firstWhereOrNull(
        (item) => item?.id == id,
      );
      if (item != null) return item;
    }
    return null;
  }

  /// Persist downloads to local storage
  Future<void> _persistDownloads() async {
    try {
      final allDownloads = [
        ..._downloadQueue,
        ..._activeDownloads,
        ..._completedDownloads,
      ];
      
      final downloadData = allDownloads.map((item) => item.toJson()).toList();
      LocalStorage.kStorage.write(DOWNLOAD_QUEUE_KEY, downloadData);
    } catch (e) {
      LogUtil.e('Error persisting downloads: $e');
    }
  }

  /// Get all downloads for a specific content type
  List<DownloadItem> getDownloadsByType(DownloadContentType contentType) {
    final allDownloads = [..._downloadQueue, ..._activeDownloads, ..._completedDownloads];
    return allDownloads.where((item) => item.contentType == contentType).toList();
  }

  /// Clear all completed downloads
  Future<bool> clearCompletedDownloads() async {
    try {
      _completedDownloads.clear();
      await _persistDownloads();
      return true;
    } catch (e) {
      LogUtil.e('Error clearing completed downloads: $e');
      return false;
    }
  }
}