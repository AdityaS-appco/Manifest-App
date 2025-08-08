import 'dart:convert';

import 'package:manifest/core/utils/enums/days_of_week.enum.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/downloaded_soundscape.dart';

class LocalStorage {
  // Define keys as constants to avoid typos
  static const String themeMode = 'themeMode';
  static const String _accessToken = 'userAccessToken';
  static const String _userVisit = 'userVisit';
  static const String _deviceID = 'deviceID';
  static const String _selectedLanguageKey = 'selectLang';
  static const String _selectedCountryCodeKey = 'selectedCountryCode';
  static const String _selectedLanguageNameKey = 'selectedLanguage';
  static const String _isGoalsPreferenceSavedKey = 'isGoalsPreferenceSaved';
  static const String _isInitialReminderSetKey = 'isInitialReminderSet';
  static const String _downloadedSoundscapes = 'downloadedSoundscapes';
  static const String _downloadedSoundscapesMetadata =
      'downloadedSoundscapesMetadata';
  static const String _initialReminder = 'initialReminder';

  /// * get storage instance
  static final GetStorage kStorage = GetStorage();

  /// * getter & setter for initial reminder set value
  static set isInitialReminderSet(bool value) {
    kStorage.write(_isInitialReminderSetKey, value);
  }

  static bool get isInitialReminderSet {
    return kStorage.read(_isInitialReminderSetKey) ?? false;
  }

  /// * getter & setter for goals preference saved value
  static set isGoalsPreferenceSaved(bool value) {
    kStorage.write(_isGoalsPreferenceSavedKey, value);
  }

  static bool get isGoalsPreferenceSaved {
    return kStorage.read(_isGoalsPreferenceSavedKey) ?? false;
  }

  // setter
  static setLoginToken(String token) {
    kStorage.write(_accessToken, token);
  }

  static _getLoginToken() {
    return kStorage.read(_accessToken) ?? '';
  }

  static removeLoginToken() {
    return kStorage.remove(_accessToken);
  }

  static setUserVisitValue(bool value) {
    kStorage.write(_userVisit, value);
  }

  static _getUserVisitValue() {
    return kStorage.read(_userVisit) ?? false;
  }

  static setDeviceID(String deviceID) {
    kStorage.write(_deviceID, deviceID);
  }

  static _getDeviceID() {
    return kStorage.read(_deviceID) ?? '';
  }

  static setUserID(String userID) {
    kStorage.write("user_id", userID);
  }

  static getUserID() {
    return kStorage.read("user_id") ?? '';
  }

  /// Writes the selected language code (e.g., 'en', 'sv') to storage.
  static Future<void> writeSelectedLanguage(String languageCode) async {
    await kStorage.write(_selectedLanguageKey, languageCode);
  }

  /// Writes the selected country code (e.g., 'US', 'SE') to storage.
  static Future<void> writeSelectedCountryCode(String countryCode) async {
    await kStorage.write(_selectedCountryCodeKey, countryCode);
  }

  /// Writes the selected language name (e.g., 'English', 'Swedish') to storage.
  static Future<void> writeSelectedLanguageName(String languageName) async {
    await kStorage.write(_selectedLanguageNameKey, languageName);
  }

  /// Private method to get the app language code.
  static String _getAppLanguage() {
    return kStorage.read(_selectedLanguageKey) ?? 'en';
  }

  /// Private method to get the selected country code.
  static String _getSelectedCountryCode() {
    return kStorage.read(_selectedCountryCodeKey) ?? 'US';
  }

  /// Private method to get the selected language name.
  static String _getSelectedLanguageName() {
    return kStorage.read(_selectedLanguageNameKey) ?? 'English';
  }

  
  // ============================
  // Read Methods as Getters
  // ============================

  /// Retrieves the selected language code. Defaults to 'en' if not set.
  static String get appLanguage => _getAppLanguage();

  /// Retrieves the selected country code. Defaults to 'US' if not set.
  static String get selectedCountryCode => _getSelectedCountryCode();

  /// Retrieves the selected language name. Defaults to 'English' if not set.
  static String get selectedLanguageName => _getSelectedLanguageName();

  static String get userAccessToken => _getLoginToken();
  static String get deviceID => _getDeviceID();
  static String get userID => getUserID();
  static bool get isUserVisit => _getUserVisitValue();

  static bool get isUserPremium =>
      kStorage.read(LocalStorageKeyConstants.isUserPremium) ?? false;
  static set isUserPremium(bool value) =>
      kStorage.write(LocalStorageKeyConstants.isUserPremium, value);

  static List<DownloadedSoundscape> get downloadedSoundscapes {
    final List<dynamic>? data = kStorage.read(_downloadedSoundscapes);
    if (data == null) return [];
    return data.map((json) => DownloadedSoundscape.fromJson(json)).toList();
  }

  static Future<void> addDownloadedSoundscape(
      DownloadedSoundscape soundscape) async {
    final soundscapes = downloadedSoundscapes;
    final index = soundscapes.indexWhere((s) => s.id == soundscape.id);
    if (index != -1) {
      soundscapes[index] = soundscape;
    } else {
      soundscapes.add(soundscape);
    }
    await kStorage.write(
        _downloadedSoundscapes, soundscapes.map((s) => s.toJson()).toList());
  }

  static Future<void> removeDownloadedSoundscape(int id) async {
    final soundscapes = downloadedSoundscapes;
    soundscapes.removeWhere((s) => s.id == id);
    await kStorage.write(
        _downloadedSoundscapes, soundscapes.map((s) => s.toJson()).toList());
  }

  static Map<String, dynamic> get downloadedSoundscapesMetadata {
    return (kStorage.read(_downloadedSoundscapesMetadata)
                as Map<dynamic, dynamic>?)
            ?.cast<String, dynamic>() ??
        {};
  }



  static void setInitialReminder({
    required DateTime reminderStartTime,
    required DateTime reminderEndTime,
    required RxSet<DaysOfWeek> daysOfWeek,
    required int notificationPerDayCount,
  }) {
    // Convert the RxSet to a List<String> for JSON encoding.
    List<String> daysAsString =
        daysOfWeek.map((day) => day.toString()).toList();
    kStorage.write(_initialReminder, {
      'reminderStartTime': reminderStartTime.toIso8601String(),
      'reminderEndTime': reminderEndTime.toIso8601String(),
      'daysOfWeek': daysAsString,
      'notificationPerDayCount': notificationPerDayCount,
    });
  }


  static (
    DateTime reminderStartTime,
    DateTime reminderEndTime,
    RxSet<DaysOfWeek> daysOfWeek,
    int notificationPerDayCount
  ) getInitialReminder() {
    // kStorage.read returns a Map, so no need to call jsonDecode.
    final Map<String, dynamic> json =
        kStorage.read(_initialReminder) as Map<String, dynamic>;

    // Parse the stored reminderTime (which is a String) into a DateTime.
    final DateTime reminderStartTime =
        DateTime.parse(json['reminderStartTime'] as String);
    final DateTime reminderEndTime =
        DateTime.parse(json['reminderEndTime'] as String);

    // Retrieve the stored days as a List and convert them back to RxSet<DaysOfWeek>.
    final List<dynamic> daysList = json['daysOfWeek'] as List<dynamic>;
    RxSet<DaysOfWeek> daysOfWeek = RxSet<DaysOfWeek>();
    for (var day in daysList) {
      // Assuming day is stored as "DaysOfWeek.monday", "DaysOfWeek.tuesday", etc.
      daysOfWeek.add(DaysOfWeek.values.firstWhere((e) => e.toString() == day));
    }

    final int notificationPerDayCount = json['notificationPerDayCount'] as int;

    return (
      reminderStartTime,
      reminderEndTime,
      daysOfWeek,
      notificationPerDayCount
    );
  }
}

class LocalStorageKeyConstants {
  static const String userAccessToken = 'userAccessToken';
  static const String deviceID = 'deviceID';
  static const String isUserVisit = 'isUserVisit';
  static const String isUserPremium = 'isUserPremium';
}
