import 'dart:io';
import 'package:manifest/core/base/base_service.dart';
import 'package:manifest/core/error/failures.dart';
import 'package:manifest/core/network/result.dart';
import 'package:manifest/features/settings/models/profile_local_datasource.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/profile_model.dart';
import 'package:manifest/services/api_service.dart';

class ProfileService extends BaseService {
  final ProfileLocalDataSource _localDataSource;
  ProfileService(this._localDataSource);

  bool _saveProfileToLocalStorage(Profile profile) =>
      _localDataSource.saveProfile(profile);

  Profile getProfileFromLocalStorage() => _localDataSource.getProfile();

  bool clearProfileFromLocalStorage() => _localDataSource.clearProfile();

  /// ! Edit profile
  Future<Result<Profile>> getProfile({bool showLoader = false}) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.profile,
        isGet: true,
        withToken: true,
        showLoader: showLoader,
      );

      if (response['success']) {
        final profile = Profile.fromJson(response['data']);
        _saveProfileToLocalStorage(profile);
        return Result.success(profile);
      } else {
        return Result.failure(
            ServerFailure(response['message'] ?? 'Failed to fetch profile'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  Future<Result<Profile>> updateName(String name) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.updateProfile,
        isPost: true,
        withToken: true,
        data: {'name': name},
        showLoader: true,
      );

      if (response['success']) {
        final profile = Profile.fromJson(response['data']);
        _saveProfileToLocalStorage(profile);
        return Result.success(profile);
      } else {
        return Result.failure(
            ServerFailure(response['message'] ?? 'Failed to update name'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  Future<Result<Profile>> updateGender(String gender) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.updateProfile,
        isPost: true,
        withToken: true,
        data: {'gender': gender},
        showLoader: true,
      );

      if (response['success']) {
        final profile = Profile.fromJson(response['data']);
        _saveProfileToLocalStorage(profile);
        return Result.success(profile);
      } else {
        return Result.failure(
            ServerFailure(response['message'] ?? 'Failed to update gender'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  Future<Result<Profile>> updateDateOfBirth(DateTime dateOfBirth) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.updateProfile,
        isPost: true,
        withToken: true,
        data: {'dob': dateOfBirth.toIso8601String().split('T')[0]},
        showLoader: true,
      );

      if (response['success']) {
        final profile = Profile.fromJson(response['data']);
        _saveProfileToLocalStorage(profile);
        return Result.success(profile);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to update date of birth'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  Future<Result<Profile>> updateProfileImage(File imageFile) async {
    try {
      final response = await uploadImage(
        apiEndPoint: ApiService.updateProfile,
        imageFile: imageFile,
        showLoader: true,
      );

      if (response['success']) {
        final profile = Profile.fromJson(response['data']);
        _saveProfileToLocalStorage(profile);
        return Result.success(profile);
      } else {
        return Result.failure(ServerFailure(
            response['message'] ?? 'Failed to update profile image'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// ! Account
  Future<Result<void>> verifyPasswordToUpdateEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.updateEmail,
        isPost: true,
        withToken: true,
        data: {
          'email': email,
          'password': password,
        },
        showLoader: true,
      );

      if (response['success']) {
        return Result.success(null);
      } else {
        return Result.failure(
            ServerFailure(response['message'] ?? 'Failed to update email'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  Future<Result<void>> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.verifyForgotPasswordOtp,
        isPost: true,
        withToken: false,
        data: {
          'email': email,
          'otp': otp,
          'device_id': LocalStorage.deviceID.toString(),
        },
      );

      if (response['success']) {
        return Result.success(null);
      } else {
        return Result.failure(
            ServerFailure(response['message'] ?? 'Failed to verify OTP'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// * update password 
  Future<Result<void>> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await makeRequest(
        endpoint: ApiService.updatePassword,
        isPost: true,
        withToken: true,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'confirm_new_password': confirmNewPassword,
        },
        showLoader: true,
      );

      if (response['success']) {
        return Result.success(null);
      } else {
        return Result.failure(
            ServerFailure(response['message'] ?? 'Failed to update password'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }

  /// ! Delete Account
  Future<Result<bool>> deleteAccount({
    required int userId,
    required String reason,
  }) async {
    try {
      final response = await makeRequest(
        endpoint: '${ApiService.deleteAccount}?user_id=$userId',
        isGet: true,
        withToken: true,
        data: {
          'reason': reason,
        },
        showLoader: false,
      );

      if (response['success']) {
        return Result.success(true);
      } else {
        return Result.failure(
            ServerFailure(response['message'] ?? 'Failed to delete account'));
      }
    } catch (e) {
      return Result.failure(NetworkFailure(e.toString()));
    }
  }
}
