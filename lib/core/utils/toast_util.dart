import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';

/// * A custom toast/snackbar implementation that matches the app's design
class ToastUtil {
  static bool _isToastDisplayed = false;
  static SnackbarController? _currentToast;

  /// * Shows a toast message with the specified type and message
  static void show({
    required String message,
    ToastType type = ToastType.success,
    Duration? duration,
  }) {
    if (_isToastDisplayed) {
      dismiss();
    }

    _isToastDisplayed = true;

    _currentToast = Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.transparent,
        duration: duration ?? const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        isDismissible: true,
        onTap: (_) => dismiss(),
        messageText: Row(
          children: [
            const Spacer(),
            BlurContainer(
              borderRadius: BorderRadius.circular(25.r),
              blurAmount: 25,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      _getIconPath(type),
                      height: 19.r,
                      width: 19.r,
                      colorFilter: ColorFilter.mode(
                        _getIconColor(type),
                        BlendMode.srcIn,
                      ),
                    ),
                    8.width,
                    Flexible(
                      child: Text(
                        message,
                        style: helveticaPageTitleTextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
    
    // Auto-reset the state after the toast disappears
    Future.delayed(duration ?? const Duration(seconds: 3), () {
      if (_isToastDisplayed) {
        _isToastDisplayed = false;
        _currentToast = null;
      }
    });
  }

  /// * Dismisses the currently displayed toast
  static void dismiss() {
    if (_currentToast != null) {
      _currentToast?.close();
      _currentToast = null;
    }
    _isToastDisplayed = false;
  }

  /// * Shows a success toast message
  static void success(String message) {
    show(message: message, type: ToastType.success);
  }

  /// * Shows an error toast message
  static void error(String message) {
    show(message: message, type: ToastType.error);
  }

  /// * Shows a warning toast message
  static void warning(String message) {
    show(message: message, type: ToastType.warning);
  }

  /// * Shows an info toast message
  static void info(String message) {
    show(message: message, type: ToastType.info);
  }

  /// * Gets the appropriate icon path based on the toast type
  static String _getIconPath(ToastType type) {
    switch (type) {
      case ToastType.success:
        return IconAllConstants.checkCircle;
      case ToastType.error:
        return IconAllConstants.alertCircle;
      case ToastType.warning:
        return IconAllConstants.warningTriangle;
      case ToastType.info:
        return IconAllConstants.infoCircle;
    }
  }

  /// * Gets the appropriate icon color based on the toast type
  static Color _getIconColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColors.success;
      case ToastType.error:
        return AppColors.error;
      case ToastType.warning:
        return AppColors.warning;
      case ToastType.info:
        return AppColors.info;
    }
  }
}

/// * Enum representing different types of toasts
enum ToastType {
  success,
  error,
  warning,
  info,
}