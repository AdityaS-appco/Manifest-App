import 'dart:convert';
import 'dart:io';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/services/api_service.dart';

/// Base service class providing common functionality for all services
class BaseService {
  /// api service instance
  final ApiService _apiService = ApiService();
  final LocalStorage localStorage = LocalStorage();

  /// Makes an HTTP request to the specified endpoint
  /// Returns a map containing success status and response data
  Future<Map<String, dynamic>> makeRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    bool isGet = false,
    bool isPost = false,
    bool isDelete = false,
    bool withToken = false,
    bool showLoader = true,

    /// ! It is for custom parsing usecase, in case the main response is not coming inside the repsonse[data].
    Function(Map<String, dynamic> response)? responseParser,
  }) async {
    try {
      if (showLoader) LoadingUtil.show();

      final response = await _apiService.request(
        apiEndPoint: endpoint,
        data: data,
        withToken: withToken,
        isGet: isGet,
        isPost: isPost,
        isDelete: isDelete,
      );

      if (showLoader) LoadingUtil.dismiss();

      final responseData = jsonDecode(response.body);
      LogUtil.v(responseData['message']);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': responseParser != null
              ? responseParser(responseData)
              : responseData['data'],
        };
      } else {
        ToastUtil.error(
          responseData['message'] ?? 'Something went wrong',
        );
        return {
          'success': false,
          'message': responseData['message'],
        };
      }
    } catch (e) {
      if (showLoader) LoadingUtil.dismiss();
      ToastUtil.error('Something went wrong');
      LogUtil.e(e.toString());
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Uploads an image file to the specified endpoint
  /// Returns a map containing success status and response data
  Future<Map<String, dynamic>> uploadImage({
    required String apiEndPoint,
    required File imageFile,
    bool showLoader = true,
  }) async {
    try {
      if (showLoader) LoadingUtil.show();

      final response = await _apiService.uploadImage(
        apiEndPoint: apiEndPoint,
        imageFile: imageFile,
      );

      if (showLoader) LoadingUtil.dismiss();

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        ToastUtil.error(
          responseData['message'] ?? 'Something went wrong',
        );
        return {
          'success': false,
          'message': responseData['message'],
        };
      }
    } catch (e) {
      if (showLoader) LoadingUtil.dismiss();
      ToastUtil.error('Something went wrong');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Uploads an audio file to the specified endpoint
  /// Returns a map containing success status and response data
  Future<Map<String, dynamic>> uploadAudio({
    required String apiEndPoint,
    required File audioFile,
    Map<String, String>? additionalFields,
    bool showLoader = true,
  }) async {
    try {
      if (showLoader) LoadingUtil.show();

      final response = await _apiService.uploadAudio(
        apiEndPoint: apiEndPoint,
        audioFile: audioFile,
        additionalFields: additionalFields,
      );

      if (showLoader) LoadingUtil.dismiss();

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        ToastUtil.error(
          responseData['message'] ?? 'Something went wrong',
        );
        return {
          'success': false,
          'message': responseData['message'],
        };
      }
    } catch (e) {
      if (showLoader) LoadingUtil.dismiss();
      ToastUtil.error('Something went wrong');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
   Future<Map<String, dynamic>> uploadMultipleImage({
  required String apiEndPoint,
  required Map<String, dynamic> data,
  bool showLoader = true,
}) async {
  try {
    if (showLoader) LoadingUtil.show();

    final response = await _apiService.requestWithImages(
      apiEndPoint: apiEndPoint,
      data: data,
    );

    if (showLoader) LoadingUtil.dismiss();

    final responseData = jsonDecode(response.body);
    
    if (response.statusCode >=200 && response.statusCode <300) {
        return {
          'success': true,
          'data': responseData['data'],

        };
      } else {
        // API returned 200 but with success: false
        ToastUtil.error(
          responseData['message'] ?? 'Something went wrong',
        );
        return {
          'success': false,
          'message': responseData['message'] ?? 'Operation failed',
        };
      }
    
  } catch (e) {
    if (showLoader) LoadingUtil.dismiss();
    ToastUtil.error('Something went wrong');
    return {
      'success': false,
      'message': e.toString(),
    };
  }
}

}
