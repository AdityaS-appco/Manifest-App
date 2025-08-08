import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/theme/app_text_styles.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/import.dart';

enum IconAlignment { leading, trailing }

enum GradientDirection { topToBottom, leftToRight }

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.child,
    this.gradient,
    required this.onPressed,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.borderColor,
    this.borderWidth = 0.0,
    this.backgroundColorOpacity = 1.0,
    this.gradientDirection = GradientDirection.topToBottom,
  });

  factory GradientButton.text({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    List<Color>? gradient,
    BorderRadius? borderRadius,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 16),
    Color? borderColor,
    double borderWidth = 2.0,
    double backgroundColorOpacity = 1.0,
    GradientDirection? gradientDirection,
  }) {
    return GradientButton(
      key: key,
      gradient: gradient,
      onPressed: onPressed,
      borderRadius: borderRadius,
      padding: padding,
      borderColor: borderColor ?? Colors.white.withOpacity(0.05),
      borderWidth: borderWidth,
      backgroundColorOpacity: backgroundColorOpacity,
      gradientDirection: gradientDirection,
      child: Text(
        text,
        style: Get.appTextTheme.gradientButtonTextSmall.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  factory GradientButton.icon({
    Key? key,
    required String text,
    IconData? icon,
    String? svgIcon,
    required VoidCallback onPressed,
    List<Color>? gradient,
    IconAlignment iconAlignment = IconAlignment.leading,
    double? fontSize,
    FontWeight? fontWeight,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 16),
    Color? borderColor,
    double borderWidth = 0.0,
    double backgroundColorOpacity = 1.0,
    GradientDirection? gradientDirection,
    Color? foregroundColor,
  }) {
    return GradientButton(
      key: key,
      gradient: gradient,
      onPressed: onPressed,
      padding: padding,
      borderColor: borderColor,
      borderWidth: borderWidth,
      backgroundColorOpacity: backgroundColorOpacity,
      gradientDirection: gradientDirection,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconAlignment == IconAlignment.leading) ...[
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon,
                height: 20,
                width: 20,
                color: foregroundColor,
              )
            else
              Icon(icon, size: 20, color: foregroundColor),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: Get.appTextTheme.gradientButtonTextSmall.copyWith(
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.w400,
              color: foregroundColor,
            ),
          ),
          if (iconAlignment == IconAlignment.trailing) ...[
            const SizedBox(width: 8),
            Icon(icon, size: 18.r, color: foregroundColor),
          ],
        ],
      ),
    );
  }

  final List<Color>? gradient;
  final Widget child;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final double borderWidth;
  final double backgroundColorOpacity;
  final GradientDirection? gradientDirection;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient
                  ?.map((color) => color.withOpacity(backgroundColorOpacity))
                  ?.toList() ??
              AppColors.topLightToBottomDarkPurpleGradient
                  .map((color) => color.withOpacity(backgroundColorOpacity))
                  .toList(),
          begin: gradientDirection == GradientDirection.leftToRight
              ? Alignment.centerLeft
              : Alignment.topCenter,
          end: gradientDirection == GradientDirection.leftToRight
              ? Alignment.centerRight
              : Alignment.bottomCenter,
        ),
        borderRadius: (borderRadius ?? BorderRadius.circular(50)).r,
        border: Border.all(
            color: borderColor ?? Colors.transparent, width: borderWidth),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          minimumSize: Size(300.w, 35.h), 
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
