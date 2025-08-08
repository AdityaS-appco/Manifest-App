import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manifest/core/l10n/language_controller.dart';
import 'package:manifest/core/routes/route_config.dart';
import 'package:manifest/core/services/firebase_notification_service.dart';
import 'package:manifest/features/splash/splash_with_logo.dart';
import 'package:manifest/helper/import.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:fvp/fvp.dart';

Languages languages = Languages();

void main() async {
  /// * ensure initialization of flutter binding is done properly
  WidgetsFlutterBinding.ensureInitialized();

  /// * lock device orientation to portraitUp
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// * initialize get storage
  await GetStorage.init();

  /// * initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// * load translations
  await languages.loadTranslations();

  /// * inject dependencies
  await DependencyInjection.init();

  /// * get the device id
  await DependencyInjection().getDeviceId();

  /// * Set the log level for debugging purposes.
  /// * This helps in tracking issues by printing detailed logs in the console.
  await Purchases.setLogLevel(LogLevel.debug);

  /// * Configure RevenueCat with your API key.
  /// * This API key can be found in your RevenueCat dashboard under "Project Settings > API Keys".
  /// * It is required to connect your app with RevenueCat's backend.
  await Purchases.configure(
    PurchasesConfiguration(
        "goog_iQcgaBvsUhAbwhXSLThabeGAVno"), // Replace with your actual RevenueCat API key.
  );

  /// * initialize theme controller
  // Get.find<ThemeController>().init();

  /// * initialize fvp
  registerWith();

  /// * run app
  runApp(const MyApp());
  // runApp(DevicePreview(
  //   builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    String languageCode = LocalStorage.appLanguage;
    String countryCode = LocalStorage.selectedCountryCode;
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: languages,
          locale: Locale(languageCode, countryCode),
          fallbackLocale: const Locale('en', 'US'),
          defaultTransition: Transition.cupertino,
          useInheritedMediaQuery: true,
          title: 'Manifest',
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          themeMode: themeController.isDark ? ThemeMode.dark : ThemeMode.light,
          initialRoute: RouteConfig.splash,
          home: const SplashWithLogo(),
          getPages: RouteConfig.pages,
          // builder: (context, child) {
          //   child = EasyLoading.init()(context, child);

          //   // Configure EasyLoading
          //   EasyLoading.instance
          //     ..maskType = EasyLoadingMaskType.black
          //     ..userInteractions = false
          //     ..loadingStyle = EasyLoadingStyle.custom
          //     ..backgroundColor = Colors.transparent
          //     ..indicatorColor = Colors.white
          //     ..indicatorWidget = dotsWaveLoading()
          //     ..indicatorSize = 45.0;

          //   return child;
          // },
        );
      },
      // designSize: const Size(375,760),
      // // ! corrected the design size (@alok_singh)
      // designSize: const Size(375, 731),
      // ! corrected the design size (@alok_singh - 07/04/2025)
      designSize: const Size(393, 852),
    );
  }
}
