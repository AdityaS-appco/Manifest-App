import 'package:flutter/material.dart';
import 'app_typography.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  // Display styles
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;

  // Title styles
  final TextStyle titleLargeRounded;
  final TextStyle titleLarge;
  final TextStyle titleMediumRounded;
  final TextStyle titleMedium;
  final TextStyle titleSmallRounded;
  final TextStyle titleSmall;
  final TextStyle titleExtraSmallRounded;
  final TextStyle titleExtraSmall;

  // Heading styles
  final TextStyle headingLargeRounded;
  final TextStyle headingLarge;
  final TextStyle glowingHeadingMediumRounded;
  final TextStyle headingMediumRounded;
  final TextStyle headingMedium;
  final TextStyle headingSmallRounded;
  final TextStyle headingSmall;
  final TextStyle headingExtraSmallRounded;
  final TextStyle headingExtraSmall;

  // Subtitle styles
  final TextStyle subtitleLarge;
  final TextStyle subtitleLargeRounded;
  final TextStyle subtitleMedium;
  final TextStyle subtitleMediumRounded;
  final TextStyle subtitleSmall;
  final TextStyle subtitleSmallRounded;

  // Body styles
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle bodyTiny;

  // Button styles
  final TextStyle socialButtonText;
  final TextStyle buttonText;
  final TextStyle buttonInactiveText;
  final TextStyle buttonSmallText;
  final TextStyle blurOverlayButtonText;
  final TextStyle gradientButtonTextSmall;

  // onboarding styles
  final TextStyle onboardingTitle;
  final TextStyle onboardingSubtitle;

  // Caption styles
  final TextStyle captionTextLarge;
  final TextStyle captionTextSmall;

  // Dialog styles
  final TextStyle dialogTitle;
  final TextStyle dialogSubtitle;
  final TextStyle dialogButtonText;
  final TextStyle dialogExtraSmallTitle;

  // Bottom sheet styles
  final TextStyle bottomsheetTitle;
  final TextStyle bottomsheetSubtitle;

  // Notification styles
  final TextStyle notificationTileTitle;
  final TextStyle notificationTileSubtitle;
  final TextStyle notificationDetailTitle;
  final TextStyle notificationDetailBody;

  // Search bar styles
  final TextStyle searchBarHintText;
  final TextStyle searchBarText;

  // Tab styles
  final TextStyle tabLargeActive;
  final TextStyle tabLargeInactive;
  final TextStyle tabMediumActive;
  final TextStyle tabMediumInactive;
  final TextStyle tabSmallActive;
  final TextStyle tabSmallInactive;

  // Content styles
  final TextStyle contentCardTitle;
  final TextStyle contentCardSubtitle;
  final TextStyle contentTileTitleSmall;
  final TextStyle contentTileSubtitleSmall;
  final TextStyle contentTileTitleMedium;
  final TextStyle contentTileSubtitleMedium;
  final TextStyle contentTileTitleLarge;
  final TextStyle contentTileSubtitleLarge;
  final TextStyle tileWithIconTitle;

  // Pill tab styles
  final TextStyle pillActiveTabTextSmall;
  final TextStyle pillInactiveTabTextSmall;
  final TextStyle pillActiveTabTextMedium;
  final TextStyle pillInactiveTabTextMedium;
  final TextStyle pillActiveTabTextLarge;
  final TextStyle pillInactiveTabTextLarge;

  // Gradient tab styles
  final TextStyle gradientActiveTabTextSmall;
  final TextStyle gradientActiveTabTextLarge;
  final TextStyle gradientInactiveTabTextSmall;
  final TextStyle gradientInactiveTabTextLarge;

  // Empty state styles
  final TextStyle emptyStateText;

  // Home styles
  final TextStyle homeHeaderButtonWithIconText;
  final TextStyle homeGreetingText;
  final TextStyle manifestPlusHomeBannerSubtitle;
  final TextStyle manifestPlusHomeBannerButtonText;

  // Player styles
  final TextStyle bottomPlayerTitle;
  final TextStyle bottomPlayerSubtitle;

  // page styles
  final TextStyle pageTitle;
  final TextStyle pageSubtitle;

  // glowing text styles
  final TextStyle glowingPageTitle;

  // text field styles
  final TextStyle textFieldTitle;
  final TextStyle textFieldHintText;
  final TextStyle textFieldText;

  // chip styles
  final TextStyle chipTextLarge;
  final TextStyle chipTextlargeCompressed;

  // login/signup phrase styles
  final TextStyle loginPhrase;
  final TextStyle loginPhraseBold;
  final TextStyle iosSurveyFormOptionText;
  final TextStyle soundscapePreviewTitle;
  final TextStyle soundscapePreviewHeading;
  final TextStyle settingFooterText;
  final TextStyle gradientChipText;

  AppTextTheme({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.titleLargeRounded,
    required this.titleLarge,
    required this.titleMediumRounded,
    required this.titleMedium,
    required this.titleSmallRounded,
    required this.titleSmall,
    required this.titleExtraSmallRounded,
    required this.titleExtraSmall,
    required this.headingLargeRounded,
    required this.headingLarge,
    required this.glowingHeadingMediumRounded,
    required this.headingMediumRounded,
    required this.headingMedium,
    required this.headingExtraSmallRounded,
    required this.headingExtraSmall,
    required this.headingSmallRounded,
    required this.headingSmall,
    required this.subtitleLarge,
    required this.subtitleLargeRounded,
    required this.subtitleMedium,
    required this.subtitleMediumRounded,
    required this.subtitleSmall,
    required this.subtitleSmallRounded,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.bodyTiny,
    required this.socialButtonText,
    required this.buttonText,
    required this.buttonInactiveText,
    required this.buttonSmallText,
    required this.blurOverlayButtonText,
    required this.gradientButtonTextSmall,
    required this.onboardingTitle,
    required this.onboardingSubtitle,
    required this.captionTextLarge,
    required this.captionTextSmall,
    required this.dialogTitle,
    required this.dialogSubtitle,
    required this.dialogButtonText,
    required this.dialogExtraSmallTitle,
    required this.bottomsheetTitle,
    required this.bottomsheetSubtitle,
    required this.notificationTileTitle,
    required this.notificationTileSubtitle,
    required this.notificationDetailTitle,
    required this.notificationDetailBody,
    required this.searchBarHintText,
    required this.searchBarText,
    required this.tabLargeActive,
    required this.tabLargeInactive,
    required this.tabMediumActive,
    required this.tabMediumInactive,
    required this.tabSmallActive,
    required this.tabSmallInactive,
    required this.contentCardTitle,
    required this.contentCardSubtitle,
    required this.contentTileTitleSmall,
    required this.contentTileSubtitleSmall,
    required this.contentTileTitleMedium,
    required this.contentTileSubtitleMedium,
    required this.contentTileTitleLarge,
    required this.contentTileSubtitleLarge,
    required this.tileWithIconTitle,
    required this.pillActiveTabTextSmall,
    required this.pillInactiveTabTextSmall,
    required this.pillActiveTabTextMedium,
    required this.pillInactiveTabTextMedium,
    required this.pillActiveTabTextLarge,
    required this.pillInactiveTabTextLarge,
    required this.gradientActiveTabTextSmall,
    required this.gradientActiveTabTextLarge,
    required this.gradientInactiveTabTextSmall,
    required this.gradientInactiveTabTextLarge,
    required this.emptyStateText,
    required this.homeHeaderButtonWithIconText,
    required this.homeGreetingText,
    required this.manifestPlusHomeBannerSubtitle,
    required this.manifestPlusHomeBannerButtonText,
    required this.bottomPlayerTitle,
    required this.bottomPlayerSubtitle,
    required this.pageTitle,
    required this.pageSubtitle,
    required this.glowingPageTitle,
    required this.textFieldTitle,
    required this.textFieldHintText,
    required this.textFieldText,
    required this.chipTextLarge,
    required this.chipTextlargeCompressed,
    required this.loginPhrase,
    required this.loginPhraseBold,
    required this.iosSurveyFormOptionText,
    required this.soundscapePreviewTitle,
    required this.soundscapePreviewHeading,
    required this.settingFooterText,
    required this.gradientChipText,
  });

  // Dark theme (default for your app)
  factory AppTextTheme.dark() {
    return AppTextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      titleLargeRounded: AppTypography.titleLargeRounded,
      titleLarge: AppTypography.titleLarge,
      titleMediumRounded: AppTypography.titleMediumRounded,
      titleMedium: AppTypography.titleMedium,
      titleSmallRounded: AppTypography.titleSmallRounded,
      titleSmall: AppTypography.titleSmall,
      titleExtraSmallRounded: AppTypography.titleExtraSmallRounded,
      titleExtraSmall: AppTypography.titleExtraSmall,
      headingLargeRounded: AppTypography.headingLargeRounded,
      headingLarge: AppTypography.headingLarge,
      glowingHeadingMediumRounded: AppTypography.glowingHeadingMediumRounded,
      headingMediumRounded: AppTypography.headingMediumRounded,
      headingMedium: AppTypography.headingMedium,
      headingSmallRounded: AppTypography.headingSmallRounded,
      headingSmall: AppTypography.headingSmall,
      headingExtraSmallRounded: AppTypography.headingExtraSmallRounded,
      headingExtraSmall: AppTypography.headingExtraSmall,
      subtitleLarge: AppTypography.subtitleLarge,
      subtitleLargeRounded: AppTypography.subtitleLargeRounded,
      subtitleMedium: AppTypography.subtitleMedium,
      subtitleMediumRounded: AppTypography.subtitleMediumRounded,
      subtitleSmall: AppTypography.subtitleSmall,
      subtitleSmallRounded: AppTypography.subtitleSmallRounded,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      bodyTiny: AppTypography.bodyTiny,
      socialButtonText: AppTypography.socialButtonText,
      buttonText: AppTypography.buttonText,
      buttonInactiveText: AppTypography.buttonInactiveText,
      buttonSmallText: AppTypography.buttonSmallText,
      blurOverlayButtonText: AppTypography.blurOverlayButtonText,
      gradientButtonTextSmall: AppTypography.gradientButtonTextSmall,
      onboardingTitle: AppTypography.onboardingTitle,
      onboardingSubtitle: AppTypography.onboardingSubtitle,
      captionTextLarge: AppTypography.captionTextLarge,
      captionTextSmall: AppTypography.captionTextSmall,
      dialogTitle: AppTypography.dialogTitle,
      dialogSubtitle: AppTypography.dialogSubtitle,
      dialogButtonText: AppTypography.dialogButtonText,
      dialogExtraSmallTitle: AppTypography.dialogExtraSmallTitle,
      bottomsheetTitle: AppTypography.bottomsheetTitle,
      bottomsheetSubtitle: AppTypography.bottomsheetSubtitle,
      notificationTileTitle: AppTypography.notificationTileTitle,
      notificationTileSubtitle: AppTypography.notificationTileSubtitle,
      notificationDetailTitle: AppTypography.notificationDetailTitle,
      notificationDetailBody: AppTypography.notificationDetailBody,
      searchBarHintText: AppTypography.searchBarHintText,
      searchBarText: AppTypography.searchBarText,
      tabLargeActive: AppTypography.tabLargeActive,
      tabLargeInactive: AppTypography.tabLargeInactive,
      tabMediumActive: AppTypography.tabMediumActive,
      tabMediumInactive: AppTypography.tabMediumInactive,
      tabSmallActive: AppTypography.tabSmallActive,
      tabSmallInactive: AppTypography.tabSmallInactive,
      contentCardTitle: AppTypography.contentCardTitle,
      contentCardSubtitle: AppTypography.contentCardSubtitle,
      contentTileTitleSmall: AppTypography.contentTileTitleSmall,
      contentTileSubtitleSmall: AppTypography.contentTileSubtitleSmall,
      contentTileTitleMedium: AppTypography.contentTileTitleMedium,
      contentTileSubtitleMedium: AppTypography.contentTileSubtitleMedium,
      contentTileTitleLarge: AppTypography.contentTileTitleLarge,
      contentTileSubtitleLarge: AppTypography.contentTileSubtitleLarge,
      tileWithIconTitle: AppTypography.tileWithIconTitle,
      pillActiveTabTextSmall: AppTypography.pillActiveTabTextSmall,
      pillActiveTabTextMedium: AppTypography.pillActiveTabTextMedium,
      pillInactiveTabTextSmall: AppTypography.pillInactiveTabTextSmall,
      pillInactiveTabTextMedium: AppTypography.pillInactiveTabTextMedium,
      pillActiveTabTextLarge: AppTypography.pillActiveTabTextLarge,
      pillInactiveTabTextLarge: AppTypography.pillInactiveTabTextLarge,
      gradientActiveTabTextSmall: AppTypography.gradientActiveTabTextSmall,
      gradientActiveTabTextLarge: AppTypography.gradientActiveTabTextLarge,
      gradientInactiveTabTextSmall: AppTypography.gradientInactiveTabTextSmall,
      gradientInactiveTabTextLarge: AppTypography.gradientInactiveTabTextLarge,
      emptyStateText: AppTypography.emptyStateText,
      homeHeaderButtonWithIconText: AppTypography.homeHeaderButtonWithIconText,
      homeGreetingText: AppTypography.homeGreetingText,
      manifestPlusHomeBannerSubtitle:
          AppTypography.manifestPlusHomeBannerSubtitle,
      manifestPlusHomeBannerButtonText:
          AppTypography.manifestPlusHomeBannerButtonText,
      bottomPlayerTitle: AppTypography.bottomPlayerTitle,
      bottomPlayerSubtitle: AppTypography.bottomPlayerSubtitle,
      glowingPageTitle: AppTypography.glowingPageTitle,
      pageTitle: AppTypography.pageTitle,
      pageSubtitle: AppTypography.pageSubtitle,
      textFieldTitle: AppTypography.textFieldTitle,
      textFieldHintText: AppTypography.textFieldHintText,
      textFieldText: AppTypography.textFieldText,
      chipTextLarge: AppTypography.chipTextLarge,
      chipTextlargeCompressed: AppTypography.chipTextlargeCompressed,
      loginPhrase: AppTypography.loginPhrase,
      loginPhraseBold: AppTypography.loginPhraseBold,
      iosSurveyFormOptionText: AppTypography.iosSurveyFormOptionText,
      soundscapePreviewTitle: AppTypography.soundscapePreviewTitle,
      soundscapePreviewHeading: AppTypography.soundscapePreviewHeading,
      settingFooterText: AppTypography.settingFooterText,
      gradientChipText: AppTypography.gradientChipText,
    );
  }

  // Light theme variant
  factory AppTextTheme.light() {
    return AppTextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: Colors.black),
      displayMedium: AppTypography.displayMedium.copyWith(color: Colors.black),
      displaySmall: AppTypography.displaySmall.copyWith(color: Colors.black),
      titleLargeRounded:
          AppTypography.titleLargeRounded.copyWith(color: Colors.black),
      titleLarge: AppTypography.titleLarge.copyWith(color: Colors.black),
      titleMediumRounded:
          AppTypography.titleMediumRounded.copyWith(color: Colors.black),
      titleMedium: AppTypography.titleMedium.copyWith(color: Colors.black),
      titleSmallRounded:
          AppTypography.titleSmallRounded.copyWith(color: Colors.black),
      titleSmall: AppTypography.titleSmall.copyWith(color: Colors.black),
      titleExtraSmallRounded:
          AppTypography.titleExtraSmallRounded.copyWith(color: Colors.black),
      titleExtraSmall:
          AppTypography.titleExtraSmall.copyWith(color: Colors.black),
      headingLargeRounded:
          AppTypography.headingLargeRounded.copyWith(color: Colors.black),
      headingLarge: AppTypography.headingLarge.copyWith(color: Colors.black),
      glowingHeadingMediumRounded: AppTypography.glowingHeadingMediumRounded
          .copyWith(color: Colors.black),
      headingMediumRounded:
          AppTypography.headingMediumRounded.copyWith(color: Colors.black),
      headingMedium: AppTypography.headingMedium.copyWith(color: Colors.black),
      headingSmallRounded:
          AppTypography.headingSmallRounded.copyWith(color: Colors.black),
      headingSmall: AppTypography.headingSmall.copyWith(color: Colors.black),
      headingExtraSmallRounded:
          AppTypography.headingExtraSmallRounded.copyWith(color: Colors.black),
      headingExtraSmall:
          AppTypography.headingExtraSmall.copyWith(color: Colors.black),
      subtitleLarge: AppTypography.subtitleLarge.copyWith(color: Colors.black),
      subtitleLargeRounded:
          AppTypography.subtitleLargeRounded.copyWith(color: Colors.black),
      subtitleMedium:
          AppTypography.subtitleMedium.copyWith(color: Colors.black),
      subtitleMediumRounded:
          AppTypography.subtitleMediumRounded.copyWith(color: Colors.black),
      subtitleSmall: AppTypography.subtitleSmall.copyWith(color: Colors.black),
      subtitleSmallRounded:
          AppTypography.subtitleSmallRounded.copyWith(color: Colors.black),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: Colors.black87),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: Colors.black87),
      bodySmall: AppTypography.bodySmall.copyWith(color: Colors.black87),
      bodyTiny: AppTypography.bodyTiny.copyWith(color: Colors.black87),
      socialButtonText:
          AppTypography.socialButtonText.copyWith(color: Colors.black),
      buttonText: AppTypography.buttonText.copyWith(color: Colors.black),
      buttonInactiveText:
          AppTypography.buttonInactiveText.copyWith(color: Colors.black54),
      buttonSmallText:
          AppTypography.buttonSmallText.copyWith(color: Colors.black),
      blurOverlayButtonText:
          AppTypography.blurOverlayButtonText.copyWith(color: Colors.black),
      gradientButtonTextSmall:
          AppTypography.gradientButtonTextSmall.copyWith(color: Colors.black),
      onboardingTitle:
          AppTypography.onboardingTitle.copyWith(color: Colors.black),
      onboardingSubtitle:
          AppTypography.onboardingSubtitle.copyWith(color: Colors.black),
      captionTextLarge:
          AppTypography.captionTextLarge.copyWith(color: Colors.black),
      captionTextSmall:
          AppTypography.captionTextSmall.copyWith(color: Colors.black54),
      dialogTitle: AppTypography.dialogTitle.copyWith(color: Colors.black),
      dialogSubtitle:
          AppTypography.dialogSubtitle.copyWith(color: Colors.black87),
      dialogButtonText:
          AppTypography.dialogButtonText.copyWith(color: Colors.black),
      dialogExtraSmallTitle:
          AppTypography.dialogExtraSmallTitle.copyWith(color: Colors.black),
      bottomsheetTitle:
          AppTypography.bottomsheetTitle.copyWith(color: Colors.black),
      bottomsheetSubtitle:
          AppTypography.bottomsheetSubtitle.copyWith(color: Colors.black),
      notificationTileTitle:
          AppTypography.notificationTileTitle.copyWith(color: Colors.black87),
      notificationTileSubtitle: AppTypography.notificationTileSubtitle
          .copyWith(color: Colors.black54),
      notificationDetailTitle:
          AppTypography.notificationDetailTitle.copyWith(color: Colors.black),
      notificationDetailBody:
          AppTypography.notificationDetailBody.copyWith(color: Colors.black87),
      searchBarHintText:
          AppTypography.searchBarHintText.copyWith(color: Colors.black54),
      searchBarText: AppTypography.searchBarText.copyWith(color: Colors.black),
      tabLargeActive:
          AppTypography.tabLargeActive.copyWith(color: Colors.black),
      tabLargeInactive:
          AppTypography.tabLargeInactive.copyWith(color: Colors.black54),
      tabMediumActive:
          AppTypography.tabMediumActive.copyWith(color: Colors.black),
      tabMediumInactive:
          AppTypography.tabMediumInactive.copyWith(color: Colors.black54),
      tabSmallActive:
          AppTypography.tabSmallActive.copyWith(color: Colors.black),
      tabSmallInactive:
          AppTypography.tabSmallInactive.copyWith(color: Colors.black54),
      contentCardTitle:
          AppTypography.contentCardTitle.copyWith(color: Colors.black87),
      contentCardSubtitle:
          AppTypography.contentCardSubtitle.copyWith(color: Colors.black54),
      contentTileTitleSmall:
          AppTypography.contentTileTitleSmall.copyWith(color: Colors.black),
      contentTileSubtitleSmall: AppTypography.contentTileSubtitleSmall
          .copyWith(color: Colors.black54),
      contentTileTitleMedium:
          AppTypography.contentTileTitleMedium.copyWith(color: Colors.black),
      contentTileSubtitleMedium: AppTypography.contentTileSubtitleMedium
          .copyWith(color: Colors.black54),
      contentTileTitleLarge:
          AppTypography.contentTileTitleLarge.copyWith(color: Colors.black),
      contentTileSubtitleLarge: AppTypography.contentTileSubtitleLarge
          .copyWith(color: Colors.black54),
      tileWithIconTitle:
          AppTypography.tileWithIconTitle.copyWith(color: Colors.black),
      pillActiveTabTextSmall:
          AppTypography.pillActiveTabTextSmall.copyWith(color: Colors.black),
      pillInactiveTabTextSmall: AppTypography.pillInactiveTabTextSmall
          .copyWith(color: Colors.black54),
      pillActiveTabTextMedium:
          AppTypography.pillActiveTabTextMedium.copyWith(color: Colors.black),
      pillInactiveTabTextMedium: AppTypography.pillInactiveTabTextMedium
          .copyWith(color: Colors.black54),
      pillActiveTabTextLarge:
          AppTypography.pillActiveTabTextLarge.copyWith(color: Colors.black),
      pillInactiveTabTextLarge: AppTypography.pillInactiveTabTextLarge
          .copyWith(color: Colors.black54),
      gradientActiveTabTextSmall: AppTypography.gradientActiveTabTextSmall
          .copyWith(color: Colors.black),
      gradientActiveTabTextLarge: AppTypography.gradientActiveTabTextLarge
          .copyWith(color: Colors.black),
      gradientInactiveTabTextSmall: AppTypography.gradientInactiveTabTextSmall
          .copyWith(color: Colors.black54),
      gradientInactiveTabTextLarge: AppTypography.gradientInactiveTabTextLarge
          .copyWith(color: Colors.black54),
      emptyStateText:
          AppTypography.emptyStateText.copyWith(color: Colors.black87),
      homeHeaderButtonWithIconText: AppTypography.homeHeaderButtonWithIconText
          .copyWith(color: Colors.black),
      homeGreetingText:
          AppTypography.homeGreetingText.copyWith(color: Colors.black87),
      manifestPlusHomeBannerSubtitle: AppTypography
          .manifestPlusHomeBannerSubtitle
          .copyWith(color: Colors.black87),
      manifestPlusHomeBannerButtonText: AppTypography
          .manifestPlusHomeBannerButtonText
          .copyWith(color: Colors.black),
      bottomPlayerTitle:
          AppTypography.bottomPlayerTitle.copyWith(color: Colors.black),
      bottomPlayerSubtitle:
          AppTypography.bottomPlayerSubtitle.copyWith(color: Colors.black54),
      glowingPageTitle:
          AppTypography.glowingPageTitle.copyWith(color: Colors.black),
      pageTitle: AppTypography.pageTitle.copyWith(color: Colors.black),
      pageSubtitle: AppTypography.pageSubtitle.copyWith(color: Colors.black54),
      textFieldTitle:
          AppTypography.textFieldTitle.copyWith(color: Colors.black),
      textFieldHintText:
          AppTypography.textFieldHintText.copyWith(color: Colors.black54),
      textFieldText: AppTypography.textFieldText.copyWith(color: Colors.black),
      chipTextLarge: AppTypography.chipTextLarge.copyWith(color: Colors.black),
      chipTextlargeCompressed:
          AppTypography.chipTextlargeCompressed.copyWith(color: Colors.black),
      loginPhrase: AppTypography.loginPhrase.copyWith(color: Colors.black),
      loginPhraseBold:
          AppTypography.loginPhraseBold.copyWith(color: Colors.black),
      iosSurveyFormOptionText:
          AppTypography.iosSurveyFormOptionText.copyWith(color: Colors.black),
      soundscapePreviewTitle:
          AppTypography.soundscapePreviewTitle.copyWith(color: Colors.black),
      soundscapePreviewHeading:
          AppTypography.soundscapePreviewHeading.copyWith(color: Colors.black),
      settingFooterText:
          AppTypography.settingFooterText.copyWith(color: Colors.black),
      gradientChipText:
          AppTypography.gradientChipText.copyWith(color: Colors.black),
    );
  }

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? titleLargeRounded,
    TextStyle? titleLarge,
    TextStyle? titleMediumRounded,
    TextStyle? titleMedium,
    TextStyle? titleSmallRounded,
    TextStyle? titleSmall,
    TextStyle? titleExtraSmallRounded,
    TextStyle? titleExtraSmall,
    TextStyle? headingLargeRounded,
    TextStyle? headingLarge,
    TextStyle? glowingHeadingMediumRounded,
    TextStyle? headingMediumRounded,
    TextStyle? headingMedium,
    TextStyle? headingSmallRounded,
    TextStyle? headingSmall,
    TextStyle? headingExtraSmallRounded,
    TextStyle? headingExtraSmall,
    TextStyle? subtitleLarge,
    TextStyle? subtitleMedium,
    TextStyle? subtitleSmall,
    TextStyle? subtitleLargeRounded,
    TextStyle? subtitleMediumRounded,
    TextStyle? subtitleSmallRounded,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? bodyTiny,
    TextStyle? socialButtonText,
    TextStyle? buttonText,
    TextStyle? buttonInactiveText,
    TextStyle? buttonSmallText,
    TextStyle? blurOverlayButtonText,
    TextStyle? gradientButtonTextSmall,
    TextStyle? onboardingTitle,
    TextStyle? onboardingSubtitle,
    TextStyle? captionTextLarge,
    TextStyle? captionTextSmall,
    TextStyle? dialogTitle,
    TextStyle? dialogSubtitle,
    TextStyle? dialogButtonText,
    TextStyle? dialogExtraSmallTitle,
    TextStyle? bottomsheetTitle,
    TextStyle? bottomsheetSubtitle,
    TextStyle? notificationTileTitle,
    TextStyle? notificationTileSubtitle,
    TextStyle? notificationDetailTitle,
    TextStyle? notificationDetailBody,
    TextStyle? searchBarText,
    TextStyle? searchBarHintText,
    TextStyle? tabLargeActive,
    TextStyle? tabLargeInactive,
    TextStyle? tabMediumActive,
    TextStyle? tabMediumInactive,
    TextStyle? tabSmallActive,
    TextStyle? tabSmallInactive,
    TextStyle? contentCardTitle,
    TextStyle? contentCardSubtitle,
    TextStyle? contentTileTitleSmall,
    TextStyle? contentTileSubtitleSmall,
    TextStyle? contentTileTitleMedium,
    TextStyle? contentTileSubtitleMedium,
    TextStyle? contentTileTitleLarge,
    TextStyle? contentTileSubtitleLarge,
    TextStyle? tileWithIconTitle,
    TextStyle? pillActiveTabTextSmall,
    TextStyle? pillInactiveTabTextSmall,
    TextStyle? pillActiveTabTextMedium,
    TextStyle? pillInactiveTabTextMedium,
    TextStyle? pillActiveTabTextLarge,
    TextStyle? pillInactiveTabTextLarge,
    TextStyle? gradientActiveTabTextSmall,
    TextStyle? gradientActiveTabTextLarge,
    TextStyle? gradientInactiveTabTextSmall,
    TextStyle? gradientInactiveTabTextLarge,
    TextStyle? emptyStateText,
    TextStyle? homeHeaderButtonWithIconText,
    TextStyle? homeGreetingText,
    TextStyle? manifestPlusHomeBannerSubtitle,
    TextStyle? manifestPlusHomeBannerButtonText,
    TextStyle? bottomPlayerTitle,
    TextStyle? bottomPlayerSubtitle,
    TextStyle? glowingPageTitle,
    TextStyle? pageTitle,
    TextStyle? pageSubtitle,
    TextStyle? textFieldTitle,
    TextStyle? textFieldHintText,
    TextStyle? textFieldText,
    TextStyle? chipTextLarge,
    TextStyle? chipTextlargeCompressed,
    TextStyle? loginPhrase,
    TextStyle? loginPhraseBold,
    TextStyle? iosSurveyFormOptionText,
    TextStyle? soundscapePreviewTitle,
    TextStyle? soundscapePreviewHeading,
    TextStyle? settingFooterText,
    TextStyle? gradientChipText,
  }) {
    return AppTextTheme(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      titleLargeRounded: titleLargeRounded ?? this.titleLargeRounded,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMediumRounded: titleMediumRounded ?? this.titleMediumRounded,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmallRounded: titleSmallRounded ?? this.titleSmallRounded,
      titleSmall: titleSmall ?? this.titleSmall,
      titleExtraSmallRounded:
          titleExtraSmallRounded ?? this.titleExtraSmallRounded,
      titleExtraSmall: titleExtraSmall ?? this.titleExtraSmall,
      headingLargeRounded: headingLargeRounded ?? this.headingLargeRounded,
      headingLarge: headingLarge ?? this.headingLarge,
      glowingHeadingMediumRounded:
          glowingHeadingMediumRounded ?? this.glowingHeadingMediumRounded,
      headingMediumRounded: headingMediumRounded ?? this.headingMediumRounded,
      headingMedium: headingMedium ?? this.headingMedium,
      headingSmallRounded: headingSmallRounded ?? this.headingSmallRounded,
      headingSmall: headingSmall ?? this.headingSmall,
      headingExtraSmallRounded:
          headingExtraSmallRounded ?? this.headingExtraSmallRounded,
      headingExtraSmall: headingExtraSmall ?? this.headingExtraSmall,
      subtitleLarge: subtitleLarge ?? this.subtitleLarge,
      subtitleLargeRounded: subtitleLargeRounded ?? this.subtitleLarge,
      subtitleMedium: subtitleMedium ?? this.subtitleMedium,
      subtitleMediumRounded: subtitleMediumRounded ?? this.subtitleMedium,
      subtitleSmall: subtitleSmall ?? this.subtitleSmall,
      subtitleSmallRounded: subtitleSmallRounded ?? this.subtitleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      bodyTiny: bodyTiny ?? this.bodyTiny,
      socialButtonText: socialButtonText ?? this.socialButtonText,
      buttonText: buttonText ?? this.buttonText,
      buttonInactiveText: buttonInactiveText ?? this.buttonInactiveText,
      buttonSmallText: buttonSmallText ?? this.buttonSmallText,
      blurOverlayButtonText:
          blurOverlayButtonText ?? this.blurOverlayButtonText,
      gradientButtonTextSmall:
          gradientButtonTextSmall ?? this.gradientButtonTextSmall,
      onboardingTitle: onboardingTitle ?? this.onboardingTitle,
      onboardingSubtitle: onboardingSubtitle ?? this.onboardingSubtitle,
      captionTextLarge: captionTextLarge ?? this.captionTextLarge,
      captionTextSmall: captionTextSmall ?? this.captionTextSmall,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogSubtitle: dialogSubtitle ?? this.dialogSubtitle,
      dialogButtonText: dialogButtonText ?? this.dialogButtonText,
      dialogExtraSmallTitle:
          dialogExtraSmallTitle ?? this.dialogExtraSmallTitle,
      bottomsheetTitle: bottomsheetTitle ?? this.bottomsheetTitle,
      bottomsheetSubtitle: bottomsheetSubtitle ?? this.bottomsheetSubtitle,
      notificationTileTitle:
          notificationTileTitle ?? this.notificationTileTitle,
      notificationTileSubtitle:
          notificationTileSubtitle ?? this.notificationTileSubtitle,
      notificationDetailTitle:
          notificationDetailTitle ?? this.notificationDetailTitle,
      notificationDetailBody:
          notificationDetailBody ?? this.notificationDetailBody,
      searchBarHintText: searchBarText ?? this.searchBarHintText,
      searchBarText: searchBarText ?? this.searchBarText,
      tabLargeActive: tabLargeActive ?? this.tabLargeActive,
      tabLargeInactive: tabLargeInactive ?? this.tabLargeInactive,
      tabMediumActive: tabMediumActive ?? this.tabMediumActive,
      tabMediumInactive: tabMediumInactive ?? this.tabMediumInactive,
      tabSmallActive: tabSmallActive ?? this.tabSmallActive,
      tabSmallInactive: tabSmallInactive ?? this.tabSmallInactive,
      contentCardTitle: contentCardTitle ?? this.contentCardTitle,
      contentCardSubtitle: contentCardSubtitle ?? this.contentCardSubtitle,
      contentTileTitleSmall:
          contentTileTitleSmall ?? this.contentTileTitleSmall,
      contentTileSubtitleSmall:
          contentTileSubtitleSmall ?? this.contentTileSubtitleSmall,
      contentTileTitleMedium:
          contentTileTitleMedium ?? this.contentTileTitleMedium,
      contentTileSubtitleMedium:
          contentTileSubtitleMedium ?? this.contentTileSubtitleMedium,
      contentTileTitleLarge:
          contentTileTitleLarge ?? this.contentTileTitleLarge,
      contentTileSubtitleLarge:
          contentTileSubtitleLarge ?? this.contentTileSubtitleLarge,
      tileWithIconTitle: tileWithIconTitle ?? this.tileWithIconTitle,
      pillActiveTabTextSmall:
          pillActiveTabTextSmall ?? this.pillActiveTabTextSmall,
      pillInactiveTabTextSmall:
          pillInactiveTabTextSmall ?? this.pillInactiveTabTextSmall,
      pillActiveTabTextMedium:
          pillActiveTabTextMedium ?? this.pillActiveTabTextMedium,
      pillInactiveTabTextMedium:
          pillInactiveTabTextMedium ?? this.pillInactiveTabTextMedium,
      pillActiveTabTextLarge:
          pillActiveTabTextLarge ?? this.pillActiveTabTextLarge,
      pillInactiveTabTextLarge:
          pillInactiveTabTextLarge ?? this.pillInactiveTabTextLarge,
      gradientActiveTabTextSmall:
          gradientActiveTabTextSmall ?? this.gradientActiveTabTextSmall,
      gradientActiveTabTextLarge:
          gradientActiveTabTextLarge ?? this.gradientActiveTabTextLarge,
      gradientInactiveTabTextSmall:
          gradientInactiveTabTextSmall ?? this.gradientInactiveTabTextSmall,
      gradientInactiveTabTextLarge:
          gradientInactiveTabTextLarge ?? this.gradientInactiveTabTextLarge,
      emptyStateText: emptyStateText ?? this.emptyStateText,
      homeHeaderButtonWithIconText:
          homeHeaderButtonWithIconText ?? this.homeHeaderButtonWithIconText,
      homeGreetingText: homeGreetingText ?? this.homeGreetingText,
      manifestPlusHomeBannerSubtitle:
          manifestPlusHomeBannerSubtitle ?? this.manifestPlusHomeBannerSubtitle,
      manifestPlusHomeBannerButtonText: manifestPlusHomeBannerButtonText ??
          this.manifestPlusHomeBannerButtonText,
      bottomPlayerTitle: bottomPlayerTitle ?? this.bottomPlayerTitle,
      bottomPlayerSubtitle: bottomPlayerSubtitle ?? this.bottomPlayerSubtitle,
      glowingPageTitle: glowingPageTitle ?? this.glowingPageTitle,
      pageTitle: pageTitle ?? this.pageTitle,
      pageSubtitle: pageSubtitle ?? this.pageSubtitle,
      textFieldTitle: textFieldTitle ?? this.textFieldTitle,
      textFieldHintText: textFieldHintText ?? this.textFieldHintText,
      textFieldText: textFieldText ?? this.textFieldText,
      chipTextLarge: chipTextLarge ?? this.chipTextLarge,
      chipTextlargeCompressed:
          chipTextlargeCompressed ?? this.chipTextlargeCompressed,
      loginPhrase: loginPhrase ?? this.loginPhrase,
      loginPhraseBold: loginPhraseBold ?? this.loginPhraseBold,
      iosSurveyFormOptionText:
          iosSurveyFormOptionText ?? this.iosSurveyFormOptionText,
      soundscapePreviewTitle:
          soundscapePreviewTitle ?? this.soundscapePreviewTitle,
      soundscapePreviewHeading:
          soundscapePreviewHeading ?? this.soundscapePreviewHeading,
      settingFooterText: settingFooterText ?? this.settingFooterText,
      gradientChipText: gradientChipText ?? this.gradientChipText,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
      ThemeExtension<AppTextTheme>? other, double t) {
    if (other is! AppTextTheme) {
      return this;
    }
    return AppTextTheme(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      titleLargeRounded:
          TextStyle.lerp(titleLargeRounded, other.titleLargeRounded, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMediumRounded:
          TextStyle.lerp(titleMediumRounded, other.titleMediumRounded, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmallRounded:
          TextStyle.lerp(titleSmallRounded, other.titleSmallRounded, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      titleExtraSmallRounded: TextStyle.lerp(
          titleExtraSmallRounded, other.titleExtraSmallRounded, t)!,
      titleExtraSmall:
          TextStyle.lerp(titleExtraSmall, other.titleExtraSmall, t)!,
      headingLargeRounded:
          TextStyle.lerp(headingLargeRounded, other.headingLargeRounded, t)!,
      headingLarge: TextStyle.lerp(headingLarge, other.headingLarge, t)!,
      glowingHeadingMediumRounded: TextStyle.lerp(
          glowingHeadingMediumRounded, other.glowingHeadingMediumRounded, t)!,
      headingMediumRounded:
          TextStyle.lerp(headingMediumRounded, other.headingMediumRounded, t)!,
      headingMedium: TextStyle.lerp(headingMedium, other.headingMedium, t)!,
      headingSmallRounded:
          TextStyle.lerp(headingSmallRounded, other.headingSmallRounded, t)!,
      headingSmall: TextStyle.lerp(headingSmall, other.headingSmall, t)!,
      headingExtraSmallRounded: TextStyle.lerp(
          headingExtraSmallRounded, other.headingExtraSmallRounded, t)!,
      headingExtraSmall:
          TextStyle.lerp(headingExtraSmall, other.headingExtraSmall, t)!,
      subtitleLarge: TextStyle.lerp(subtitleLarge, other.subtitleLarge, t)!,
      subtitleLargeRounded:
          TextStyle.lerp(subtitleLargeRounded, other.subtitleLarge, t)!,
      subtitleMedium: TextStyle.lerp(subtitleMedium, other.subtitleMedium, t)!,
      subtitleMediumRounded: TextStyle.lerp(
          subtitleMediumRounded, other.subtitleMediumRounded, t)!,
      subtitleSmall: TextStyle.lerp(subtitleSmall, other.subtitleSmall, t)!,
      subtitleSmallRounded:
          TextStyle.lerp(subtitleSmallRounded, other.subtitleSmallRounded, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      bodyTiny: TextStyle.lerp(bodyTiny, other.bodyTiny, t)!,
      socialButtonText:
          TextStyle.lerp(socialButtonText, other.socialButtonText, t)!,
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t)!,
      buttonInactiveText:
          TextStyle.lerp(buttonInactiveText, other.buttonInactiveText, t)!,
      buttonSmallText:
          TextStyle.lerp(buttonSmallText, other.buttonSmallText, t)!,
      blurOverlayButtonText: TextStyle.lerp(
          blurOverlayButtonText, other.blurOverlayButtonText, t)!,
      gradientButtonTextSmall: TextStyle.lerp(
          gradientButtonTextSmall, other.gradientButtonTextSmall, t)!,
      onboardingTitle:
          TextStyle.lerp(onboardingTitle, other.onboardingTitle, t)!,
      onboardingSubtitle:
          TextStyle.lerp(onboardingSubtitle, other.onboardingSubtitle, t)!,
      captionTextLarge:
          TextStyle.lerp(captionTextLarge, other.captionTextLarge, t)!,
      captionTextSmall:
          TextStyle.lerp(captionTextSmall, other.captionTextSmall, t)!,
      dialogTitle: TextStyle.lerp(dialogTitle, other.dialogTitle, t)!,
      dialogSubtitle: TextStyle.lerp(dialogSubtitle, other.dialogSubtitle, t)!,
      dialogButtonText:
          TextStyle.lerp(dialogButtonText, other.dialogButtonText, t)!,
      dialogExtraSmallTitle: TextStyle.lerp(
          dialogExtraSmallTitle, other.dialogExtraSmallTitle, t)!,
      bottomsheetTitle:
          TextStyle.lerp(bottomsheetTitle, other.bottomsheetTitle, t)!,
      bottomsheetSubtitle:
          TextStyle.lerp(bottomsheetSubtitle, other.bottomsheetSubtitle, t)!,
      notificationTileTitle: TextStyle.lerp(
          notificationTileTitle, other.notificationTileTitle, t)!,
      notificationTileSubtitle: TextStyle.lerp(
          notificationTileSubtitle, other.notificationTileSubtitle, t)!,
      notificationDetailTitle: TextStyle.lerp(
          notificationDetailTitle, other.notificationDetailTitle, t)!,
      notificationDetailBody: TextStyle.lerp(
          notificationDetailBody, other.notificationDetailBody, t)!,
      searchBarHintText:
          TextStyle.lerp(searchBarHintText, other.searchBarHintText, t)!,
      searchBarText: TextStyle.lerp(searchBarText, other.searchBarText, t)!,
      tabLargeActive: TextStyle.lerp(tabLargeActive, other.tabLargeActive, t)!,
      tabLargeInactive:
          TextStyle.lerp(tabLargeInactive, other.tabLargeInactive, t)!,
      tabMediumActive:
          TextStyle.lerp(tabMediumActive, other.tabMediumActive, t)!,
      tabMediumInactive:
          TextStyle.lerp(tabMediumInactive, other.tabMediumInactive, t)!,
      tabSmallActive: TextStyle.lerp(tabSmallActive, other.tabSmallActive, t)!,
      tabSmallInactive:
          TextStyle.lerp(tabSmallInactive, other.tabSmallInactive, t)!,
      contentCardTitle:
          TextStyle.lerp(contentCardTitle, other.contentCardTitle, t)!,
      contentCardSubtitle:
          TextStyle.lerp(contentCardSubtitle, other.contentCardSubtitle, t)!,
      contentTileTitleSmall: TextStyle.lerp(
          contentTileTitleSmall, other.contentTileTitleSmall, t)!,
      contentTileSubtitleSmall: TextStyle.lerp(
          contentTileSubtitleSmall, other.contentTileSubtitleSmall, t)!,
      contentTileTitleMedium: TextStyle.lerp(
          contentTileTitleMedium, other.contentTileTitleMedium, t)!,
      contentTileSubtitleMedium: TextStyle.lerp(
          contentTileSubtitleMedium, other.contentTileSubtitleMedium, t)!,
      contentTileTitleLarge: TextStyle.lerp(
          contentTileTitleLarge, other.contentTileTitleLarge, t)!,
      contentTileSubtitleLarge: TextStyle.lerp(
          contentTileSubtitleLarge, other.contentTileSubtitleLarge, t)!,
      tileWithIconTitle:
          TextStyle.lerp(tileWithIconTitle, other.tileWithIconTitle, t)!,
      pillActiveTabTextSmall: TextStyle.lerp(
          pillActiveTabTextSmall, other.pillActiveTabTextSmall, t)!,
      pillInactiveTabTextSmall: TextStyle.lerp(
          pillInactiveTabTextSmall, other.pillInactiveTabTextSmall, t)!,
      pillActiveTabTextMedium: TextStyle.lerp(
          pillActiveTabTextMedium, other.pillActiveTabTextMedium, t)!,
      pillInactiveTabTextMedium: TextStyle.lerp(
          pillInactiveTabTextMedium, other.pillInactiveTabTextMedium, t)!,
      pillActiveTabTextLarge: TextStyle.lerp(
          pillActiveTabTextLarge, other.pillActiveTabTextLarge, t)!,
      pillInactiveTabTextLarge: TextStyle.lerp(
          pillInactiveTabTextLarge, other.pillInactiveTabTextLarge, t)!,
      gradientActiveTabTextSmall: TextStyle.lerp(
          gradientActiveTabTextSmall, other.gradientActiveTabTextSmall, t)!,
      gradientActiveTabTextLarge: TextStyle.lerp(
          gradientActiveTabTextLarge, other.gradientActiveTabTextLarge, t)!,
      gradientInactiveTabTextSmall: TextStyle.lerp(
          gradientInactiveTabTextSmall, other.gradientInactiveTabTextSmall, t)!,
      gradientInactiveTabTextLarge: TextStyle.lerp(
          gradientInactiveTabTextLarge, other.gradientInactiveTabTextLarge, t)!,
      emptyStateText: TextStyle.lerp(emptyStateText, other.emptyStateText, t)!,
      homeHeaderButtonWithIconText: TextStyle.lerp(
          homeHeaderButtonWithIconText, other.homeHeaderButtonWithIconText, t)!,
      homeGreetingText:
          TextStyle.lerp(homeGreetingText, other.homeGreetingText, t)!,
      manifestPlusHomeBannerSubtitle: TextStyle.lerp(
          manifestPlusHomeBannerSubtitle,
          other.manifestPlusHomeBannerSubtitle,
          t)!,
      manifestPlusHomeBannerButtonText: TextStyle.lerp(
          manifestPlusHomeBannerButtonText,
          other.manifestPlusHomeBannerButtonText,
          t)!,
      bottomPlayerTitle:
          TextStyle.lerp(bottomPlayerTitle, other.bottomPlayerTitle, t)!,
      bottomPlayerSubtitle:
          TextStyle.lerp(bottomPlayerSubtitle, other.bottomPlayerSubtitle, t)!,
      glowingPageTitle:
          TextStyle.lerp(glowingPageTitle, other.glowingPageTitle, t)!,
      pageTitle: TextStyle.lerp(pageTitle, other.pageTitle, t)!,
      pageSubtitle: TextStyle.lerp(pageSubtitle, other.pageSubtitle, t)!,
      textFieldTitle: TextStyle.lerp(textFieldTitle, other.textFieldTitle, t)!,
      textFieldHintText:
          TextStyle.lerp(textFieldHintText, other.textFieldHintText, t)!,
      textFieldText: TextStyle.lerp(textFieldText, other.textFieldText, t)!,
      chipTextLarge: TextStyle.lerp(chipTextLarge, other.chipTextLarge, t)!,
      chipTextlargeCompressed: TextStyle.lerp(
          chipTextlargeCompressed, other.chipTextlargeCompressed, t)!,
      loginPhrase: TextStyle.lerp(loginPhrase, other.loginPhrase, t)!,
      loginPhraseBold:
          TextStyle.lerp(loginPhraseBold, other.loginPhraseBold, t)!,
      iosSurveyFormOptionText: TextStyle.lerp(
          iosSurveyFormOptionText, other.iosSurveyFormOptionText, t)!,
      soundscapePreviewTitle: TextStyle.lerp(
          soundscapePreviewTitle, other.soundscapePreviewTitle, t)!,
      soundscapePreviewHeading: TextStyle.lerp(
          soundscapePreviewHeading, other.soundscapePreviewHeading, t)!,
      settingFooterText:
          TextStyle.lerp(settingFooterText, other.settingFooterText, t)!,
      gradientChipText:
          TextStyle.lerp(gradientChipText, other.gradientChipText, t)!,
    );
  }
}
