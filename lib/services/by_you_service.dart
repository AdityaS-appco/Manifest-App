import 'dart:io';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/core/base/base_service.dart';

/// Service for handling user-generated content operations
class ByYouService extends BaseService {
  /// Create new content in "By You" section
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> createContent({
    required String title,
    String? description,
    required File audioFile,
  }) async {
    final additionalFields = {
      'title': title,
      if (description != null) 'description': description,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await uploadAudio(
      apiEndPoint: ApiService.byYouCreate,
      audioFile: audioFile,
      additionalFields: additionalFields,
    );
  }

  /// Get list of recordings
  /// Returns a map containing success status and list of recordings
  Future<Map<String, dynamic>> getRecordings() async {
    return await makeRequest(
      endpoint: ApiService.getListOfRecordings,
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Get recording details by ID
  /// Returns a map containing success status and recording details
  Future<Map<String, dynamic>> getRecordingById(String recordingId) async {
    return await makeRequest(
      endpoint: '${ApiService.getListOfRecordingsByID}$recordingId',
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Add affirmation to recording
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> addAffirmationToRecording({
    required String recordingId,
    required String affirmationId,
  }) async {
    final body = {
      'recording_id': recordingId,
      'affirmation_id': affirmationId,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.addOrRemoveAffirmationByID,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Remove recording or affirmation
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> removeContent(String contentId) async {
    final body = {
      'content_id': contentId,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.removeAffirmationOrByYou,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }

  /// Rename content or affirmation
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> renameContent({
    required String contentId,
    required String newTitle,
    String? newDescription,
  }) async {
    final body = {
      'content_id': contentId,
      'title': newTitle,
      if (newDescription != null) 'description': newDescription,
      'device_id': LocalStorage.deviceID.toString(),
    };

    return await makeRequest(
      endpoint: ApiService.renameContentOrAffirmationInByYou,
      data: body,
      isPost: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
  }
} 