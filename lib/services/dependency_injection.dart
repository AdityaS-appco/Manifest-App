import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:manifest/controllers/audio_recorder_controller.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/controllers/download/download_controller.dart';
import 'package:manifest/controllers/explore_controller.dart';
import 'package:manifest/controllers/explore_tab/explore_categories_controller.dart';
import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/controllers/home_media_player_controller.dart';
import 'package:manifest/core/services/download_service.dart';
// import 'package:manifest/controllers/home_controller.dart';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/controllers/theme_controller.dart';
import 'package:manifest/core/services/share_service.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/downloaded_soundscapes_controller.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/services/affirmation_service.dart';
import 'package:manifest/core/services/collection_service.dart';
import 'package:manifest/core/services/firebase_notification_service.dart';
import 'package:manifest/core/services/notification_service.dart';
import 'package:manifest/core/services/permission_service.dart';
import 'package:manifest/core/services/playlist_service.dart';
import 'package:manifest/core/services/profile_service.dart';
import 'package:manifest/core/services/reminder_service.dart';
import 'package:manifest/core/services/soundscape_service.dart';
import 'package:manifest/core/services/storage_management_service.dart';
import 'package:manifest/core/services/track_service.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/scene_settings_bottomsheet.dart';
import 'package:manifest/features/create_account/creating_account_screen.dart';
import 'package:manifest/features/explore/controllers/explore_category_list_controller.dart';
import 'package:manifest/features/explore/controllers/expore_main_controller.dart';
import 'package:manifest/features/explore/controllers/playlist_details_controller.dart';
import 'package:manifest/features/media_player/controllers/media_player_controller.dart';
import 'package:manifest/features/media_player/controllers/media_player_loop_option_sheet_controller.dart';
import 'package:manifest/features/navbar/navbar_controller.dart';
import 'package:manifest/features/onboarding/controllers/on_boarding_controller.dart';
import 'package:manifest/features/onboarding/controllers/select_goals_preference_controller.dart';
import 'package:manifest/features/paywall/controllers/paywall_controller.dart';
import 'package:manifest/features/playlist/by_you/controllers/affirmation_list_controller.dart';
import 'package:manifest/features/playlist/by_you/controllers/audio_upload_controller.dart';
import 'package:manifest/features/playlist/by_you/controllers/by_you_by_alok_controller.dart';
import 'package:manifest/features/playlist/by_you/services/audio_service.dart';
import 'package:manifest/features/playlist/by_you/services/local_storage_service.dart';
import 'package:manifest/features/playlist/by_you/widgets/audio_player/audio_player_bottom_sheet_controller.dart';
import 'package:manifest/features/playlist/by_you/widgets/audio_player/audio_player_controller.dart';
import 'package:manifest/features/playlist/by_you/widgets/voice_recorder/voice_recorder_bottom_sheet_controller.dart';
import 'package:manifest/features/referral_program/controllers/gift_controller.dart';
import 'package:manifest/features/reminder/controllers/custom_reminder_controller.dart';
import 'package:manifest/features/reminder/controllers/default_reminder_controller.dart';
import 'package:manifest/features/reminder/controllers/reminders_list_controller.dart';
import 'package:manifest/features/reminder/controllers/set_reminder_intro_controller.dart';
import 'package:manifest/features/settings/models/profile_local_datasource.dart';
import 'package:manifest/features/soundscape/controllers/download_soundscape_controller.dart';
import 'package:manifest/features/soundscape/controllers/soundscape_controller.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/services/asset_preloader.dart';
import 'package:manifest/services/auth_services.dart';
import 'package:manifest/services/by_you_service.dart';
import 'package:manifest/core/services/explore_service.dart';
import 'package:manifest/view/navbar_screens/explore/explore_tabs/tracks_by_id_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/collection_audio_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/collection_detail_screen_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/my_collection_page_controller.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/hidden_affirmations_controller.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/liked_affirmations_controller.dart';

import '../core/services/settings_service.dart';

/// Helper class for managing critical resources that should be preloaded early
class ResourcePreloader {
  /// Preload critical assets before displaying the splash screen
  /// Returns a Future that completes when all critical assets are loaded
  static Future<void> preloadCriticalAssets() async {
    try {
      LogUtil.log('Starting critical asset preloading...');

      // Preload the splash screen video with highest priority
      await AssetPreloader.preloadAsset('assets/manifest-dark-splash.mp4');

      // Preload the dark star splash video
      await AssetPreloader.preloadAsset(
          'assets/manifest-dark-star-splash-small.mp4');

      // Start preloading the first onboarding video in the background
      // This continues in the background and doesn't block the splash screen
      AssetPreloader.preloadOnboardingVideos();

      LogUtil.log('Completed critical asset preloading');
    } catch (e) {
      LogUtil.log('Error preloading critical assets: $e');
      // Continue anyway - we don't want to block app startup
    }
  }
}

class DependencyInjection {
  static Future<void> init() async {
    // Preload critical assets
    await ResourcePreloader.preloadCriticalAssets();

    /// * data sources
    Get.put(ProfileLocalDataSource(), permanent: true);

    Get.put(ApiService(), permanent: true);
    Get.put<GetConnect>(GetConnect(), permanent: true);
    Get.put(LocalStorageService(), permanent: true);
    await Get.putAsync(
      () async {
        final f = FirebaseNotificationService();
        await f.init();
        return f;
      },
      permanent: true,
    );
    Get.put(PermissionService(), permanent: true);
    Get.put(ProfileService(Get.find<ProfileLocalDataSource>()),
        permanent: true);
        Get.put(SettingsService(), permanent: true);
    Get.put(NotificationService(), permanent: true);
    Get.put(
      AuthService(
        Get.find<ProfileService>(),
        Get.find<FirebaseNotificationService>(),
      ),
      permanent: true,
    );

    Get.put(
      ProfileController(Get.find<ProfileService>()),
      permanent: true,
    );
    Get.put(ThemeController(), permanent: true);
    Get.put(StorageManagementService(), permanent: true);
    Get.put(DownloadService(), permanent: true);
    Get.put(ShareService(), permanent: true);
    Get.put(ReminderService(), permanent: true);
    Get.put(AudioService(), permanent: true);
    Get.put(AffirmationService(), permanent: true);
    Get.put(PlaylistService(), permanent: true);
    Get.put(TrackService(), permanent: true);
    Get.put(CollectionService(), permanent: true);
    Get.put(ByYouService(), permanent: true);
    Get.put(ExploreService(), permanent: true);
    Get.put(SoundscapeService(), permanent: true);
    Get.put(
      DownloadSoundscapeController(),
      permanent: true,
    );

    Get.lazyPut(() => DownloadedSoundscapesController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => const CreatingAccountScreen(), fenix: true);
    Get.lazyPut(() => PaywallController(), fenix: true);
    Get.lazyPut(() => GiftController(), fenix: true);
    Get.lazyPut(() => SceneSettingsBottomsheetController(), fenix: true);

    /// * home bottom navbar

    /// * explore
    Get.lazyPut(
      () => ExploreMainController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ExploreCategoryListController(Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => ByYouByAlokController(
        storageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => NavbarController(),
      fenix: true,
    );
    Get.lazyPut(
      () => SoundscapeTabController(Get.find<SoundscapeService>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ExploreCategoriesController(Get.find<ByYouByAlokController>()),
      fenix: true,
    );

    Get.lazyPut(
      () => SelectGoalsPreferenceController(Get.find<ApiService>()),
      fenix: true,
    );

    Get.lazyPut(() => AudioRecorderController(), fenix: true);

    /// * @author: alok singh
    /// * @description: inject dependency for controllers
    Get.put(ExploreController());

    Get.lazyPut(
      () => AuthController(),
      fenix: true,
    );

    Get.lazyPut(
      () => AffirmationListController(
        audioService: Get.find<AudioService>(),
        storageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => HiddenAffirmationController(
        Get.find<AffirmationService>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => LikedAffirmationController(
        Get.find<AffirmationService>(),
      ),
      fenix: true,
    );

    /// * reminder
    Get.lazyPut(
      () => SetReminderIntroController(Get.find<ReminderService>()),
      fenix: true,
    );
    Get.lazyPut(
      () => RemindersListController(Get.find<ReminderService>()),
      fenix: true,
    );
    Get.lazyPut(
      () => CustomReminderController(Get.find<ReminderService>()),
      fenix: true,
    );
    Get.lazyPut(
      () => DefaultReminderController(Get.find<ReminderService>()),
      fenix: true,
    );

    Get.lazyPut(() => HomeTwoController(), fenix: true);

    Get.lazyPut(() => PlaylistTabController(), fenix: true);
    Get.lazyPut(() => DownloadMainPageController(), fenix: true);

    // * dependency for audio recorder
    Get.lazyPut(
      () => VoiceRecorderBottomSheetController(),
      fenix: true,
    );
    Get.lazyPut(
      () => AudioPlayerBottomSheetController(),
      fenix: true,
    );
    Get.lazyPut(
      () => AudioPlayerController(),
      fenix: true,
    );
    Get.lazyPut(
      () => AudioUploadController(),
      fenix: true,
    );

    /// * explore dependency injection
    Get.lazyPut(
      () => HomeMediaPlayerController(),
      fenix: true,
    );

    Get.lazyPut(
      () => TracksByIdController(Get.find<ApiService>()),
      fenix: true,
    );
    Get.lazyPut(
      () => PlaylistDetailsController(Get.find<ApiService>()),
      fenix: true,
    );
    Get.lazyPut(
      () => MediaPlayerController(
        Get.find<AffirmationService>(),
        Get.find<CollectionService>(),
        Get.find<PlaylistService>(),
        Get.find<TrackService>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => MyCollectionPageController(
        Get.find<CollectionService>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => CollectionDetailScreenController(
        Get.find<CollectionService>(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => MediaPlayerLoopOptionSheetController(),
      fenix: true,
    );

    // Make sure CollectionDetailScreenController is registered
    Get.lazyPut(() => CollectionDetailScreenController(Get.find()));

    // Initialize the CollectionAudioController with the RemoteAudioService
    Get.lazyPut(() => CollectionAudioController(), fenix: true);
  }

  //get device id
  final deviceInfo = DeviceInfoPlugin();
  String? deviceID;
  Future<void> getDeviceId() async {
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.id;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor;
    }
    LocalStorage.setDeviceID(deviceID.toString());
    LogUtil.v('device info: ${LocalStorage.deviceID}');
  }
}
