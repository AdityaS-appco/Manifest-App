import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_fonts.dart';

class AppTypography {
  // Base method for creating text styles
  static TextStyle createTextStyle({
    required AppFonts font,
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    List<Shadow>? shadows,
    bool useResponsive = true,
  }) {
    return TextStyle(
      fontFamily: font.name,
      fontSize: useResponsive ? fontSize.sp : fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      shadows: shadows,
    );
  }

  // Font family convenience methods
  static TextStyle tanMemories({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    List<Shadow>? shadows,
    bool useResponsive = true,
  }) {
    return createTextStyle(
      font: AppFonts.tanMemories,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      shadows: shadows,
      useResponsive: useResponsive,
    );
  }

  static TextStyle breeSerif({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    List<Shadow>? shadows,
    bool useResponsive = true,
  }) {
    return createTextStyle(
      font: AppFonts.breeSerif,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      shadows: shadows,
      useResponsive: useResponsive,
    );
  }

  static TextStyle helvetica({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    List<Shadow>? shadows,
    bool useResponsive = true,
  }) {
    return createTextStyle(
      font: AppFonts.helvetica,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      shadows: shadows,
      useResponsive: useResponsive,
    );
  }

  static TextStyle helveticaRounded({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    List<Shadow>? shadows,
    bool useResponsive = true,
  }) {
    return createTextStyle(
      font: AppFonts.helveticaRounded,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      shadows: shadows,
      useResponsive: useResponsive,
    );
  }

  static TextStyle pacifico({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    List<Shadow>? shadows,
    bool useResponsive = true,
  }) {
    return createTextStyle(
      font: AppFonts.pacifico,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      shadows: shadows,
      useResponsive: useResponsive,
    );
  }

  /// * Display styles
  static TextStyle get displayLarge => helveticaRounded(
          fontSize: 56,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0,
          shadows: [
            Shadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: const Color(0xFF000000).withOpacity(0.25))
          ]);

  static TextStyle get displayMedium => tanMemories(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get displaySmall => tanMemories(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      );

  /// * Heading styles
  static TextStyle get headingLargeRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );
  static TextStyle get headingLarge => helvetica(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );
  static TextStyle get headingMediumRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );
  static TextStyle get headingMedium => helvetica(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );
  static TextStyle get headingSmallRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );
  static TextStyle get headingSmall => helvetica(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );
  static TextStyle get headingExtraSmallRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );
  static TextStyle get headingExtraSmall => helvetica(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.5,
      );

  static TextStyle get glowingHeadingMediumRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.5,
        letterSpacing: -0.32,
        shadows: [
          Shadow(
            offset: const Offset(0, 0),
            blurRadius: 20,
            color: const Color(0xFFFFFFFF).withOpacity(0.40),
          )
        ],
      );

  static TextStyle get titleLargeRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1,
      );
  static TextStyle get titleLarge => helvetica(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1,
      );

  static TextStyle get titleMediumRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.50,
      );
  static TextStyle get titleMedium => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.50,
      );

  static TextStyle get titleSmallRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      );
  static TextStyle get titleSmall => helvetica(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      );

  static TextStyle get titleExtraSmallRounded => helveticaRounded(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      );
  static TextStyle get titleExtraSmall => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      );

  static TextStyle get soundscapePreviewTitle => pacifico(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
        height: 0.8,
        letterSpacing: -0.4,
      );
  static TextStyle get soundscapePreviewHeading => helveticaRounded(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -0.40,
      );

  /// * Subtitle styles [large, medium, small]
  static TextStyle get subtitleLarge => helvetica(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );
  static TextStyle get subtitleMedium => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );
  static TextStyle get subtitleSmall => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );
  static TextStyle get subtitleLargeRounded => helveticaRounded(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );
  static TextStyle get subtitleMediumRounded => helveticaRounded(
        color: Colors.white.withAlpha(204),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );
  static TextStyle get subtitleSmallRounded => helveticaRounded(
        color: Colors.white.withAlpha(204),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );

  /// * Body styles
  static TextStyle get bodyLarge => helvetica(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyMedium => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  static TextStyle get bodySmall => helvetica(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodyTiny => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 10,
        fontWeight: FontWeight.w400,
      );

  /// * Button text
  static TextStyle get socialButtonText => helvetica(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );
  static TextStyle get buttonText => helvetica(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );

  static TextStyle get buttonInactiveText => helvetica(
        color: Colors.white.withAlpha(51),
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );
  static TextStyle get buttonSmallText => helvetica(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1,
      );
  static TextStyle get blurOverlayButtonText => helvetica(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.20,
      );

  static TextStyle get gradientButtonTextSmall => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1,
      );

  static TextStyle get onboardingTitle => helveticaRounded(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.20,
        shadows: [
          Shadow(
            offset: const Offset(0, 0),
            blurRadius: 20,
            color: const Color(0xFFFFFFFF).withOpacity(0.40),
          )
        ],
      );

  static TextStyle get onboardingSubtitle => helvetica(
        color: Colors.white.withOpacity(0.8),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.36,
        letterSpacing: -0.40,
      );

  /// * Caption text
  static TextStyle get captionTextLarge => helveticaRounded(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.12,
        letterSpacing: -0.32,
      );
  static TextStyle get captionTextSmall => helvetica(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.32,
      );

  /// * Dialog
  static TextStyle get dialogTitle => tanMemories(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.64,
      );
  static TextStyle get dialogSubtitle => helvetica(
        color: Colors.white.withAlpha(128),
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.53,
        letterSpacing: -0.32,
      );
  static TextStyle get dialogButtonText => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );
  static TextStyle get dialogExtraSmallTitle => helvetica(
        color: const Color(0xFFC2C2C2),
        fontSize: 13,
        fontWeight: FontWeight.w700,
        height: 1.38,
        letterSpacing: -0.40,
      );

  /// * Bottomsheet
  static TextStyle get bottomsheetTitle => helveticaRounded(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -0.32,
      );
  static TextStyle get bottomsheetSubtitle => helvetica(
        color: const Color(0x99EBEBF5),
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1,
      );

  /// * Notification tile
  static TextStyle get notificationTileTitle => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );

  static TextStyle get notificationTileSubtitle => helvetica(
        color: Colors.white.withAlpha(128),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1,
      );

  /// * Notification detail
  static TextStyle get notificationDetailTitle => tanMemories(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );
  static TextStyle get notificationDetailBody => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );

  /// * Search bar
  static TextStyle get searchBarHintText => helvetica(
        color: Colors.white.withAlpha(128),
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.40,
      );
  static TextStyle get searchBarText => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.40,
      );

  /// * Tab styles
  static TextStyle get tabLargeActive => helveticaRounded(
        color: Colors.white,
        fontSize: 19,
        fontWeight: FontWeight.w700,
        height: 1.32,
      );

  static TextStyle get tabLargeInactive => helveticaRounded(
        color: Colors.white.withAlpha(128),
        fontSize: 19,
        fontWeight: FontWeight.w700,
        height: 1.32,
      );

  static TextStyle get tabMediumActive => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.56,
      );
  static TextStyle get tabMediumInactive => helvetica(
        color: Colors.white.withAlpha(128),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.56,
      );

  static TextStyle get tabSmallActive => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -0.28,
      );
  static TextStyle get tabSmallInactive => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.28,
      );

  /// * content card styles
  static TextStyle get contentCardTitle => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -0.32,
      );
  static TextStyle get contentCardSubtitle => helvetica(
        color: Colors.white.withAlpha(102),
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.32,
      );

  /// * content tile styles
  static TextStyle get contentTileTitleSmall => helvetica(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.40,
        letterSpacing: -0.40,
      );
  static TextStyle get contentTileSubtitleSmall => helvetica(
        color: const Color(0x99EBEBF5),
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.18,
        letterSpacing: -0.40,
      );
  static TextStyle get contentTileTitleMedium => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.31,
        letterSpacing: -0.40,
      );
  static TextStyle get contentTileSubtitleMedium => helvetica(
        color: const Color(0x99EBEBF5),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: -0.40,
      );
  static TextStyle get contentTileTitleLarge => helvetica(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.29,
        letterSpacing: -0.40,
      );
  static TextStyle get contentTileSubtitleLarge => helvetica(
        color: const Color(0x99EBEBF5),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: -0.40,
      );

  /// * tile with icon styles
  static TextStyle get tileWithIconTitle => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.38,
      );

  /// * pill tab styles
  static TextStyle get pillActiveTabTextSmall => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1,
      );
  static TextStyle get pillInactiveTabTextSmall => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1,
      );
  static TextStyle get pillActiveTabTextMedium => helvetica(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );
  static TextStyle get pillInactiveTabTextMedium => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );
  static TextStyle get pillActiveTabTextLarge => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.31,
      );
  static TextStyle get pillInactiveTabTextLarge => helvetica(
        color: Colors.white.withAlpha(153),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.31,
      );

  /// * gradient tab styles
  static TextStyle get gradientActiveTabTextSmall => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.29,
      );
  static TextStyle get gradientActiveTabTextLarge => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -0.32,
      );
  static TextStyle get gradientInactiveTabTextSmall => helvetica(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.29,
      );
  static TextStyle get gradientInactiveTabTextLarge => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.32,
      );

  /// * Empty state text
  static TextStyle get emptyStateText => helvetica(
        color: Colors.white.withAlpha(204),
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.75,
      );

  /// * Home
  static TextStyle get homeHeaderButtonWithIconText => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.32,
      );

  /// * Home greeting text
  static TextStyle get homeGreetingText => helveticaRounded(
        color: Colors.white.withAlpha(178),
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -0.32,
      );

  /// * Manifest plus home banner
  static TextStyle get manifestPlusHomeBannerSubtitle => helvetica(
        color: Colors.white.withAlpha(178),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: -0.40,
      );

  static TextStyle get manifestPlusHomeBannerButtonText => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -0.32,
      );

  /// * bottom player
  static TextStyle get bottomPlayerTitle => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.31,
        letterSpacing: -0.40,
      );
  static TextStyle get bottomPlayerSubtitle => helvetica(
        color: const Color(0x4CEBEBF5),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: -0.40,
      );

  /// * page styles
  static TextStyle get pageTitle => helveticaRounded(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.29,
      );
  static TextStyle get pageSubtitle => helvetica(
        color: Colors.white.withAlpha(153),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.57,
      );

  /// * glowing text styles
  static TextStyle get glowingPageTitle => helveticaRounded(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.29,
      );

  /// * text field styles
  static TextStyle get textFieldTitle => helvetica(
        color: const Color(0x99EBEBF5),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.25,
      );
  static TextStyle get textFieldHintText => helvetica(
        color: const Color(0x7FEBEBF5),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.25,
      );
  static TextStyle get textFieldText => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.25,
      );

  /// * chip styles
  static TextStyle get chipTextLarge => helvetica(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );
  static TextStyle get chipTextlargeCompressed => helvetica(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.29,
      );

  // static TextStyle get chipTextMedium => ;

  // static TextStyle get chipTextSmall => ;

  // login/signup phrase styles
  static TextStyle get loginPhrase => helvetica(
        color: Colors.white.withAlpha(153),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.25,
      );

  static TextStyle get loginPhraseBold => helvetica(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );
  static TextStyle get iosSurveyFormOptionText => helvetica(
        color: const Color(0xFF0A84FF),
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.29,
        letterSpacing: -0.40,
      );

  static TextStyle get settingFooterText => helvetica(
        color: const Color(0x99EBEBF5),
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.38,
        letterSpacing: -0.40,
      );
  static TextStyle get gradientChipText => helvetica(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        shadows: [
          Shadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: const Color(0xFF000000).withOpacity(0.10))
        ],
      );
}
