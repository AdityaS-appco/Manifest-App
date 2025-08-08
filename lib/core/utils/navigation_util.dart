import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationUtil {
  /// Observable flag to track navigation state
  static final RxBool isNavigating = false.obs;

  /// Provides a standardized navigation method with configurable parameters
  ///
  /// [splashDuration]: Total duration before navigation
  /// [fadeTransitionDuration]: Duration of fade transition
  /// [navigateTo]: Destination widget or screen
  /// [preNavigationCallback]: Optional callback before navigation
  /// [postNavigationCallback]: Optional callback after navigation
  static Future<void> animateToWithDelay({
    bool hasSplash = false,
    Duration splashDuration = const Duration(seconds: 6),
    Duration fadeTransitionDuration = const Duration(milliseconds: 500),
    Transition transition = Transition.fadeIn,
    required Widget Function() navigateTo,
    VoidCallback? preNavigationCallback,
    VoidCallback? postNavigationCallback,
  }) async {
    try {
      /// * Initial delay
      if (hasSplash) {
        await Future.delayed(splashDuration, () {
          /// * Trigger navigation state
          isNavigating.value = true;

          /// * Short delay for fade transition
          _navigateToWithDelay(fadeTransitionDuration, preNavigationCallback,
              navigateTo, transition, postNavigationCallback);
        });
      } else {
        /// * Navigate directly
        _navigateToWithDelay(fadeTransitionDuration, preNavigationCallback,
            navigateTo, transition, postNavigationCallback);
      }
    } catch (e) {
      /// * Fallback navigation in case of error
      Get.offAll(
        navigateTo,
        transition: transition,
      );
    }
  }

  static Future<void> _navigateToWithDelay(
    Duration fadeTransitionDuration,
    VoidCallback? preNavigationCallback,
    Widget Function() navigateTo,
    Transition transition,
    VoidCallback? postNavigationCallback,
  ) {
    return Future.delayed(fadeTransitionDuration, () {
      /// * Optional pre-navigation callback
      preNavigationCallback?.call();

      /// * Navigate
      Get.offAll(
        navigateTo,
        transition: transition,
        duration: fadeTransitionDuration,
      );

      /// * Optional post-navigation callback
      postNavigationCallback?.call();
    });
  }

  /// * Navigate back with a delay
  /// * [preNavigationDelay]: Duration of delay before navigation
  /// * [postNavigationDelay]: Duration of delay after navigation
  /// * [preNavigationCallback]: Optional callback before navigation
  /// * [postNavigationCallback]: Optional callback after navigation
  static Future<void> backWithDelay({
    Duration preNavigationDelay = const Duration(milliseconds: 300),
    Duration postNavigationDelay = const Duration(milliseconds: 300),
    VoidCallback? preNavigationCallback,
    VoidCallback? postNavigationCallback,
  }) async {
    preNavigationCallback?.call();
    await Future.delayed(preNavigationDelay, () {
      Get.back();
    });
    await Future.delayed(postNavigationDelay, () {
      postNavigationCallback?.call();
    });
  }

  /// * Navigate off all with a delay
  /// * [navigateTo]: Destination widget or screen
  /// * [preNavigationDelay]: Duration of delay before navigation
  /// * [postNavigationDelay]: Duration of delay after navigation
  /// * [preNavigationCallback]: Optional callback before navigation
  /// * [postNavigationCallback]: Optional callback after navigation
  static Future<void> offAllWithDelay({
    required Widget navigateTo,
    Duration preNavigationDelay = const Duration(milliseconds: 300),
    Duration postNavigationDelay = const Duration(milliseconds: 300),
    VoidCallback? preNavigationCallback,
    VoidCallback? postNavigationCallback,
  }) async {
    preNavigationCallback?.call();
    await Future.delayed(preNavigationDelay, () {
      Get.offAll(navigateTo);
    });
    await Future.delayed(postNavigationDelay, () {
      postNavigationCallback?.call();
    });
  }

  /// * Navigate off with a delay
  /// * [navigateTo]: Destination widget or screen
  /// * [preNavigationDelay]: Duration of delay before navigation
  /// * [postNavigationDelay]: Duration of delay after navigation
  /// * [preNavigationCallback]: Optional callback before navigation
  /// * [postNavigationCallback]: Optional callback after navigation
  static Future<void> offWithDelay({
    required Widget navigateTo,
    Duration preNavigationDelay = const Duration(milliseconds: 300),
    Duration postNavigationDelay = const Duration(milliseconds: 300),
    VoidCallback? preNavigationCallback,
    VoidCallback? postNavigationCallback,
  }) async {
    preNavigationCallback?.call();
    await Future.delayed(preNavigationDelay, () {
      Get.off(navigateTo);
    });
    await Future.delayed(postNavigationDelay, () {
      postNavigationCallback?.call();
    });
  }

  /// * Navigate to with a delay
  /// * [navigateTo]: Destination widget or screen
  /// * [preNavigationDelay]: Duration of delay before navigation
  /// * [postNavigationDelay]: Duration of delay after navigation
  /// * [preNavigationCallback]: Optional callback before navigation
  /// * [postNavigationCallback]: Optional callback after navigation
  static Future<void> toWithDelay({
    required Widget Function() navigateTo,
    Duration preNavigationDelay = const Duration(milliseconds: 300),
    Duration postNavigationDelay = const Duration(milliseconds: 300),
    VoidCallback? preNavigationCallback,
    VoidCallback? postNavigationCallback,
    Map<String, dynamic>? arguments,
  }) async {
    preNavigationCallback?.call();
    await Future.delayed(preNavigationDelay, () {
      Get.to(navigateTo, arguments: arguments);
    });
    await Future.delayed(postNavigationDelay, () {
      postNavigationCallback?.call();
    });
  }
}
