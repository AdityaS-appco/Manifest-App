import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/constants/assets/image_constants.dart';
import 'package:manifest/core/utils.dart';

class CustomPremiumBanner extends StatelessWidget {
  const CustomPremiumBanner({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(ImageConstants.premiumGradientBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: AppColors.premiumGradient,
            ),
            width: 1.5,
          ),
          gradient: const LinearGradient(
              colors: [
                AppColors.premiumDark,
                Colors.transparent,
                Colors.transparent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0, 0.6, 1.0]),
        ),
        padding: const EdgeInsets.all(15),
        child: child,
      ),
    );
  }
}
