import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/paywall/secondary_paywall_screen.dart';

enum AppSwitchState { enabled, disabled, locked }

class AppSwitchOptions {
  final Function(bool)? onSwitchToggle;
  final bool switchValue;
  final AppSwitchState switchState;

  AppSwitchOptions({
    this.onSwitchToggle,
    this.switchValue = false,
    this.switchState = AppSwitchState.enabled,
  });
}

class AppSwitch extends StatelessWidget {
  final AppSwitchOptions options; // Accept options
  final String? lockIconPath; // Moved lockIconPath to AppSwitch
  final Color activeThumbColor;
  final Color inactiveThumbColor;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color disabledThumbColor;
  final Color disabledTrackColor;
  final Color lockedThumbColor;
  final Color lockedTrackColor;
  final Color thumbIconColor;
  final double width;
  final double height;
  final double thumbSize;
  final Duration animationDuration;

  const AppSwitch({
    Key? key,
    required this.options,
    this.lockIconPath,
    this.activeThumbColor = const Color(0xFFFFFFFF),
    this.inactiveThumbColor = const Color(0x4BFFFFFF),
    this.activeTrackColor = const Color(0xFF8E4EC6),
    this.inactiveTrackColor = const Color(0x0BFFFFFF),
    this.disabledThumbColor = const Color(0xFF333333),
    this.disabledTrackColor = const Color(0xFF1F1F1F),
    this.lockedThumbColor = const Color(0xFF333333),
    this.lockedTrackColor = const Color(0xFF1F1F1F),
    this.thumbIconColor = Colors.black,
    this.width = 40.0,
    this.height = 22.0,
    this.thumbSize = 18.0,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine colors based on state
    Color trackColor;
    Color thumbColor;

    switch (options.switchState) {
      case AppSwitchState.enabled:
        trackColor =
            options.switchValue ? activeTrackColor : inactiveTrackColor;
        thumbColor =
            options.switchValue ? activeThumbColor : inactiveThumbColor;
        break;
      case AppSwitchState.disabled:
        trackColor = disabledTrackColor;
        thumbColor = disabledThumbColor;
        break;
      case AppSwitchState.locked:
        trackColor = inactiveTrackColor;
        thumbColor = inactiveThumbColor;
        break;
    }

    // Calculate the available movement space for the thumb
    final double trackInnerWidth = width - thumbSize;

    return GestureDetector(
      onTap: options.switchState == AppSwitchState.locked
          ? () => NavigationUtil.toWithDelay(
              navigateTo: () => const SecondaryPaywall())
          : (options.switchState == AppSwitchState.enabled &&
                  options.onSwitchToggle != null)
              ? () => options.onSwitchToggle!(!options.switchValue)
              : null,
      child: AnimatedContainer(
        duration: animationDuration,
        width: width.w,
        height: height.h,
        padding: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
          color: trackColor,
        ),
        child: AnimatedAlign(
          alignment: options.switchValue
              ? Alignment.centerRight
              : Alignment.centerLeft,
          duration: animationDuration,
          child: Container(
            width: thumbSize.r,
            height: thumbSize.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: thumbColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: (options.switchState == AppSwitchState.locked)
                ? Center(
                    child: SvgPicture.asset(
                      lockIconPath ?? IconAllConstants.newLock01,
                      width: 12.r,
                      height: 12.r,
                      colorFilter: ColorFilter.mode(
                        thumbIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
