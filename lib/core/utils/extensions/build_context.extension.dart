import 'package:flutter/material.dart';
import 'package:manifest/core/theme/app_text_theme.dart';

extension BuildContextExtension on BuildContext {
  /// give access to Theme.of(context).extension<AppTextTheme>()!
  AppTextTheme get appTextTheme => Theme.of(this).extension<AppTextTheme>()!;
}