import 'package:flutter/material.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/helper/import.dart';

class GradientChip extends StatelessWidget {
  /// The text to display inside the chip
  final String label;

  /// Whether the chip is selected
  final bool isSelected;

  /// Callback when the chip is tapped
  final VoidCallback onTap;

  /// Gradient to use when selected (default is purple gradient)
  final LinearGradient? selectedGradient;

  /// Background color when not selected
  final Color? unselectedColor;

  /// Border color when not selected
  final Color? unselectedBorderColor;

  /// Text color
  final Color? textColor;

  /// Text style (color will be overridden by textColor if provided)
  final TextStyle? textStyle;

  /// Horizontal padding
  final double horizontalPadding;

  /// Vertical padding
  final double verticalPadding;

  /// Border radius
  final double borderRadius;

  const GradientChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedGradient,
    this.unselectedColor,
    this.unselectedBorderColor,
    this.textColor,
    this.textStyle,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 6.0,
    this.borderRadius = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default gradient if none provided
    final defaultGradient = LinearGradient(
      colors: AppColors.topLightToBottomDarkPurpleGradient,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    // Default text style merged with provided style
    final finalTextStyle = Get.appTextTheme.gradientChipText
        .copyWith(
          color: textColor ??
              (isSelected
                  ? AppColors.gradientChipActiveTextColor
                  : AppColors.gradientChipInactiveTextColor),
        )
        .merge(textStyle);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? null
              : unselectedColor ?? AppColors.light.withOpacity(0.05),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : unselectedBorderColor ?? AppColors.light.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: isSelected ? (selectedGradient ?? defaultGradient) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: finalTextStyle,
          ),
        ),
      ),
    );
  }
}
