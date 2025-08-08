import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/scene_set_timer_for_outside_app_playback_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/chips/gradient_chip.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/sliders/volume_slider.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';

class SceneSettingsBottomsheet
    extends GetView<SceneSettingsBottomsheetController> {
  const SceneSettingsBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBottomSheet(
          title: "Explore",
          titlePadding: const EdgeInsets.only(left: 20),
          hasBackButton: false,
          backgroundColor: const Color(0xFF252525).withOpacity(0.7),
          blurAmount: 64,
          horizontalPadding: 0,
          primaryButtonText: "Save",
          onPrimaryButtonPressed: controller.onPrimaryButtonPressed,
          buttonsHorizontalPadding: 20,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// * Volume slider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildVolumeSlider(),
              ),

              27.height,

              /// * Play sound outside the app
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                child: _buildPlaySoundOutside(),
              ),

              26.height,

              /// * Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                    color: AppColors.light.withOpacity(0.1), thickness: 1),
              ),

              25.height,

              _buildTheme(),
            ],
          ),
        ),
        // Loading overlay when processing
        Obx(
          () => controller.isProcessing.value
              ? _buildLoadingOverlay()
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            dotsWaveLoading(),
            const SizedBox(height: 16),
            Text(
              'Generating theme...',
              style: helveticaPageTitleTextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTheme() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// * Theme selection
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: _buildThemeHeader(),
        ),

        16.height,

        /// * Theme filter buttons
        _buildThemeFilters(),

        24.height,

        /// * Scene preview grid
        _buildSceneList(),
      ],
    );
  }

  Widget _buildThemeHeader() {
    return Row(
      children: [
        SvgPicture.asset(
          IconAllConstants.palette,
          color: Colors.white.withOpacity(0.7),
          height: 22,
          width: 22,
        ),
        12.width,
        Text(
          "Theme",
          style: primaryWhiteHelveticaRoundedBoldTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Row _buildPlaySoundOutside() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              IconAllConstants.musicNote01,
              color: AppColors.light.withOpacity(0.6),
              height: 22.r,
            ),
            12.width,
            Text(
              AppStrings.playSoundsOutside,
              style: Get.appTextTheme.titleMediumRounded.copyWith(
                height: 1.56,
              ),
            ),
          ],
        ),
        15.width,
        InkWell(
          onTap: () {
            AppBottomSheet.show(
              SceneSetTimerForOutsideAppPlaybackBottomsheet(
                selectedDurationInMinutes:
                    controller.selectedDurationInMinutes.value,
                onSavePressed: (minutes) =>
                    controller.onTimerSelected(minutes!),
              ),
            );
          },
          splashColor: AppColors.light.withOpacity(0.2), // Splash effect color
          borderRadius:
              BorderRadius.circular(50), // Match the container's border radius
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.light.withOpacity(0.05),
              borderRadius: BorderRadius.circular(50),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 8.0).r,
            child: Row(
              children: [
                SvgPicture.asset(
                  IconAllConstants.clock,
                  color: AppColors.light.withOpacity(0.7),
                  height: 16.r,
                  width: 16.r,
                ),
                5.width,
                Obx(
                  () => Text(
                    controller.playSoundOutsideTimerString,
                    style: Get.appTextTheme.bodyLarge.copyWith(
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildVolumeSlider() {
    final volume = controller.volume.value.toDouble();
    return DividerSection.containered(
      containerColor: AppColors.light.withOpacity(0.1),
      children: [
        VolumeSlider(
          title: "Scene Volume",
          value: volume.toDouble(),
          onChanged: (value) => controller.updateVolume(value.toInt()),
        )
      ],
    );
  }

  Widget _buildThemeFilters() {
    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => 8.width,
        itemCount: controller.themeFilters.length,
        itemBuilder: (context, index) =>
            _buildFilterChip(controller.themeFilters[index], index),
      ),
    );
  }

  Widget _buildFilterChip(
    ThemeFilter filter,
    int index,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 20.r : 0,
        right: index == controller.themeFilters.length - 1 ? 20.r : 0,
      ),
      child: GradientChip(
        onTap: () => controller.onFilterChange(filter),
        isSelected: controller.selectedFilter.value?.id == filter.id,
        label: filter.name,
        horizontalPadding: 16,
        verticalPadding: 6,
        textStyle: Get.appTextTheme.chipTextlargeCompressed.copyWith(
          height: 1.43,
        ),
      ),
    );
  }

  Widget _buildSceneList() {
    return SizedBox(
      height: 241.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => 15.width,
        itemCount: controller.themeScenes.length,
        itemBuilder: (context, index) =>
            _buildSceneItem(controller.themeScenes[index], index),
      ),
    );
  }

  Widget _buildSceneItem(ThemeScene scene, int index) {
    return Obx(
      () {
        final isSelected = controller.selectedScene.value!.id == scene.id;
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 20.r : 0,
            right: index == controller.themeScenes.length - 1 ? 20.r : 0,
          ),
          child: Container(
            width: 120.w,
            padding: const EdgeInsets.all(2),
            height: double.infinity,
            child: GestureDetector(
              onTap: () => controller.selectScene(scene),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 213.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.light.withOpacity(0.8),
                                width: 2,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              )
                            : Border.all(
                                color: AppColors.light.withOpacity(0.1),
                              ),
                        image: DecorationImage(
                          image: AssetImage(scene.filePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: SvgPicture.asset(
                                IconAllConstants.musicEqualizer1,
                                color: AppColors.light,
                                height: 37,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                  10.height,
                  Text(
                    scene.name,
                    style: primaryWhiteHelveticaRoundedBoldTextStyle(
                      color: AppColors.light,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ThemeFilter {
  final int id;
  final String name;
  ThemeFilter({required this.id, required this.name});
}

class ThemeScene {
  final int id;
  final int themeId;
  final String name;
  final String? remoteImage;
  final String filePath;
  ThemeScene({
    required this.id,
    required this.themeId,
    required this.name,
    required this.filePath,
    this.remoteImage,
  });
}

class SceneSettingsBottomsheetController extends GetxController {
  final RxInt volume = 50.obs;
  final RxBool isMusicOn = true.obs;
  final Rx<ThemeFilter?> selectedFilter = Rx<ThemeFilter?>(null);
  final Rx<ThemeScene?> selectedScene = Rx<ThemeScene?>(null);
  final Rx<int?> selectedDurationInMinutes = Rx<int?>(null);
  final RxInt currentTimer = 5.obs;

  String get playSoundOutsideTimerString {
    if (currentTimer.value >= 60) {
      return '${(currentTimer.value / 60).floor()}hr';
    } else {
      return '${currentTimer.value}min';
    }
  }

  final RxBool isProcessing = false.obs;
  final ThemeController themeController = Get.find<ThemeController>();

  final themeFilters = [
    ThemeFilter(id: 1, name: 'All'),
    ThemeFilter(id: 2, name: 'Live'),
    ThemeFilter(id: 3, name: 'Scenery'),
    ThemeFilter(id: 4, name: 'Texture'),
    ThemeFilter(id: 5, name: 'Minimal'),
  ];

  final themeScenes = [
    ThemeScene(
        id: 1,
        themeId: 1,
        name: 'Nature',
        filePath: ImageConstants.nature,
        remoteImage:
            "https://media.istockphoto.com/id/841278554/photo/beautiful-morning-light-in-public-park-with-green-grass-field.jpg?s=2048x2048&w=is&k=20&c=uTnvpSjuE2ZYdqL6ERPsJ0WEcoCQqDLQJ7imKJ71134="),
    ThemeScene(
        id: 2,
        themeId: 2,
        name: 'Flower',
        filePath: ImageConstants.flower,
        remoteImage:
            "https://media.istockphoto.com/id/1394440950/photo/natural-view-cosmos-filed-and-sunset-on-garden-background.jpg?s=2048x2048&w=is&k=20&c=DKmnt46kVd9g2svZcEx9zJ2YXsrrRl612bm8OgH95oc="),
    ThemeScene(
        id: 3,
        themeId: 2,
        name: 'Daisy',
        filePath: ImageConstants.daisy,
        remoteImage:
            "https://media.istockphoto.com/id/1455172237/photo/lavender-at-sunrise.jpg?s=2048x2048&w=is&k=20&c=UGOShE7E013g7JmSsic-Csk26xp_I1FJMqisz7dzVnU="),
    ThemeScene(
        id: 4,
        themeId: 4,
        name: 'White Flower',
        filePath: ImageConstants.whiteFlower,
        remoteImage:
            "https://media.istockphoto.com/id/186238864/photo/white-daisies.jpg?s=2048x2048&w=is&k=20&c=dlrFWmJ21ZKwLLXVR2_U2pChmGaLizLbsyocWk_VpDU="),
    ThemeScene(
        id: 5,
        themeId: 5,
        name: 'Sunshine',
        filePath: ImageConstants.sunshine,
        remoteImage:
            "https://media.istockphoto.com/id/1137402783/photo/dandelion-in-field-at-sunset-air-and-blowing.jpg?s=2048x2048&w=is&k=20&c=0SQew96dq6GVyEvWbyrDqEUV18aHoe6M2jkaMgG4glE="),
  ];

  @override
  void onInit() {
    setDefaultThemeAndScene();
    super.onInit();
  }

  void setDefaultThemeAndScene() {
    selectedFilter.value = themeFilters.first;
    selectedScene.value = themeScenes.first;

    /// * rebuild the UI
    update();
  }

  List<ThemeScene> get filteredScenes => themeScenes
      .where((scene) => scene.themeId == selectedFilter.value?.id)
      .toList();

  void updateVolume(int value) {
    volume.value = value;
  }

  void toggleMusic() {
    isMusicOn.toggle();
  }

  void onFilterChange(ThemeFilter filter) {
    /// * select filter
    selectFilter(filter.id);

    /// * update scenes list
  }

  void selectFilter(int filterId) {
    selectedFilter.value =
        themeFilters.firstWhere((filter) => filter.id == filterId);
  }

  void selectScene(ThemeScene scene) {
    selectedScene.value = scene;
  }

  void onTimerSelected(int minutes) {
    selectedDurationInMinutes.value = minutes;
    currentTimer.value = minutes;
  }

  Future<void> handleChooseScene() async {
    isProcessing.value = true;

    try {
      // Generate theme from the selected image
      final success = await themeController
          .generateColorFromImage(selectedScene.value!.remoteImage!);

      if (success) {
        /// * close the choose scene bottomsheet
        Get.back();

        /// * show success snackbar
        ToastUtil.success('Scene and colors have been applied');
      } else {
        ToastUtil.error('Could not generate colors from this image');
      }
    } catch (e) {
      ToastUtil.error('Something went wrong while updating the theme');
    } finally {
      isProcessing.value = false;

      // // Close the bottomsheet
      // Get.back();
    }
  }

  void onPrimaryButtonPressed() async {
    // Save settings to storage and close the bottomsheet
    await handleChooseScene();
  }
}
