import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

// ! author: @alok_singh

Size get kSize => Get.size;

class AppDimensions {
  // ! create singleton: so that we can access it from anywhere and only create one instance
  AppDimensions._();
  static final AppDimensions _instance = AppDimensions._();
  factory AppDimensions() => _instance;

  // Defaults
  static double kDefaultPadding = 22.0.r;
  static double kDefaultMargin = 14.0.r;
  static double kMaxMargin = 16.0.r;
  static double kSpaceBetween = 16.0.r;

  // Gap
  static Gap kGap2XS = Gap(8.0.r);
  static Gap kGapXS = Gap(12.0.r);
  static Gap kGapSM = Gap(16.0.r);
  static Gap kGapMD = Gap(24.0.r);
  static Gap kGapLG = Gap(32.0.r);
  static Gap kGapXL = Gap(42.0.r);

  // Padding
  static EdgeInsets kPaddingAllSM = const EdgeInsets.all(12).r;
  static EdgeInsets kPaddingAllMD = const EdgeInsets.all(16).r;
  static EdgeInsets kPaddingAllLG = const EdgeInsets.all(24).r;
  static EdgeInsets kPaddingAllXL = const EdgeInsets.all(32).r;

  // Border Radius
  static BorderRadius kRadiusAllSM = BorderRadius.circular(12).r;
  static BorderRadius kRadiusAllMD = BorderRadius.circular(16).r;
  static BorderRadius kRadiusAllLG = BorderRadius.circular(20).r;
  static BorderRadius kRadiusAllXL = BorderRadius.circular(24).r;

  // Shadow

  // Font Size

  // Image Size
  static double kImageSizeSM = 40.r;
  static double kImageSizeMD = 80.r;
  static double kImageSizeLG = 120.r;

  // Icon Size
  static double kIconSizeSM = 12.r;
  static double kIconSizeMD = 16.r;
  static double kIconSizeLG = 20.r;
}
