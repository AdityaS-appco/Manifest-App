import 'package:get/get.dart';
import 'package:manifest/features/explore/bindings/explore_binding.dart';
import 'package:manifest/features/explore/views/explore_main_screen.dart';
import 'package:manifest/features/splash/splash_with_logo.dart';

class RouteConfig {
  /// Route Names
  static const String splash = '/splash';
  static const String home = '/home';
  static const String exploreSubcategory = '/explore-subcategory';
  static const String audioPlayer = '/audio-player';
  static const String mySoundscape = '/my-soundscape';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String premiumUpgrade = '/premium-upgrade';

  /// GetPages for navigation
  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashWithLogo(),
    ),
    // GetPage(
    //   name: home,
    //   page: () => const HomePageByAlok(),
    //   // binding: HomeBinding(),
    // ),
    GetPage(
      name: exploreSubcategory,
      page: () => const ExploreMainScreen(),
      binding: ExploreBinding(),
    ),
    // GetPage(
    //   name: audioPlayer,
    //   page: () => const AudioPlayerScreen(),
    //   // binding: AudioPlayerBinding(),
    // ),
    // GetPage(
    //   name: mySoundscape,
    //   page: () => const MySoundscapeScreen(),
    //   // binding: MySoundscapeBinding(),
    // ),
    // GetPage(
    //   name: settings,
    //   page: () => const SettingsScreen(),
    //   binding: SettingsBinding(),
    // ),
    // GetPage(
    //   name: profile,
    //   page: () => const ProfileScreen(),
    //   binding: ProfileBinding(),
    // ),
    // GetPage(
    //   name: premiumUpgrade,
    //   page: () => const PremiumUpgradeScreen(),
    //   binding: PremiumUpgradeBinding(),
    // ),
  ];
}
