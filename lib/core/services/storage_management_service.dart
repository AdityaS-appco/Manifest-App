import 'dart:io';
import 'package:get/get.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

enum StorageDirectory {
  soundscapes,
  affirmations,
  tracks,
  playlists,
  mp3s,
  voiceRecords;

  /// Override the name to provide a custom display name
  String get name {
    switch (this) {
      case StorageDirectory.soundscapes:
        return 'Soundscapes';
      case StorageDirectory.affirmations:
        return 'Affirmations';
      case StorageDirectory.tracks:
        return 'Tracks';
      case StorageDirectory.playlists:
        return 'Playlists';
      case StorageDirectory.mp3s:
        return 'MP3s';
      case StorageDirectory.voiceRecords:
        return 'Voice Records'; // Custom name for voiceRecords
    }
  }
}

class StorageManagementService extends GetxService {
  /// * Base directory for all app storage
  late final Directory _baseDirectory;
  
  /// * Directory paths for different types of content
  final Map<StorageDirectory, String> _directoryPaths = {
    StorageDirectory.soundscapes: 'soundscapes',
    StorageDirectory.affirmations: 'affirmations',
    StorageDirectory.tracks: 'affirmations',
    StorageDirectory.playlists: 'playlists',
    StorageDirectory.mp3s: 'mp3s',
    StorageDirectory.voiceRecords: 'voice_records',
  };

  @override
  void onInit() async {
    super.onInit();
    await _initializeStorage();
  }

  /// Initialize storage and create necessary directories
  Future<void> _initializeStorage() async {
    try {
      // Get base directory
      _baseDirectory = await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();

      // Create all required directories
      for (final dirPath in _directoryPaths.values) {
        final directory = Directory('${_baseDirectory.path}/$dirPath');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
      }
    } catch (e) {
      LogUtil.log('Error initializing storage: $e');
    }
  }

  /// Get the path for a specific type of storage
  Future<String> getStoragePath(StorageDirectory directory) async {
    final dirPath = _directoryPaths[directory];
    if (dirPath == null) throw Exception('Invalid storage directory type');
    
    return '${_baseDirectory.path}/$dirPath';
  }

  /// Download and save a file from URL
  Future<String?> downloadFile({
    required String url,
    required String fileName,
    required StorageDirectory directory,
  }) async {
    try {
      final dirPath = await getStoragePath(directory);
      final filePath = '$dirPath/$fileName';

      // Download the file
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to download file from $url');
      }

      // Save the file
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      return filePath;
    } catch (e) {
      LogUtil.log('Error downloading file: $e');
      return null;
    }
  }

  /// Delete a file
  Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      LogUtil.log('Error deleting file: $e');
      return false;
    }
  }

  /// Check if a file exists
  Future<bool> fileExists(String filePath) async {
    try {
      return await File(filePath).exists();
    } catch (e) {
      LogUtil.log('Error checking file existence: $e');
      return false;
    }
  }

  /// Get file size
  Future<int?> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return null;
    } catch (e) {
      LogUtil.log('Error getting file size: $e');
      return null;
    }
  }

  /// Clear all files in a directory
  Future<bool> clearDirectory(StorageDirectory directory) async {
    try {
      final dirPath = await getStoragePath(directory);
      final dir = Directory(dirPath);
      
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        await dir.create();
        return true;
      }
      return false;
    } catch (e) {
      LogUtil.log('Error clearing directory: $e');
      return false;
    }
  }

  /// Get all files in a directory
  Future<List<FileSystemEntity>> getDirectoryContents(
    StorageDirectory directory,
  ) async {
    try {
      final dirPath = await getStoragePath(directory);
      final dir = Directory(dirPath);
      
      if (await dir.exists()) {
        return dir.listSync();
      }
      return [];
    } catch (e) {
      LogUtil.log('Error getting directory contents: $e');
      return [];
    }
  }
}
