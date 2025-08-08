import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifest/core/theme/app_text_styles.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';

/// * A reusable widget to display creator profile with image and name
/// * Used in playlist details, track details, etc.
class CreatorProfileTile extends StatelessWidget {
  const CreatorProfileTile({
    super.key,
    required this.imageUrl,
    required this.name,
    this.imageSize,
    this.imageBorderOpacity,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.spacing,
  });

  /// The URL of the creator's profile image
  final String imageUrl;

  /// The name of the creator
  final String name;

  /// Size of the profile image (both width and height)
  /// Defaults to 24.r
  final double? imageSize;

  /// Opacity of the image border
  /// Defaults to 0.1
  final double? imageBorderOpacity;

  /// Color of the creator name text
  /// Defaults to white with 0.8 opacity
  final Color? textColor;

  /// Font size of the creator name
  /// Defaults to 13.0
  final double? fontSize;

  /// Font weight of the creator name
  /// Defaults to FontWeight.w400
  final FontWeight? fontWeight;

  /// Spacing between image and text
  /// Defaults to 8.w
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Profile image
        Container(
          width: imageSize ?? 24.r,
          height: imageSize ?? 24.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(imageBorderOpacity ?? 0.05),
            ),
          ),
          child: AppCachedImage(
            imageUrl: imageUrl,
            borderRadius: BorderRadius.circular((imageSize ?? 24.r) / 2),
            errorImageSize: ((imageSize ?? 24) - 4).r,
          ),
        ),
        SizedBox(width: spacing ?? 10.w),

        /// Creator name
        Text(
          name.capitalizeFirst!,
          style: helveticaPageTitleTextStyle(
            fontSize: fontSize ?? 13.0,
            color: textColor ?? Colors.white.withOpacity(0.5),
            fontWeight: fontWeight ?? FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
