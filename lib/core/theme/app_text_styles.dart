import 'package:flutter/material.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';

TextStyle breeSerifPageTitleTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? Colors.white,
      fontSize: (fontSize ?? 28).sp,
      fontFamily: AppFonts.breeSerif.name,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: (height ?? 1).sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

TextStyle tanMemoriesPageTitleTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? Colors.white,
      fontSize: (fontSize ?? 28).sp,
      fontFamily: AppFonts.tanMemories.name,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: (height ?? 1).sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

TextStyle pacificoPageTitleTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? Colors.white,
      fontSize: (fontSize ?? 28).sp,
      fontFamily: AppFonts.pacifico.name,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: (height ?? 1).sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

TextStyle helveticaPageTitleTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? Colors.white,
      fontSize: (fontSize ?? 28).sp,
      fontFamily: AppFonts.helvetica.name,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: (height ?? 1).sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

TextStyle helveticaRoundedPageTitleTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? Colors.white,
      fontSize: (fontSize ?? 28).sp,
      fontFamily: AppFonts.helveticaRounded.name,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: (height ?? 1).sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

TextStyle headingTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? Colors.white,
      fontSize: (fontSize ?? 20).sp,
      fontFamily: AppFonts.helveticaRounded.name,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: 1.sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

TextStyle buttonSMTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? AppColors.light,
      fontSize: (fontSize ?? 10).sp,
      fontFamily: AppFonts.helvetica.name,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: 1.sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

TextStyle bodyTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? wordSpacing,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? Colors.white,
      fontSize: (fontSize ?? 14).sp,
      fontFamily: AppFonts.helvetica.name,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: 1.2.sp,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
    );

/// ! Older text styles

// black text styles
TextStyle primaryTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontFamily: AppFonts.helvetica.name,
    fontSize: fontSize != null ? fontSize.sp : primaryFontSize,
    fontWeight: fontWeight ?? FontWeight.w300,
  );
}

TextStyle secondaryTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontFamily: AppFonts.helvetica.name,
    fontSize: fontSize != null ? fontSize.sp : secondaryFontSize,
    fontWeight: fontWeight ?? FontWeight.w600,
  );
}

// white text styles
TextStyle primaryWhiteTextStyle({
  double? fontSize,
  double? letterSpacing,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    letterSpacing: letterSpacing ?? 0.2,
    fontFamily: AppFonts.helvetica.name,
    fontSize: fontSize != null ? fontSize.sp : primaryFontSize,
    fontWeight: fontWeight ?? FontWeight.w300,
    color: color ?? kWhiteColor,
  );
}

TextStyle secondaryWhiteTextStyle(
    {double? fontSize, FontWeight? fontWeight, Color? color}) {
  return TextStyle(
    overflow: TextOverflow.ellipsis,
    fontFamily: AppFonts.helvetica.name,
    fontSize: fontSize != null ? fontSize.sp : secondaryFontSize,
    // fontSize:  fontSize ?? secondaryFontSize,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? kWhiteColor,
  );
}

TextStyle customTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? height,
  double? wordSpacing,
  String? fontFamily,
}) {
  return TextStyle(
      fontFamily: fontFamily != null
          ? fontFamily.toString()
          : AppFonts.helvetica.name,
      fontSize: fontSize != null ? fontSize.sp : primaryFontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      overflow: TextOverflow.ellipsis);
}

TextStyle appBarTitleTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  double? letterSpacing,
}) {
  return TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: AppFonts.helveticaRounded.name,
      fontSize: fontSize != null ? fontSize.sp : 17.0.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
      letterSpacing: letterSpacing,
      color: color);
}

TextStyle headingWhiteTanMemoriesTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: AppFonts.tanMemories.name,
    fontSize: fontSize != null ? fontSize.sp : 22.0.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color,
  );
}

TextStyle headingWhiteBreeSerifTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: AppFonts.breeSerif.name,
    fontSize: fontSize != null ? fontSize.sp : 22.0.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color,
  );
}

TextStyle primaryWhiteHelveticaRoundedBoldTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    letterSpacing: 0.2,
    fontFamily: AppFonts.helveticaRounded.name,
    fontSize: fontSize != null ? fontSize.sp : primaryFontSize,
    fontWeight: fontWeight ?? FontWeight.w300,
    color: color ?? kWhiteColor,
    height: 1.2,
  );
}

TextStyle primaryWhiteHelveticaRoundedRegularTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    letterSpacing: 0.2,
    fontFamily: AppFonts.helveticaRounded.name,
    fontSize: fontSize != null ? fontSize.sp : primaryFontSize,
    fontWeight: fontWeight ?? FontWeight.w300,
    color: color ?? kWhiteColor,
  );
}

TextStyle primaryGlowWhiteHelveticaRoundedBoldTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    letterSpacing: 0.2,
    fontFamily: AppFonts.helveticaRounded.name,
    fontSize: fontSize != null ? fontSize.sp : primaryFontSize,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color ?? kWhiteColor,
    height: 1.2,
    shadows: [
      Shadow(
        color: Colors.grey.shade200,
        blurRadius: 4.0,
        offset: const Offset(0.0, 0.0),
      ),
    ],
  );
}

TextStyle headingHelveticaRoundedBoldFontStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  FontStyle? fontStyle,
  double? height,
  List<Shadow>? shadows,
}) {
  return TextStyle(
      letterSpacing: 0.2,
      fontFamily: AppFonts.helveticaRounded.name,
      fontSize: fontSize != null ? fontSize.sp : 28.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? kWhiteColor,
      fontStyle: fontStyle ?? FontStyle.normal,
      height: height ?? 1.2,
      shadows: shadows);
}
