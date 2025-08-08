import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/collection_overlay_menu.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/media_player_components/media_player_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/media_player_components/player_bottom_navbar.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/collection_audio_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/collection_detail_screen_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/create_new_collections/add_affirmations_to_collection.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/divider_widget.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import '../../../../../../helper/icons_and_images_path.dart';
import 'package:manifest/helper/import.dart';

class CollectionDetailScreen extends GetView<CollectionDetailScreenController> {
  const CollectionDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // Initialize the CollectionAudioController
    final audioController = Get.put(CollectionAudioController());

    return Container(
      color: appBackgroundColor,
      child: Obx(
        () => controller.isLoading.value && controller.collection.value == null
            ? Center(child: dotsWaveLoading())
            : Stack(
                children: [
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                      actions: [
                        Obx(() => Row(
                              children: [
                                !controller.isEditingEnabled.value
                                    ? CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          controller.toggleEditing(true);
                                        },
                                        child: Text(
                                          'Edit',
                                          style: customTextStyle(
                                            letterSpacing: 1.0,
                                            color: kWhiteColor,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: controller.saveEdits,
                                        child: Text(
                                          'Done',
                                          style: customTextStyle(
                                            letterSpacing: 1.0,
                                            color: kWhiteColor,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                8.width,
                                !controller.isEditingEnabled.value
                                    ? GestureDetector(
                                        onTap: () {
                                          AppDialogs.showBlurred(
                                            CollectionOverlayMenu(
                                              collection:
                                                  controller.collection.value!,
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0),
                                          child: Icon(
                                            Icons.more_horiz,
                                            color: kWhiteColor,
                                          ),
                                        ),
                                      )
                                    : 8.width,
                              ],
                            ))
                      ],
                    ),
                    body: controller.collection.value!.affirmations!.isNotEmpty
                        ? ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              12.height,
                              SizedBox(
                                height: kSize.height * 0.40,
                                width: double.infinity,
                                child: AppCachedImage(
                                  borderRadius: BorderRadius.zero,
                                  imageUrl: controller.collection.value!.image
                                      .toString(),
                                ),
                              ),
                              22.height,
                              Obx(() => !controller.isEditingEnabled.value
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                controller.collection.value!
                                                    .name!.capitalize
                                                    .toString(),
                                                style: customTextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w700,
                                                    color: kWhiteColor),
                                              ),
                                              if (controller
                                                  .isEditingEnabled.value)
                                                CupertinoButton(
                                                    onPressed: () {},
                                                    padding: EdgeInsets.zero,
                                                    child: showSvgIconWidget(
                                                        iconPath:
                                                            AppIcons.edit)),
                                            ],
                                          ),
                                          4.height,
                                          Text(
                                            '${controller.collection.value!.affirmationsCount.toString()} affirmations | ${controller.collection.value!.totalAffirmationsDuration.toString()}',
                                            style: customTextStyle(
                                                fontSize: 13.0,
                                                color: descriptionColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          10.height,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  // Timer Button
                                                  Obx(
                                                    () => SvgCircleButton(
                                                      IconConstants.audioTimer,
                                                      padding: EdgeInsets.zero,
                                                      isEnabled: audioController
                                                          .isPlayerStopTimerActive
                                                          .value,
                                                      onPressed: audioController
                                                          .onTimerPressed,
                                                    ),
                                                  ),
                                                  12.width,
                                                  // Loop Button
                                                  Obx(
                                                    () => Stack(
                                                      children: [
                                                        SvgCircleButton(
                                                          IconConstants
                                                              .audioReplay,
                                                          isEnabled:
                                                              audioController
                                                                  .isLoopEnabled
                                                                  .value,
                                                          onPressed:
                                                              audioController
                                                                  .toggleLoopMode,
                                                        ),
                                                        if (audioController
                                                                    .loopCount
                                                                    .value >
                                                                0 &&
                                                            audioController
                                                                .isLoopEnabled
                                                                .value)
                                                          Positioned.fill(
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 20,
                                                            left: 20,
                                                            child:
                                                                SizedBox.shrink(
                                                              child: Container(
                                                                width: 30.0,
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .primary,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    '${audioController.loopCount.value}',
                                                                    style:
                                                                        secondaryWhiteTextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  12.width,
                                                  // Favorites Button
                                                  Obx(
                                                    () => SvgCircleButton(
                                                      IconConstants
                                                          .favoriteOutlined,
                                                      isEnabled: audioController
                                                          .isCollectionFavorite
                                                          .value,
                                                      onPressed: audioController
                                                          .toggleFavoriteCollection,
                                                    ),
                                                  ),
                                                  12.width,
                                                  // Download Button
                                                  Obx(
                                                    () => SvgCircleButton(
                                                      audioController
                                                              .isCollectionDownloaded
                                                              .value
                                                          ? IconConstants
                                                              .downloaded
                                                          : IconConstants
                                                              .download,
                                                      isEnabled: audioController
                                                          .isCollectionDownloaded
                                                          .value,
                                                      onPressed: audioController
                                                          .downloadCollection,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Main Play/Pause Button
                                              Obx(
                                                () => MediaPlayerButton(
                                                  buttonSize: 50.h,
                                                  iconColor: AppColors.dark,
                                                  isPlayPause: true,
                                                  isPlaying: audioController
                                                      .isPlayingAffirmation,
                                                  onPlay: audioController
                                                      .toggleCollectionPlayPause,
                                                  onPause: audioController
                                                      .toggleCollectionPlayPause,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      child: Form(
                                        key: formKey,
                                        child: TextFormField(
                                          autocorrect: true,
                                          cursorColor: Colors.white60,
                                          style: customTextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                            letterSpacing: 0.2,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter new name',
                                            hintStyle: customTextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w500),
                                            contentPadding: EdgeInsets.zero,
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white60)),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (String value) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              log('User submitted: $value');
                                            }
                                          },
                                          validator:
                                              FormValidatorUtil.playlistName,
                                        ),
                                      ),
                                    )),
                              10.height,
                              customDivider(thickNess: 0.3),
                              10.height,
                              ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .collection.value!.affirmations!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      color:
                                          Color.fromRGBO(235, 235, 245, 0.16),
                                      indent: 40,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String formattedIndex =
                                        (index + 1).toString().padLeft(2, '0');
                                    var item = controller
                                        .collection.value!.affirmations![index];
                                    return ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: Text(
                                          formattedIndex,
                                          style: customTextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w400,
                                            color: lightGreyColor,
                                          ),
                                        ),
                                        title: Text(
                                          item.title.toString(),
                                          style: customTextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                              color: lightGreyColor,
                                              letterSpacing: 0.4),
                                        ),
                                        subtitle: Text(
                                          item.affirmationDuration ?? '00:00',
                                          style: customTextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w400,
                                              color: descriptionColor,
                                              letterSpacing: 0.4),
                                        ),
                                        trailing: Obx(
                                          () => !controller
                                                  .isEditingEnabled.value
                                              ? CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    audioController
                                                        .toggleSingleAffirmationPlayPause(
                                                            item.id!);
                                                  },
                                                  child: Icon(
                                                      audioController
                                                                  .isPlayingAffirmation
                                                                  .value &&
                                                              audioController
                                                                      .currentlyPlayingAffirmation
                                                                      .value
                                                                      ?.id ==
                                                                  item.id
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 25))
                                              : CupertinoButton(
                                                  onPressed: () async {
                                                    log('affirmation removing.....');
                                                    // Add code to remove affirmation
                                                  },
                                                  padding: EdgeInsets.zero,
                                                  child: showSvgIconWidget(
                                                      iconPath: AppIcons
                                                          .deleteDownload)),
                                        ));
                                  }),
                              68.height,
                            ],
                          )
                        : ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              AppCachedImage(
                                imageUrl: controller.collection.value!.image
                                    .toString(),
                                height: kSize.height * 0.40,
                                width: double.infinity,
                                borderRadius: BorderRadius.zero,
                              ),
                              22.height,
                              Obx(() => !controller.isEditingEnabled.value
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22),
                                      child: Row(
                                        children: [
                                          Text(
                                            controller.collection.value!.name!
                                                .capitalize
                                                .toString(),
                                            style: customTextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                                color: kWhiteColor),
                                          ),
                                          if (controller.isEditingEnabled.value)
                                            CupertinoButton(
                                                onPressed: () {},
                                                padding: EdgeInsets.zero,
                                                child: showSvgIconWidget(
                                                    iconPath: AppIcons.edit))
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      child: Form(
                                        key: formKey,
                                        child: TextFormField(
                                          autocorrect: true,
                                          cursorColor: Colors.white60,
                                          style: customTextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                            letterSpacing: 0.2,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter new name',
                                            hintStyle: customTextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w500),
                                            contentPadding: EdgeInsets.zero,
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white60)),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (String value) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              log('User submitted: $value');
                                            }
                                          },
                                          validator:
                                              FormValidatorUtil.playlistName,
                                        ),
                                      ),
                                    )),
                              Gap(kSize.height * 0.06),
                              if (controller.isEditingEnabled.value)
                                Text(
                                    'Click on the add button to add new\n affirmations to the collection list',
                                    style: customTextStyle(
                                        fontSize: 16.0, color: lightGreyColor),
                                    textAlign: TextAlign.center),
                              Gap(kSize.height * 0.04),
                              if (controller.isEditingEnabled.value)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: lightGreyColor, width: 1.0),
                                      ),
                                      child: Center(
                                          child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        borderRadius: BorderRadius.circular(50),
                                        onPressed: () {
                                          Get.bottomSheet(
                                            AddAffirmationsToCollections(
                                              createdCollectionID: controller
                                                  .collection.value!.id,
                                            ),
                                            isScrollControlled: true,
                                            enableDrag: true,
                                            enterBottomSheetDuration:
                                                const Duration(
                                                    milliseconds: 500),
                                          );
                                        },
                                        child: const Icon(Icons.add,
                                            color: Colors.white),
                                      )),
                                    ),
                                    15.width,
                                    Text(
                                      'Add',
                                      style: secondaryWhiteTextStyle(
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                  ),
                  // Bottom player mini-bar
                  Obx(() => Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildPlayerBottomNavbar(audioController),
                      )),
                ],
              ),
      ),
    );
  }

  // Build the bottom player navigation bar
  Widget? _buildPlayerBottomNavbar(CollectionAudioController audioController) {
    if (!audioController.isPlayingAffirmation.value) return null;

    return PlayerBottomNavbar(
      coverImage: controller.collection.value?.image ?? '',
      title: audioController.currentlyPlayingAffirmation.value?.title ??
          'No Title',
      subtitle: audioController
              .currentlyPlayingAffirmation.value?.affirmationDuration ??
          '',
      isPlaying: audioController.isPlayingAffirmation,
      onPlay: audioController.toggleCollectionPlayPause,
      onPause: audioController.toggleCollectionPlayPause,
      showProgress: true,
      progress: audioController.totalDuration.value > 0
          ? audioController.currentDuration.value /
              audioController.totalDuration.value
          : 0,
    );
  }
}
