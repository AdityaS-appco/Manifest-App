import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';

/// * A reusable artwork image widget that can show either an image or a placeholder
/// * with optional editing functionality
class ArtworkImage extends StatelessWidget {
  final String? imageUrl;
  final bool isEditing;
  final double borderRadius;
  final VoidCallback? onEditTap;
  final double size;

  const ArtworkImage({
    super.key,
    this.imageUrl,
    this.isEditing = false,
    this.borderRadius = 15,
    this.onEditTap,
    this.size = 130,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Container
        Container(
          width: size.r,
          height: size.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius.r),
            gradient: LinearGradient(
              colors: AppColors.musicGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.05),
              width: 1,
            ),
          ),
          child: imageUrl != null
              ? AppCachedImage(
                  imageUrl: imageUrl!,
                  borderRadius: BorderRadius.circular(borderRadius.r),
                )
              : Center(
                  child: SvgPicture.asset(
                    IconAllConstants.musicNote01,
                    width: 58.r,
                    height: 58.r,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
        ),

        // Edit Button
        if (isEditing)
          Positioned(
            bottom: -8.r,
            right: -8.r,
            child: SvgCircleButton(
              IconAllConstants.camera01,
              buttonSize: 36,
              iconSize: 19,
              onPressed: onEditTap,
              enabledColor: AppColors.dark.withOpacity(0.15),
              borderColor: AppColors.light.withOpacity(0.1),
              iconColor: Colors.white,
              padding: const EdgeInsets.all(8),
              blurAmount: 30,
            ),
          ),
      ],
    );
  }
}
