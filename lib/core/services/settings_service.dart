import 'dart:developer';
import 'dart:io';


import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manifest/core/base/base_service.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/utils/enums/days_of_week.enum.dart';
import 'package:manifest/features/reminder/models/reminder_model.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/services/api_service.dart';

import '../error/failures.dart';
import '../network/result.dart';

class SettingsService extends BaseService {

  Future<Result<String>> saveSendResult({
    required List<File> imageFiles,
    required String title,
    required String userId,
    required String deviceId,
  }) async {
    try {
      final data = {
        'attachments[]': imageFiles,
        'title': title,
        'user_id': userId,
        'device_id': deviceId,
      };
      log("-----data--${data.toString()}");
      
      final response = await uploadMultipleImage(
        apiEndPoint: ApiService.sendResult,
        data: data
      );

      if (response['success']) {
        // Return the success message from the response
        return Result.success(response['message'] ?? 'Images uploaded successfully');
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to upload images'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  Future<Result<String>> sendSuggestions({
    required List<File> imageFiles,
    required String title,
     required String message,
    required String userId,
    required String deviceId,
  }) async {
    try {
      final data = {
        'attachments[]': imageFiles,
        'title':title,
        'message': message,
        'user_id': userId,
        'device_id': deviceId,
      };
      log("-----data--${data.toString()}");
      
      final response = await uploadMultipleImage(
        apiEndPoint: ApiService.sendResult,
        data: data
      );

      if (response['success']) {
        // Return the success message from the response
        return Result.success(response['message'] ?? 'Images uploaded successfully');
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to upload images'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }
    Future<Result<String>> reportBug({
    required List<File> imageFiles,
    required String title,
     required String message,
    required String userId,
    required String deviceId,
  }) async {
    try {
      final data = {
        'attachments[]': imageFiles,
        'title':title,
        'message': message,
        'user_id': userId,
        'device_id': deviceId,
      };
      log("-----data--${data.toString()}");
      
      final response = await uploadMultipleImage(
        apiEndPoint: ApiService.reportbug,
        data: data
      );

      if (response['success']) {
        // Return the success message from the response
        return Result.success(response['message'] ?? 'Images uploaded successfully');
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to upload images'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }
      Future<Result<String>> joinNewsLetter({
    required String userId,
    required String deviceId,
    required String email,
  }) async {
    try {
      final data = {
        'user_id': userId,
        'device_id': deviceId,
        'email':email
      };
      log("-----data--${data.toString()}");
      
      final response = await uploadMultipleImage(
        apiEndPoint: ApiService.joinNewsLetter,
        data: data
      );

      if (response['success']) {
        // Return the success message from the response
        return Result.success(response['message'] ?? 'Images uploaded successfully');
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to upload images'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }
}
