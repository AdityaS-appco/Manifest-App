import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/constants/assets/image_constants.dart';
import 'package:manifest/core/shared/widgets/custom_premium_banner.dart';
import 'package:manifest/core/utils.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPremiumBanner(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/logo/manifest_plus_logo.svg',
                height: 32.h,
              ),
              8.height,
              Text(
                'Unlock all the contents\n& features with 7 day trial.',
                style: TextStyle(
                  color: AppColors.light.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          _buildSubscribeButton(),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return Container(
      width: 106,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: AppColors.premiumGradient,
          ),
          width: 1.5,
        ),
      ),
      child: const Center(
        child: Text(
          'Subscribe',
          style: TextStyle(
            color: AppColors.premiumDark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
