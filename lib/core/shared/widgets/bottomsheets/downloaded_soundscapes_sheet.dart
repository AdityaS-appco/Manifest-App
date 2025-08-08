import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/soundscape_list_sheet.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/loading_wrapper.dart';
import 'package:manifest/core/shared/widgets/touch_splash.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/downloaded_soundscape.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/downloaded_soundscapes_controller.dart';

class DownloadedSoundscapesSheet
    extends GetView<DownloadedSoundscapesController> {
  final Function(DownloadedSoundscape) onSoundscapePlay;

  const DownloadedSoundscapesSheet({super.key, required this.onSoundscapePlay});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      customHeader: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Soundscapes", style: Get.appTextTheme.headingLargeRounded),
            SvgCircleButton(
              IconAllConstants.xClose,
              onPressed: () => NavigationUtil.backWithDelay(),
            )
          ],
        ),
      ),
      hasBackButton: false,
      backgroundColor: AppColors.dark,
      blurAmount: 10,
      showDragHandle: true,
      topPadding: 0.r,
      horizontalPadding: 16.r,
      contentPadding: EdgeInsets.zero,
      body: SizedBox(
        height: 0.7.sh,
        child: Obx(() => LoadingWrapper(
              isInitialLoading: RxBool(false),
              isLoading: RxBool(false),
              child: _buildSoundscapeGrid(),
            )),
      ),
    );
  }

  Widget _buildAddMoreCard() {
    return Column(
      children: [
        TouchSplash(
          onPressed: () {
            AppBottomSheet.show(
              const SoundscapeListSheet(),
            );
          },
          borderRadius: BorderRadius.circular(10.0.r),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          color: Colors.white.withOpacity(0.1),
          child: BlurContainer(
            height: 148.h,
            width: 107.33.w,
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(10.0.r),
            child: TransparentSvgCircleButton(
              IconAllConstants.add1,
              iconSize: 24.r,
              iconColor: Colors.white,
            ),
          ),
        ),
        15.height,
        Text(
          'Add More',
          style: primaryWhiteHelveticaRoundedBoldTextStyle(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        )
      ],
    );
  }

  Widget _buildSoundscapeGrid() {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.55,
        ),
        itemCount: controller.downloadedSoundscapes.length + 1,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == controller.downloadedSoundscapes.length) {
            return _buildAddMoreCard();
          }
          final downloadedSoundscape = controller.downloadedSoundscapes[index];
          return _buildSoundscapeCard(downloadedSoundscape);
        },
      ),
    );
  }

  Widget _buildSoundscapeCard(DownloadedSoundscape soundscape) {
    return TouchSplash(
      onPressed: () => controller.onSoundscapeTap(soundscape),
      onLongPress: () {
        AppBottomSheet.show(
          CustomBottomSheet(
            hasBackButton: false,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppListTile.playerSettingHeader(
                  artworkUrl: soundscape.artCover,
                  title: soundscape.name?.capitalize ?? '',
                  subtitle: 'Downloaded Soundscape',
                  contentPadding: EdgeInsets.symmetric(horizontal: 30.r),
                ),
                18.height,
                AppListTile.playerSettingOption(
                  title: "Play Now",
                  iconPath: IconAllConstants.play,
                  onTap: () {
                    Get.back();
                    NavigationUtil.backWithDelay(
                      postNavigationCallback: () {
                        onSoundscapePlay(soundscape);
                      },
                    );
                  },
                  iconColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
                ),
                AppListTile.playerSettingOption(
                  title: "Remove from Downloads",
                  iconPath: IconAllConstants.trash03,
                  onTap: () {
                    NavigationUtil.backWithDelay(
                      postNavigationCallback: () {
                        controller.removeSoundscapeFromDownloads(soundscape);
                      },
                    );
                  },
                  iconColor: AppColors.danger,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
                ),
              ],
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10.0.r),
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Column(
        children: [
          SizedBox(
            height: 148.h,
            child: Obx(
              () {
                final isLoading = controller.isCurrentlyLoading(soundscape);
                final isPlaying = controller.isCurrentlyPlaying(soundscape);
                return Stack(
                  children: [
                    AppCachedImage(
                      width: double.infinity,
                      height: double.infinity,
                      imageUrl: soundscape.artCover,
                      borderRadius: BorderRadius.circular(10.0.r),
                      border: isPlaying.value
                          ? Border.all(
                              color: Colors.white,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignInside,
                            )
                          : Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                    ),
                    if (isLoading.value)
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 0.8,
                            ),
                          ),
                        ),
                      ),
                    if (isPlaying.value)
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 38,
                              height: 25,
                              child: dotsWavePlaying(),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          15.height,
          Text(
            soundscape.name?.trim().capitalize ?? "Unknown",
            style: primaryWhiteHelveticaRoundedBoldTextStyle(
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
