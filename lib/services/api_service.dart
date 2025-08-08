import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:http/http.dart' as http;

/// Service class containing all API endpoints and functionality
class ApiService extends GetxService {
  /// Base URLs for different environments
  static const String baseUrlLive =
      'https://manifest.digitalupgraders.com/api/';
  static const String baseUrlLocal = 'https://ops.manifest.so/api/';
  static const String baseUrl =
      baseUrlLocal; // Change this for different environments

  /// Authentication endpoints
  static const String loginWithEmail = 'login';
  static const String registerWithEmail = 'register';
  static const String forgotPasswordByOtp = 'forgot_password_by_otp';
  static const String verifyForgotPasswordOtp = 'verify_forgot_password_otp';
  static const String resetPasswordByOtp = 'reset_password_by_otp';
  static const String loginWithSocial = 'social_login';
  static const String logout = 'logout';

  /// profile
  static const String profile = 'profile';
  static const String updateEmail = 'send_update_email';
  static const String verifyEmailOtp = 'verify_update_email_otp';
  static const String updateProfile = 'update_profile';
  static const String updatePassword = 'update_password';
  static const String deleteAccount = 'delete_account';


  /// Home screen endpoints
  static const String home = 'home_data';
  static const String addToRecentPlayed = 'add_to_recent_played';

  /// Affirmation related endpoints
  static const String hideAffirmation = 'affirmations/hide';
  static const String addAffirmationToFavorite = 'add_to_favorite_affirmation';
  static const String getFavoriteAffirmations = 'get_favorite_affirmation';
  static const String getAffirmationsList = 'affirmations';
  static const String getHiddenAffirmations =
      'affirmations/get_hide_affrimations';
  static const String addAffirmationToCreatedPlaylist =
      'add_affirmation_to_playlist';

  /// Collection related endpoints
  static const String getCollections = 'collections';
  static const String createCollection = 'collections/create';
  static const String deleteCollection = 'collections/delete';
  static const String addAffirmationsToCollection = 'collections/affirmations';
  static const String removeAffirmationsFromCollection =
      'collections/remove_affirmations';

  /// Playlist related endpoints
  static const String createPlaylist = 'playlist/create';
  static const String getPlaylists = 'playlist';
  static const String addTrackToPlaylist = 'playlist/tracks';
  static const String removeTracksFromPlaylist = 'playlist/remove_tracks';
  static const String deletePlaylist = 'playlist/delete';
  static const String getAdminPlaylists = 'playlist/all';
  static const String addAffirmationToPlaylist = 'playlist/affirmations/add';
  static const String getMyPlaylistData = 'playlist';

  /// Track related endpoints
  static const String getTracks = 'tracks';
  static const String getTrackDetails = 'tracks/details';
  static const String addTrackToFavorite = 'add_to_favorite_track';
  static const String getFavoriteTracks = 'get_favorite_tracks';
  static const String removeTrackFromFavorite = 'tracks/favorite/remove';
  static const String trackById = 'tracks/';

  /// Soundscape related endpoints
  static const String getSoundScapes = 'soundscape';
  static const String createSoundScape = 'soundscape/create';
  static const String addSoundscapeToFavorite = 'soundscapes/favorite/add';
  static const String removeSoundscapeFromFavorite =
      'soundscapes/favorite/remove';

  /// By You tab endpoints
  static const String byYouCreate = 'by_you/create';
  static const String getListOfRecordings = 'by_you';
  static const String getListOfRecordingsByID = 'by_you/';
  static const String addOrRemoveAffirmationByID = 'by_you/affirmation';
  static const String removeAffirmationOrByYou = 'by_you/remove';
  static const String renameContentOrAffirmationInByYou = 'by_you/rename';

  /// Explore endpoints
  static const String explorerCategories = 'explorer';
  static const String explorerCategoriesById = 'explorer/';
  static String explorePlaylistsByCategoryId(int id) => 'explorer/$id?isPlaylist=true';
  static String exploreTracksByCategoryId(int id) => 'explorer/$id?isTrack=true';
  static String explorerSubcategoryByTagId(int tagId, int categoryId) => 'explorer/bytag/list?tag_id=$tagId&category_id=$categoryId';
  static const String explorerPlaylistById = 'playlist/';
  static const String getFeaturedData = 'explorer/list';

  /// Goals endpoints
  static const String getGoalsCategories = 'affirmation-category';
  static const String saveGoalsCategories = 'affirmation-category/save';

  /// set reminder
  static const String getReminders = "reminders";
  static const String setRegularReminder = "reminders/regular";
  static const String setCustomReminder = "reminders/custom";
  static const String updateReminder = "reminders/update";
  static const String deleteReminder = "reminders/delete";

  /// Notification related endpoints [not matched with original apis]
  static const String getNotifications = 'notification/get';
  static const String markNotificationAsRead = 'notification/mark_as_read';

  /// Survey related endpoints
  static const String getSurvey = 'survey';
  static const String saveSurvey = 'survey/save';

  /// report affirmation
  static const String reportAffirmation = 'bug-report/save';
///Rate us
  static const String sendResult = 'result/save';
   static const String sendSuggesttion = 'suggestion/save';
   static const String reportbug = 'bug-report/save';
   static const String joinNewsLetter = 'subscribe/newsletter';
  /// profile

  /// Returns headers for API requests
  Map<String, String> _headers(bool withToken) {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    if (withToken) {
      headers['Authorization'] = 'Bearer ${LocalStorage.userAccessToken}';
    }
    return headers;
  }

  /// Makes an HTTP request to the specified endpoint
  Future<http.Response> request({
    required String apiEndPoint,
    Map<String, dynamic>? data,
    bool withToken = true,
    bool isPost = false,
    bool isGet = false,
    bool isDelete = false,
  }) async {
    LogUtil.e('Endpoint: $baseUrl$apiEndPoint');
    LogUtil.v('data: $data');
    LogUtil.v('withToken: $withToken');
    LogUtil.v('isPost: $isPost');
    LogUtil.v('isGet: $isGet');
    LogUtil.v('isDelete: $isDelete');
    LogUtil.v('headers: ${_headers(withToken)}');

    dynamic body = isPost ? json.encode(data) : null;
    LogUtil.v('body: $body');

    late http.Response response;
    if (isPost) {
      response = await http.post(Uri.parse('$baseUrl$apiEndPoint'),
          headers: _headers(withToken), body: body);
    } else if (isGet) {
      response = await http.get(Uri.parse('$baseUrl$apiEndPoint'),
          headers: _headers(withToken));
    } else if (isDelete) {
      response = await http.delete(Uri.parse('$baseUrl$apiEndPoint'),
          headers: _headers(withToken));
    }

    LogUtil.e('endpoint: $baseUrl$apiEndPoint');
    LogUtil.v('response: ${response.body}');

    return response;
  }
 Future<http.Response> requestWithImages({
  required String apiEndPoint,
  required Map<String, dynamic> data,
}) async {
  final uri = Uri.parse('$baseUrl$apiEndPoint');
  final request = http.MultipartRequest('POST', uri)
    ..headers.addAll(_headers(true));

  for (var entry in data.entries) {
    final key = entry.key;
    final value = entry.value;

    if (value is File) {
      request.files.add(await http.MultipartFile.fromPath(key, value.path));
    } else if (value is List<File>) {
      for (var file in value) {
        request.files.add(await http.MultipartFile.fromPath(key, file.path));
      }
    } else if (value != null) {
      request.fields[key] = value.toString();
    }
  }

  final streamedResponse = await request.send();
  return await http.Response.fromStream(streamedResponse);
}
  /// Uploads an image file to the specified endpoint
  Future<http.Response> uploadImage({
    required String apiEndPoint,
    required File imageFile,
  }) async {
    var uri = Uri.parse('$baseUrl$apiEndPoint');
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(_headers(true))
      ..files.add(http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        await imageFile.length(),
        filename: imageFile.path.split('/').last,
      ));
    final response = await http.Response.fromStream(await request.send());
    return response;
  }

  /// Uploads an audio file to the specified endpoint
  Future<http.Response> uploadAudio({
    required String apiEndPoint,
    required File audioFile,
    Map<String, String>? additionalFields,
  }) async {
    var uri = Uri.parse('$baseUrl$apiEndPoint');
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(_headers(true))
      ..files.add(
        http.MultipartFile(
          'file',
          audioFile.readAsBytes().asStream(),
          await audioFile.length(),
          filename: audioFile.path.split('/').last,
        ),
      );

    if (additionalFields != null) {
      request.fields.addAll(additionalFields);
    }

    return await http.Response.fromStream(await request.send());
  }
}
