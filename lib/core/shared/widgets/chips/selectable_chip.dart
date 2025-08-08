import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/utils/extensions/get_context.extension.dart';
import 'package:manifest/core/utils/extensions/responsive_sized_box.extension.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';

class SelectableChip extends StatelessWidget {
  const SelectableChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.emoji,
    this.emojiPath,
    this.networkImageUrl,
    this.selectedColor,
    this.unselectedColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.selectedTextStyle,
    this.textStyle,
    this.selectedTextColor = Colors.white,
    this.textColor,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.emojiSpacing,
    this.mainAxisAlignment,
    this.isGradient = false,
    this.fontSize = 16.0,
    this.selectedFontSize = 16.0,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? emoji;
  final String? emojiPath;
  final String? networkImageUrl;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? textStyle;
  final Color? selectedTextColor;
  final Color? textColor;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? emojiSpacing;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isGradient;
  final double fontSize;
  final double selectedFontSize;

  @override
  Widget build(BuildContext context) {
    // * Calculate horizontal padding based on label length and emoji presence
    final hasEmoji = (emoji != null && emoji!.isNotEmpty) ||
        (emojiPath != null && emojiPath!.isNotEmpty) ||
        (networkImageUrl != null && networkImageUrl!.isNotEmpty);
    final effectiveHorizontalPadding =
        !hasEmoji && label.length <= 3 ? 16.0 : (horizontalPadding ?? 16.0);

    return GestureDetector(
      onTap: onTap,
      child: BlurContainer(
        blurAmount: 30,
        borderRadius: BorderRadius.circular((borderRadius ?? 25).r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: effectiveHorizontalPadding.r,
            vertical: (verticalPadding ?? 12).r,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? isGradient
                    ? null
                    : selectedColor ?? Colors.white.withOpacity(0.1)
                : unselectedColor ?? Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular((borderRadius ?? 25).r),
            border: Border.all(
              color: isSelected
                  ? isGradient
                      ? Colors.transparent
                      : selectedBorderColor ?? Colors.white
                  : unselectedBorderColor ?? Colors.white.withOpacity(0.05),
              width: 1.0,
            ),
            gradient: isSelected
                ? isGradient
                    ? LinearGradient(
                        colors: AppColors.topLightToBottomDarkPurpleGradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null
                : null,
          ),
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Network image (highest priority)
              if (networkImageUrl != null && networkImageUrl!.isNotEmpty) ...[
                AppCachedImage(
                  imageUrl: networkImageUrl!,
                  width: 20,
                  height: 20,
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Colors.transparent,
                  errorImageSize: 18.r,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: (emojiSpacing ?? 8).w),
              ]
              // SVG asset (second priority)
              else if (emojiPath != null && emojiPath != '') ...[
                SvgPicture.asset(emojiPath!, width: 20.r, height: 20.r),
                SizedBox(width: (emojiSpacing ?? 8).w),
              ]
              // Emoji (third priority)
              else if (emoji != null && emoji != '') ...[
                Text(
                  emoji!,
                  style: textStyle?.copyWith(fontSize: 14) ??
                      const TextStyle(
                        fontSize: 16,
                      ),
                ),
                SizedBox(width: (emojiSpacing ?? 8).w),
              ],
              Text(
                label.toString().capitalizeFirst!,
                style: (isSelected ? selectedTextStyle : textStyle) ??
                    Get.appTextTheme.chipTextLarge,
              ),
              if (hasEmoji) 4.width,
            ],
          ),
        ),
      ),
    );
  }
}
