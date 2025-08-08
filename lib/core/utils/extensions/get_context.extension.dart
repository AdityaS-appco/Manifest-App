import 'package:get/get.dart';
import 'package:manifest/core/theme/app_text_theme.dart';
import 'package:manifest/core/utils/extensions/build_context.extension.dart';

extension GetContextExtension on GetInterface {
  /// give access to Get.context!.appTextTheme
  AppTextTheme get appTextTheme => Get.context!.appTextTheme;
}
