import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';

class DynamicColorScaffold extends StatelessWidget {
  final String? imageUrl;
  final ImageData? image;
  final double? imageHeight;
  final double? transparentSpaceForImageVisibilityHeight;
  final double? extraSpaceAtTopOfPlaylistHeader;
  final List<Widget>? playlistHeaderChildren;
  final List<Widget>? contentChildren;
  final double? extraSpaceAtBottomOfPlaylistHeader;
  final Widget? bottomSheet;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? headerPadding;
  final ColorExtractorController colorExtractor;
  final bool hasBackButton;
  final Widget? leading;
  final RxBool isLoading;

  DynamicColorScaffold({
    super.key,
    this.imageUrl,
    this.image,
    this.imageHeight,
    this.transparentSpaceForImageVisibilityHeight,
    this.extraSpaceAtTopOfPlaylistHeader,
    this.playlistHeaderChildren,
    this.extraSpaceAtBottomOfPlaylistHeader,
    this.contentChildren,
    this.bottomSheet,
    this.actions,
    this.contentPadding,
    this.headerPadding,
    this.hasBackButton = false,
    this.leading,
    required this.colorExtractor,
    required this.isLoading,
  }) {
    if (imageUrl != null) {
      switch (getImageType(imageUrl!)) {
        case ImageType.network:
          colorExtractor.extractColorsFromNetworkImage(imageUrl!);
          break;
        case ImageType.asset:
          if (imageUrl!.isNotEmpty) {
            colorExtractor.extractColorsFromAssetImage(imageUrl!);
          }
          break;
        case ImageType.file:
          colorExtractor.extractColorsFromFileImage(imageUrl!);
          break;
        default:
      }
    } else if (image != null) {
      colorExtractor.extractColorsFromNetworkImage(image!.imageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final appBarOpacity = ValueNotifier<double>(0.0);

    /// Throttle scroll updates for better performance
    var lastUpdate = DateTime.now();

    scrollController.addListener(() {
      final now = DateTime.now();
      if (now.difference(lastUpdate) < const Duration(milliseconds: 16))
        return; // ~60fps
      lastUpdate = now;

      if (scrollController.offset >= 267.h - 50.h) {
        final opacity =
            ((scrollController.offset - 267.h + 50.h) / 50.h).clamp(0.0, 1.0);
        appBarOpacity.value = opacity;
      } else {
        appBarOpacity.value = 0.0;
      }
    });

    return Obx(
      () {
        isLoading.value; // trigger rebuild
        return Scaffold(
          backgroundColor: (isLoading.value || colorExtractor.isExtracting.value)
              ? AppColors.appBG
              : (colorExtractor.dominantColor.value ?? AppColors.appBG),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading.value || colorExtractor.isExtracting.value
                ? Center(
                    child: dotsWaveLoading(),
                  )
                : Stack(
                    children: [
                      /// * Layer 1 - Background Image (431.h height)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: imageHeight ?? 451.h,
                        child: AppCachedImage(
                          image: image,
                          imageUrl: imageUrl,
                          backgroundColor: AppColors.appBG,
                          borderRadius: BorderRadius.zero,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// * Layer 2 - Content with gradient sections
                      SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            /// Row 1: Transparent space for image visibility
                            SizedBox(
                                height:
                                    transparentSpaceForImageVisibilityHeight ??
                                        267.h),

                            /// Row 2: Playlist header with gradient background
                            Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  color: AppColors.appBG,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      (colorExtractor.dominantColor.value ??
                                              AppColors.appBG)
                                          .withOpacity(0.0001),
                                      (colorExtractor.dominantColor.value ??
                                              AppColors.appBG)
                                          .withOpacity(0.5),
                                      colorExtractor.dominantColor.value ??
                                          AppColors.appBG,
                                    ],
                                    stops: const [0.0, 0.6, 1.0],
                                  ),
                                ),
                                padding: headerPadding ??
                                    EdgeInsets.symmetric(horizontal: 25.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (extraSpaceAtTopOfPlaylistHeader ?? 102)
                                        .toInt()
                                        .height,
                                    ...playlistHeaderChildren ?? [],
                                    (extraSpaceAtBottomOfPlaylistHeader ?? 15)
                                        .toInt()
                                        .height,
                                  ],
                                ),
                              ),
                            ),

                            /// Row 3: Content with dark background
                            Obx(
                              () => Transform.translate(
                                offset: const Offset(0, -1),
                                child: Container(
                                  color: colorExtractor.dominantColor.value ??
                                      AppColors.appBG,
                                  padding: contentPadding ??
                                      EdgeInsets.symmetric(horizontal: 25.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...contentChildren ?? [],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// * Layer 3 - AppBar with animated background
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: ValueListenableBuilder<double>(
                          valueListenable: appBarOpacity,
                          builder: (context, opacity, child) =>
                              AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            child: Obx(
                              () => AppBar(
                                backgroundColor:
                                    (colorExtractor.dominantColor.value ??
                                            AppColors.appBG)
                                        .withOpacity(opacity),
                                elevation: opacity > 0 ? 4 : 0,
                                automaticallyImplyLeading: false,
                                leading: leading ??
                                    (hasBackButton
                                        ? IconButton(
                                            onPressed: () => Get.back(),
                                            icon: SvgPicture.asset(
                                              IconAllConstants.arrowLeft,
                                              width: 24.r,
                                              height: 24.r,
                                            ),
                                          )
                                        : null),
                                actions: actions,
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// * Bottom player bar if playing
                      if (bottomSheet != null)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: bottomSheet,
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
