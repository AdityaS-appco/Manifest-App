import 'package:flutter/material.dart';

// ! author: @alok_singh

class AppColors {
  factory AppColors() => _instance;
  AppColors._internal();
  static final AppColors _instance = AppColors._internal();

  // app colors
  static Color primary = const Color(0xff7D70D1);

  static Color premiumTextColor = const Color(0xFFC6B3F9);

  // orange
  static Color lightOrange = const Color(0xffF4BAA2);
  static Color mediumOrange = const Color(0xffF1A282);

  // onboarding background color
  static Color onboardingBgColor = const Color(0xff04000E);

  // background
  static Color appBG = const Color(0xff04000E);
  static Color appBlueBG = const Color(0xff2875BC);
  static Color settingCardBG = const Color(0xff3A3A3C).withOpacity(0.6);
  static Color dashboardCardBG = const Color(0xff3A3A3C);
  static Color dialogBgColor = const Color(0xff3A3A3C);
  static Color closeButtonBgColor = const Color.fromRGBO(192, 193, 194, 0.5);
  static Color inActiveSliderBgColor =
      const Color.fromRGBO(122, 120, 128, 0.36);

  static Color textFieldFocusColor = const Color(0xFF814AFF).withOpacity(0.5);

  static Color grey = const Color(0xff707070);
  static Color mediumGrey = const Color(0xffBABABA);
  static Color lessImportantText = const Color(0xffEBEBF5).withOpacity(0.70);
  static Color lightGrey = const Color(0xffEBEBEB);
  static Color lightWhite = const Color(0xff7A7A7A).withOpacity(0.3);

  static Color checkButton = const Color.fromRGBO(15, 205, 125, 1);
  static Color cardColor = const Color(0xff39383A);

  static Color light = const Color(0xffffffff);
  static Color dark = Colors.black;

  static Color textFieldIconColor = Colors.grey.shade300;
  static Color textFieldBgColor = Colors.white.withOpacity(0.05);

  static Color descriptionColor = const Color.fromRGBO(235, 235, 245, 0.6);
  static Color descriptionLightColor = const Color.fromRGBO(235, 235, 245, 0.6);
  static Color descriptionDarkColor = const Color(0xffebebf5).withOpacity(0.60);

  static Color bottomSheetBgColor = const Color(0xFF252525);

  static const premiumDark = Color(0xFF814AFF);

  static Color notificationNotReadDot = const Color(0xFF5879FF);

  static Color inactiveTrackColor = const Color(0x5B7A7880);

  /// * recorder
  static Color recorderRed = const Color(0xffDC362E);

  /// * ios
  static Color iosBlue = const Color(0xff0A84FF);

  /// * chart - user dashboard
  static Color chartMorning = const Color(0xFFA7F6FF); // Represents the sun
  static Color chartAfternoon = const Color(0xFFFFB9FD); // Represents the sun setting
  static Color chartNight = const Color(0xFFFFEECD); // Represents the moon

  /// * text colors
  static Color gradientChipInactiveTextColor = const Color(0xFFEBEBF5);
  static Color gradientChipActiveTextColor = const Color(0xFFFFFFFF);

  static List<Color> rainbowGradient = [
    const Color(0xFF8AFCFE),
    const Color(0xFFBDABFA),
    const Color(0xFFE5A3D8),
    const Color(0xFFF3C8B4),
    const Color(0xFFDFDEBA),
    const Color(0xFFAEE8DE)
  ];

  static List<Color> premiumGradient = [
    const Color(0xFFDE7AF3),
    const Color(0xFFFFFFF9),
    const Color(0xFFDE7AF3),
    const Color(0xFF9E91E8),
    const Color(0xFF814AFF),
  ];

  static List<Color> purpleGradient = [
    const Color(0xFF4727C9),
    const Color(0xFFC5B0FF),
    const Color(0xFF4727C9),
  ];
  static List<Color> topLightToBottomDarkPurpleGradient = [
    const Color(0xFFC5B0FF),
    const Color(0xFF4727C9),
  ];

  static List<Color> screenOvalRainbowGradient = [
    const Color(0xFFBDABFA),
    const Color(0xFFE5A3D8),
    const Color(0xFFF3C8B4),
    const Color(0xFFDFDEBA),
  ];

  /// * Pastel Linear Gradient
  static List<Color> pastelLinearGradient = [
    const Color(0xFF8AFCFE), // Cyan
    const Color(0xFFBDABFA), // Light Purple
    const Color(0xFFE5A3D8), // Pink
    const Color(0xFFF3C8B4), // Peach
    const Color(0xFFDFDEBA), // Light Yellow
    const Color(0xFFAEE8DE), // Mint
  ];

  /// * Blue Linear Gradient
  static List<Color> blueLinearGradient = [
    const Color(0xFF0000FF), // Deep Blue
    const Color(0xFF0054FF), // Medium Blue
    const Color(0xFF00A2FF), // Light Blue
    const Color(0xFF00F0FF), // Cyan
    const Color(0xFF00FFAA), // Turquoise
    const Color(0xFF00FF44), // Green
  ];

  /// * Pink Linear Gradient
  static List<Color> pinkLinearGradient = [
    const Color(0xFF9EF8F9), // Light Cyan
    const Color(0xFFB7CEFF), // Light Blue
    const Color(0xFFE8A9FF), // Light Pink
    const Color(0xFFF8BFED), // Pink
    const Color(0xFFEDB5BB), // Light Rose
    const Color(0xFFC6A777), // Rose Gold
  ];

  /// * Custom Linear Gradient
  static List<Color> customLinearGradient = [
    const Color(0xFFFFA883), // Light Orange
    const Color(0xFFFFC490), // Light Peach
    const Color(0xFFE3EE84), // Light Yellow
    const Color(0xFF9AFB83), // Light Green
    const Color(0xFFA0EBDC), // Light Cyan
    const Color(0xFF65C8EF), // Light Blue
  ];

  /// * Instagram Gradient Colors
  static List<Color> instagramGradient = [
    const Color(0xFFFE8D00), // Orange
    const Color(0xFFFF1F38), // Red
    const Color(0xFFF10097), // Pink
    const Color(0xFFB404F1), // Purple
  ];

  /// * Music Gradient Colors
  static List<Color> musicGradient = [
    const Color.fromRGBO(255, 255, 255, 0.1),
    const Color.fromRGBO(153, 153, 153, 0.1),
  ];

  static List<Color> musicPlayerBackgroundGradient = [
    const Color.fromRGBO(0, 0, 0, 0.4),
    const Color.fromRGBO(0, 0, 0, 0.05),
    const Color.fromRGBO(0, 0, 0, 0.0),
    const Color.fromRGBO(0, 0, 0, 0.0),
    const Color.fromRGBO(0, 0, 0, 0.05),
    const Color.fromRGBO(0, 0, 0, 0.4),
  ];

  static LinearGradient grayToGray = LinearGradient(
    colors: [Colors.grey.shade900, Colors.grey.shade700],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomRight,
    colors: [
      Colors.grey.shade900,
      const Color.fromRGBO(140, 90, 128, 20.0), // Purple with 0.6 opacity
      Colors.grey.shade900, // This will create a fade effect
    ],
  );

  /// * send suggestions
  /// ! Linear gradient for orange highlight (see design reference)
  static const Color orangeHighlightGradientStart = Color(0xFFFF6666);
  static const Color orangeHighlightGradientEnd = Color(0xFFFF8B66);

  static const List<Color> orangeHighlightGradientColors = [
    orangeHighlightGradientStart,
    orangeHighlightGradientEnd,
  ];

  /// * purple highlight gradient
  /// ! Linear gradient for purple highlight (see design reference)
  static const Color purpleHighlightGradientStart = Color(0xFFB266FF);
  static const Color purpleHighlightGradientEnd = Color(0xFF6966FF);

  static const List<Color> purpleHighlightGradientColors = [
    purpleHighlightGradientStart,
    purpleHighlightGradientEnd,
  ];

  /// * cyan highlight gradient
  /// ! Linear gradient for cyan highlight (see design reference)
  static const Color cyanHighlightGradientStart = Color(0xFF66FFBF);
  static const Color cyanHighlightGradientEnd = Color(0xFF66E3FF);

  static const List<Color> cyanHighlightGradientColors = [
    cyanHighlightGradientStart,
    cyanHighlightGradientEnd,
  ];

  /// * yellow highlight gradient
  /// ! Linear gradient for yellow highlight (see design reference)
  static const Color yellowHighlightGradientStart = Color(0xFFFFF066);
  static const Color yellowHighlightGradientEnd = Color(0xFFFFD466);

  static const List<Color> yellowHighlightGradientColors = [
    yellowHighlightGradientStart,
    yellowHighlightGradientEnd,
  ];

  /// * green highlight gradient
  /// ! Linear gradient for green highlight (see design reference, #8EFF66 to #66FF75)
  static const Color greenHighlightGradientStart = Color(0xFF8EFF66);
  static const Color greenHighlightGradientEnd = Color(0xFF66FF75);

  static const List<Color> greenHighlightGradientColors = [
    greenHighlightGradientStart,
    greenHighlightGradientEnd,
  ];

  /// * purple highlight gradient
  /// ! Linear gradient for purple highlight (#C3B4FF to #3E44E4, see design reference)
  static const Color purpleLightHighlightGradientStart = Color(0xFFC3B4FF);
  static const Color purpleLightHighlightGradientEnd = Color(0xFF3E44E4);

  static const List<Color> purpleLightHighlightGradientColors = [
    purpleLightHighlightGradientStart,
    purpleLightHighlightGradientEnd,
  ];

  /// * Specific Color Constants
  // Pastel Colors
  static const Color pastelCyan = Color(0xFF8AFCFE);
  static const Color pastelPurple = Color(0xFFBDABFA);
  static const Color pastelPink = Color(0xFFE5A3D8);
  static const Color pastelPeach = Color(0xFFF3C8B4);
  static const Color pastelYellow = Color(0xFFDFDEBA);
  static const Color pastelMint = Color(0xFFAEE8DE);

  // Blue Colors
  static const Color deepBlue = Color(0xFF0000FF);
  static const Color mediumBlue = Color(0xFF0054FF);
  static const Color lightBlue = Color(0xFF00A2FF);
  static const Color brightCyan = Color(0xFF00F0FF);
  static const Color turquoise = Color(0xFF00FFAA);
  static const Color brightGreen = Color(0xFF00FF44);

  // Pink Colors
  static const Color lightCyan = Color(0xFF9EF8F9);
  static const Color softBlue = Color(0xFFB7CEFF);
  static const Color softPink = Color(0xFFE8A9FF);
  static const Color mediumPink = Color(0xFFF8BFED);
  static const Color lightRose = Color(0xFFEDB5BB);
  static const Color roseGold = Color(0xFFC6A777);

  // Warm Colors
  static const Color warmOrange = Color(0xFFFFA883);
  static const Color lightPeach = Color(0xFFFFC490);
  static const Color lightYellow = Color(0xFFE3EE84);
  static const Color lightGreen = Color(0xFF9AFB83);
  static const Color lightCyanBlue = Color(0xFFA0EBDC);
  static const Color skyBlue = Color(0xFF65C8EF);

  static const Color success = Color(0xFF0FCD7D);
  static const Color error = Color(0xFFFF6B51);
  static const Color danger = Color(0xFFFF5C5C);
  static const Color info = Color(0xFF4E60FF);
  static const Color warning = Color(0xFFFFA54E);
}
