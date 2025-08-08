import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifest/core/theme/app_colors.dart';

/// * A custom widget that applies a gradient to an SVG icon
/// * [gradientColors] - List of colors to create the gradient
/// * [begin] - The beginning position of the gradient (default: Alignment.topLeft)
/// * [end] - The ending position of the gradient (default: Alignment.bottomRight)
/// * [icon] - The path to the SVG icon asset
/// * [iconSize] - The size of the icon (default: 24.r)
class GradientIcon extends StatelessWidget {
  final List<Color> gradientColors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final String icon;
  final double iconSize;

  const GradientIcon({
    super.key,
    required this.gradientColors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    required this.icon,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
          begin: begin,
          end: end,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: SvgPicture.asset(
        icon,
        width: iconSize.r,
        height: iconSize.r,
      ),
    );
  }

  /// * Factory constructor for creating a pastel gradient icon
  factory GradientIcon.pastel({
    required String icon,
    double iconSize = 24,
  }) {
    return GradientIcon(
      icon: icon,
      iconSize: iconSize,
      gradientColors: AppColors.pastelLinearGradient,
    );
  }

  /// * Factory constructor for creating a cool tones gradient icon
  factory GradientIcon.coolTones({
    required String icon,
    double iconSize = 24,
  }) {
    return GradientIcon(
      icon: icon,
      iconSize: iconSize,
      gradientColors: AppColors.customLinearGradient,
    );
  }

  /// * Factory constructor for creating a warm tones gradient icon
  factory GradientIcon.warmTones({
    required String icon,
    double iconSize = 24,
  }) {
    return GradientIcon(
      icon: icon,
      iconSize: iconSize,
      gradientColors: AppColors.pinkLinearGradient,
    );
  }
} 