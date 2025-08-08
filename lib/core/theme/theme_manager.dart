import 'package:flutter/material.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/theme/app_fonts.dart';
import 'package:manifest/core/theme/app_text_theme.dart';
import 'package:manifest/helper/constant.dart';

class ThemeManager {
  static final light = ThemeData(
      fontFamily: AppFonts.helvetica.name,
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.black,
      cardColor: greyColor,
      appBarTheme: AppBarTheme(
        color: kWhiteColor,
        elevation: 0.0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: kWhiteColor,
        unselectedItemColor: greyColor,
        elevation: 0.0,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppTextTheme.light(),
      ],
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.appBG));

  static final dark = ThemeData(
      fontFamily: AppFonts.helvetica.name,
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: appBackgroundColor,
      appBarTheme: AppBarTheme(
          color: appBackgroundColor,
          elevation: 0.0,
          centerTitle: true,
          surfaceTintColor: Colors.transparent),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xff252525),
        selectedItemColor: kWhiteColor,
        unselectedItemColor: greyColor,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppTextTheme.dark(),
      ],
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.appBG));
}
