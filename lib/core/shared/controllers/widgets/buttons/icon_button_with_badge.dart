import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';

/// * A circular icon button with optional badge value or widget
class IconButtonWithBadge extends StatelessWidget {
  final String svgPath;
  final VoidCallback? onTap;
  final bool isEnabled;
  final String? badgeValue;
  final Widget? badgeWidget;
  final double? buttonSize;
  final double? iconSize;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? iconColor;
  final Color? borderColor;
  final double? badgeTop;
  final double? badgeBottom;
  final double? badgeRight;
  final double? badgeLeft;
  final EdgeInsets? padding;

  const IconButtonWithBadge({
    super.key,
    required this.svgPath,
    this.onTap,
    this.isEnabled = true,
    this.badgeValue,
    this.badgeWidget,
    this.buttonSize,
    this.iconSize,
    this.enabledColor,
    this.disabledColor,
    this.iconColor,
    this.borderColor,
    this.badgeTop,
    this.badgeBottom,
    this.badgeRight,
    this.badgeLeft,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgCircleButton(
          svgPath,
          buttonSize: buttonSize,
          padding: padding,
          iconSize: iconSize,
          onPressed: onTap,
          isEnabled: isEnabled,
          enabledColor: enabledColor,
          disabledColor: disabledColor,
          iconColor: iconColor,
          borderColor: borderColor,
        ),
        if (badgeValue != null && badgeValue!.isNotEmpty)
          Positioned(
            top: badgeTop ?? -8.r,
            bottom: badgeBottom,
            right: badgeRight ?? -8.r,
            left: badgeLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 2.r),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: (badgeValue == 'infinite')
                  ? TransparentSvgCircleButton(
                      IconAllConstants.infinity,
                      padding: EdgeInsets.zero,
                      iconColor: Colors.white,
                      iconSize: 14.r,
                    )
                  : Text(
                      badgeValue!,
                      style: bodyTextStyle(
                        fontSize: 10,
                        color: AppColors.light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
      ],
    );
  }
}
