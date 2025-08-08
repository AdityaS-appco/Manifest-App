import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

class AppCachedImage extends StatelessWidget {
  final String? imageUrl;
  final ImageData? image;
  final double? height;
  final double? width;
  final Border? border;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? errorImageSize;
  final BoxFit fit;
  final bool isGradient;

  const AppCachedImage({
    super.key,
    this.imageUrl,
    this.image,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.backgroundColor,
    this.errorImageSize,
    this.fit = BoxFit.cover,
    this.isGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    // If both imageUrl and image are null, return error widget
    if (imageUrl == null && image == null) {
      return _buildErrorWidget();
    }

    // If no imageUrl is provided, use the image from imageMeta
    final String? effectiveImageUrl = imageUrl ?? image?.imageName;

    // If effective image URL is null or empty, return error widget
    if (effectiveImageUrl == null || effectiveImageUrl.isEmpty) {
      return _buildErrorWidget();
    }

    // Create common placeholder widget
    Widget placeholderWidget = Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white38,
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        ),
        child: const Center(
          child: SizedBox(
            height: 26.0,
            width: 26.0,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 0.4,
            ),
          ),
        ),
      ),
    );

    // Create common error widget
    Widget errorWidget = _buildErrorWidget();

    // Create container with gradient border decoration
    Widget createDecoratedContainer({required ImageProvider imageProvider}) {
      return SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
          child: image != null
              ? CroppedImage(
                  imageMeta: image!,
                  width: width,
                  height: height,
                  fit: fit,
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius ?? BorderRadius.circular(12.0),
                    border: isGradient
                        ? GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: AppColors.rainbowGradient,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            width: border?.dimensions.horizontal ?? 1,
                          )
                        : border,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit,
                    ),
                  ),
                ),
        ),
      );
    }

    final imageType = getImageType(effectiveImageUrl);

    // Switch based on image type
    switch (imageType) {
      case ImageType.network:
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: CachedNetworkImage(
            key: ValueKey(effectiveImageUrl),
            height: height,
            width: width,
            fit: BoxFit.cover,
            imageUrl: effectiveImageUrl.toString(),
            imageBuilder: (context, imageProvider) => createDecoratedContainer(
              imageProvider: imageProvider,
            ),
            placeholder: (context, url) => placeholderWidget,
            errorWidget: (context, url, error) => errorWidget,
          ),
        );
      case ImageType.asset:
        try {
          final imageProvider = AssetImage(effectiveImageUrl);
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: createDecoratedContainer(imageProvider: imageProvider),
          );
        } catch (e) {
          return errorWidget;
        }
      case ImageType.file:
        try {
          if (effectiveImageUrl.isEmpty ||
              !File(effectiveImageUrl).existsSync()) {
            return errorWidget;
          } else {
            final imageProvider = FileImage(File(effectiveImageUrl));
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: createDecoratedContainer(imageProvider: imageProvider),
            );
          }
        } catch (e) {
          return errorWidget;
        }
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white38,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
      ),
      child: Icon(
        Icons.broken_image_rounded,
        color: Colors.white.withOpacity(0.4),
        size: errorImageSize ?? 26.0,
      ),
    );
  }
}

class CroppedImage extends StatelessWidget {
  final ImageData imageMeta;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CroppedImage({
    super.key,
    required this.imageMeta,
    this.width = 0,
    this.height = 0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final crop = imageMeta.transformations.data.crop;
    final naturalWidth = imageMeta.transformations.data.naturalWidth;
    final naturalHeight = imageMeta.transformations.data.naturalHeight;
    final scaleX = imageMeta.transformations.data.scaleX;
    final scaleY = imageMeta.transformations.data.scaleY;
    final rotation = imageMeta.transformations.data.rotate;

    // Convert pixel crop to fractional values
    final cropLeft = crop.x / naturalWidth;
    final cropTop = crop.y / naturalHeight;
    final cropWidth = crop.width / naturalWidth;
    final cropHeight = crop.height / naturalHeight;

    // Parse aspect ratio string, fallback to 1.0
    double aspectRatio = 1.0;
    final ratioParts = imageMeta.ratio.split(':');
    if (ratioParts.length == 2) {
      final w = double.tryParse(ratioParts[0]) ?? 1.0;
      final h = double.tryParse(ratioParts[1]) ?? 1.0;
      aspectRatio = w / h;
    }

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: FractionallySizedBox(
        widthFactor: 1 / cropWidth,
        heightFactor: 1 / cropHeight,
        alignment: Alignment(
          -1.0 + (cropLeft * 2) + cropWidth,
          -1.0 + (cropTop * 2) + cropHeight,
        ),
        child: ClipRect(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..scale(scaleX, scaleY.toDouble())
              ..rotateZ(rotation * math.pi / 180), // degrees to radians
            child: Image.network(
              imageMeta.imageName,
              fit: fit,
              width: width?.w,
              height: height?.h,
            ),
          ),
        ),
      ),
    );
  }
}
