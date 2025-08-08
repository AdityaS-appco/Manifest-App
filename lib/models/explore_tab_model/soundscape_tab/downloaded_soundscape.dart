import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/features/playlist/playlist_type.enum.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';
import 'package:manifest/core/services/download_service.dart';

class DownloadedSoundscape {
  int? id;
  String? name;
  String? artCover;
  String? category;
  String? videoTheme;
  String? tags;
  String? description;
  String?
      filePath; // Local file path instead of sound URL - null indicates download in progress
  int? status;
  int? favorite;
  int? userId;
  String? deviceId;
  PlaylistType? createdBy;
  String? file;
  String? subscriptionPlan;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Download-specific fields
  double? downloadProgress; // 0.0 to 1.0
  DownloadStatus? downloadStatus;
  DateTime? downloadedAt;

  DownloadedSoundscape({
    this.id,
    this.name,
    this.artCover,
    this.category,
    this.videoTheme,
    this.tags,
    this.description,
    this.filePath,
    this.status,
    this.favorite,
    this.userId,
    this.deviceId,
    this.createdBy,
    this.file,
    this.subscriptionPlan,
    this.createdAt,
    this.updatedAt,
    this.downloadProgress,
    this.downloadStatus,
    this.downloadedAt,
  });

  /// Check if this soundscape is fully downloaded
  bool get isDownloaded => filePath != null && filePath!.isNotEmpty;

  /// Check if this soundscape is currently downloading
  bool get isDownloading => downloadStatus == DownloadStatus.downloading;

  /// Check if this soundscape is pending download
  bool get isPending => downloadStatus == DownloadStatus.pending;

  /// Check if download failed
  bool get isFailed => downloadStatus == DownloadStatus.failed;

  /// Check if download was cancelled
  bool get isCancelled => downloadStatus == DownloadStatus.cancelled;

  /// Check if download is in progress (pending or downloading)
  bool get isInProgress => isPending || isDownloading;

  /// Get progress percentage as integer (0-100)
  int get progressPercentage => ((downloadProgress ?? 0.0) * 100).round();

  /// Get status text for UI display
  String get statusText {
    if (isDownloaded) return 'Downloaded';

    switch (downloadStatus) {
      case DownloadStatus.pending:
        return 'Queued';
      case DownloadStatus.downloading:
        return 'Downloading... $progressPercentage%';
      case DownloadStatus.failed:
        return 'Failed';
      case DownloadStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  // Convert from Soundscape to DownloadedSoundscape
  factory DownloadedSoundscape.fromSoundscape(
      Soundscape soundscape, String filePath) {
    return DownloadedSoundscape(
      id: soundscape.id,
      name: soundscape.name,
      artCover: soundscape.artCover?.imageName,
      category: soundscape.category,
      videoTheme: soundscape.videoTheme,
      tags: soundscape.tags,
      description: soundscape.description,
      filePath: filePath,
      status: soundscape.status,
      favorite: soundscape.favorite,
      userId: soundscape.userId,
      deviceId: soundscape.deviceId,
      createdBy: soundscape.createdBy,
      file: soundscape.file,
      subscriptionPlan: soundscape.subscriptionPlan,
      createdAt: soundscape.createdAt,
      updatedAt: soundscape.updatedAt,
      downloadProgress: 1.0,
      downloadStatus: DownloadStatus.completed,
      downloadedAt: DateTime.now(),
    );
  }

  /// Create a placeholder for download in progress
  factory DownloadedSoundscape.placeholder({
    required int id,
    required String name,
    String? description,
    String? artCover,
    double progress = 0.0,
    DownloadStatus status = DownloadStatus.pending,
    String? category,
    String? videoTheme,
    String? tags,
  }) {
    return DownloadedSoundscape(
      id: id,
      name: name,
      description: description,
      artCover: artCover,
      category: category,
      videoTheme: videoTheme,
      tags: tags,
      filePath: null, // null indicates not yet downloaded
      downloadProgress: progress,
      downloadStatus: status,
    );
  }

  factory DownloadedSoundscape.fromJson(Map<String, dynamic> json) {
    return DownloadedSoundscape(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      name: json['name'],
      artCover: json['art_cover'],
      category: json['category'],
      videoTheme: json['video_theme'],
      tags: json['tags'],
      description: json['description'],
      filePath: json['file_path'],
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      favorite: json['favorite'] is String
          ? int.tryParse(json['favorite'])
          : json['favorite'],
      userId: json['user_id'] is String
          ? int.tryParse(json['user_id'])
          : json['user_id'],
      deviceId: json['device_id'],
      createdBy: (json['created_by'] as String? ?? 'A') == 'A' ||
              (json['created_by'] as String? ?? 'A') == '1'
          ? PlaylistType.admin
          : PlaylistType.custom,
      file: json['file'],
      subscriptionPlan: json['subscription_plan'].toString(),
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      downloadProgress: json['download_progress']?.toDouble(),
      downloadStatus: json['download_status'] != null
          ? DownloadStatus.values
              .firstWhere(
                (e) => e.name == json['download_status'],
                orElse: () => DownloadStatus.pending,
              )
          : null,
      downloadedAt: json['downloaded_at'] != null
          ? DateTime.tryParse(json['downloaded_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'art_cover': artCover,
      'category': category,
      'video_theme': videoTheme,
      'tags': tags,
      'description': description,
      'file_path': filePath,
      'status': status,
      'favorite': favorite,
      'user_id': userId,
      'device_id': deviceId,
      'created_by': createdBy == PlaylistType.admin ? 'A' : 'C',
      'file': file,
      'subscription_plan': subscriptionPlan,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'download_progress': downloadProgress,
      'download_status': downloadStatus?.name,
      'downloaded_at': downloadedAt?.toIso8601String(),
    };
  }

  /// Convert DownloadedSoundscape back to original Soundscape
  Soundscape toSoundscape() {
    return Soundscape(
      id: id,
      name: name,
      artCover: ImageData.defaultImage(artCover ?? ""),
      category: category,
      videoTheme: videoTheme,
      tags: tags,
      description: description,
      status: status,
      favorite: favorite,
      userId: userId,
      deviceId: deviceId,
      createdBy: createdBy,
      file: file,
      subscriptionPlan: subscriptionPlan,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create a copy with updated values
  DownloadedSoundscape copyWith({
    int? id,
    String? name,
    String? artCover,
    String? category,
    String? videoTheme,
    String? tags,
    String? description,
    String? filePath,
    int? status,
    int? favorite,
    int? userId,
    String? deviceId,
    PlaylistType? createdBy,
    String? file,
    String? subscriptionPlan,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? downloadProgress,
    DownloadStatus? downloadStatus,
    DateTime? downloadedAt,
  }) {
    return DownloadedSoundscape(
      id: id ?? this.id,
      name: name ?? this.name,
      artCover: artCover ?? this.artCover,
      category: category ?? this.category,
      videoTheme: videoTheme ?? this.videoTheme,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      filePath: filePath ?? this.filePath,
      status: status ?? this.status,
      favorite: favorite ?? this.favorite,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      createdBy: createdBy ?? this.createdBy,
      file: file ?? this.file,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      downloadedAt: downloadedAt ?? this.downloadedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DownloadedSoundscape && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'DownloadedSoundscape{id: $id, name: $name, isDownloaded: $isDownloaded, status: $downloadStatus, progress: $downloadProgress}';
  }
}

// Extension for List operations
extension DownloadedSoundscapeListExtension on List<DownloadedSoundscape?> {
  /// Filter completed downloads
  List<DownloadedSoundscape> get completed => whereType<DownloadedSoundscape>()
      .where((item) => item.isDownloaded)
      .toList();

  /// Filter downloads in progress
  List<DownloadedSoundscape> get inProgress => whereType<DownloadedSoundscape>()
      .where((item) => item.isInProgress)
      .toList();

  /// Filter failed downloads
  List<DownloadedSoundscape> get failed =>
      whereType<DownloadedSoundscape>().where((item) => item.isFailed).toList();
}
