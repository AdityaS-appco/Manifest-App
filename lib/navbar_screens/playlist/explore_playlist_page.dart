import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/features/playlist/custom_playlist_overlay_menu.dart';
import 'package:manifest/helper/icons_and_images_path.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/divider_widget.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/view/navbar_screens/explore/explore_tabs/sound_scape/music_options_page.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import '../../../app_widgets/bottom_player_bar.dart';
import '../../../controllers/audio_controller.dart';
import '../../../controllers/audio_player_controller.dart';
import '../../../controllers/recent_played.dart';
import 'tabs/all/playlist/add_tracks_to_playlist.dart';
import 'package:manifest/core/utils/form_validator_util.dart';

class ExplorePlaylistPage extends StatelessWidget {
  const ExplorePlaylistPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    RecentTracksController recentTracksController =
        Get.put(RecentTracksController());

    PlaylistTabController c = Get.find<PlaylistTabController>();
    JustAudioPlayerController audioPlayerController =
        Get.put(JustAudioPlayerController());
    return Container(
        decoration: BoxDecoration(
          gradient: AppGradients.grayToGray,
        ),
        child: Obx(
          () => c.isLoading.value || c.playlistByID.data == null
              ? Center(child: dotsWaveLoading())
              : GetBuilder<AudioController>(
                  init: AudioController(),
                  builder: (audioController) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            c.setEditValue(value: false);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 16.0,
                          ),
                        ),
                        actions: [
                          Obx(() => c.playlistByID.data!.createdBy == 'A'
                              ? Row(
                                  children: [
                                    showSvgIconWidget(iconPath: AppIcons.share),
                                    const Gap(22),
                                    showSvgIconWidget(
                                        iconPath: AppIcons.addMusic),
                                    const Gap(22),
                                  ],
                                )
                              : Row(children: [
                                  c.isEdit.value == false
                                      ? CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            c.setEditValue(value: true);
                                          },
                                          child: Text('Edit',
                                              style: customTextStyle(
                                                  letterSpacing: 1.0,
                                                  color: kWhiteColor,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      : CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            c.setEditValue(value: false);
                                            c.setRenameEditValue(value: false);
                                            c.setRenameValue(value: false);
                                          },
                                          child: Text('Done',
                                              style: customTextStyle(
                                                  letterSpacing: 1.0,
                                                  color: kWhiteColor,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                  8.width,
                                  c.isEdit.value == false
                                      ? GestureDetector(
                                          onTap: () {
                                            // Get.to(() =>
                                            //     const PlaylistMusicOptions());
                                            return AppDialogs.showBlurred(
                                              CustomPlaylistOverlayMenu(
                                                coverImage: c
                                                    .playlistByID.data!.image
                                                    .toString(),
                                                titleText: c
                                                    .playlistByID.data!.name
                                                    .toString(),
                                                subtitleText:
                                                    '${c.playlistByID.data!.tracksCount.toString()} tracks | ${c.playlistByID.data!.tracksTotalDuration.toString()}',
                                                onEditCoverTap: () async {
                                                  showModalBottomSheet(
                                                    backgroundColor:
                                                        descriptionLightColor,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          ListTile(
                                                            horizontalTitleGap:
                                                                5,
                                                            leading: Icon(
                                                                Icons
                                                                    .photo_library,
                                                                size: 18,
                                                                color:
                                                                    kWhiteColor),
                                                            title: Text(
                                                              'Gallery',
                                                              style: customTextStyle(
                                                                  color:
                                                                      kWhiteColor),
                                                            ),
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);
                                                              // await profileCon.pikImage(
                                                              //     context:
                                                              //         context,
                                                              //     imageSource:
                                                              //         ImageSource
                                                              //             .gallery);
                                                            },
                                                          ),
                                                          ListTile(
                                                            horizontalTitleGap:
                                                                5,
                                                            leading: Icon(
                                                                Icons
                                                                    .camera_alt,
                                                                size: 18,
                                                                color:
                                                                    kWhiteColor),
                                                            title: Text(
                                                              'Camera',
                                                              style: customTextStyle(
                                                                  color:
                                                                      kWhiteColor),
                                                            ),
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);
                                                              // await profileCon.pikImage(
                                                              //     context:
                                                              //         context,
                                                              //     imageSource:
                                                              //         ImageSource
                                                              //             .camera);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                onAddTracksToPlaylistTap: () {
                                                  c.getListOfTracks(
                                                      needLoading: false);
                                                  Get.bottomSheet(
                                                    AddTracksToPlaylist(
                                                        playlistID: c
                                                            .playlistByID
                                                            .data!
                                                            .id
                                                            .toString()),
                                                    isScrollControlled: true,
                                                    enableDrag: true,
                                                    enterBottomSheetDuration:
                                                        const Duration(
                                                            milliseconds: 500),
                                                  );
                                                },
                                                onRenameTap: () =>
                                                    AppBottomSheet
                                                        .showNamingBottomSheet(
                                                  title: 'Rename Playlist',
                                                  existingTitle: c
                                                      .playlistByID.data!.name
                                                      .toString(),
                                                  onConfirm: (newName) async {
                                                    // await Get.find<
                                                    //         ByYouByAlokController>()
                                                    //     .renameMp3(mp3.id,
                                                    //         newName);

                                                    /// * close the rename bottom sheet
                                                    Get.back();

                                                    /// * close the options menu
                                                    Get.back();

                                                    /// * close the audio player
                                                    Get.back();
                                                  },
                                                ),
                                                onDeleteTap: () async {
                                                  await c.deleteCreatedPlaylist(
                                                      id: c
                                                          .playlistByID.data!.id
                                                          .toString());
                                                },
                                                onShareTap: () {},
                                                onDownloadTap: () {},
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
                                ])),
                        ],
                      ),
                      body: c.playlistByID.data!.tracks!.isNotEmpty
                          ? ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                12.height,
                                Container(
                                  height: kSize.height * 0.40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7.0),
                                      child: Image.network(
                                        c.playlistByID.data!.image.toString(),
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.darken,
                                        color: Colors.black45,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.white70,
                                            child: Center(
                                              child: Icon(Icons.error,
                                                  color: Colors.grey.shade600),
                                            ),
                                          );
                                        },
                                      )),
                                ),
                                18.height,
                                Obx(() => c.isRename == false
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  c.playlistByID.data!.name
                                                      .toString(),
                                                  style: customTextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: kWhiteColor),
                                                ),
                                                if (c.isEdit.value == true)
                                                  CupertinoButton(
                                                      onPressed: () {
                                                        c.setRenameValue(
                                                            value: true);
                                                      },
                                                      padding: EdgeInsets.zero,
                                                      child: showSvgIconWidget(
                                                          iconPath:
                                                              AppIcons.edit))
                                              ],
                                            ),
                                            4.height,
                                            Text(
                                              '${c.playlistByID.data!.tracksCount.toString()} tracks | ${c.playlistByID.data!.tracksTotalDuration.toString()}',
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(500),
                                                        color: const Color
                                                            .fromRGBO(
                                                            37, 37, 37, 0.55),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: showSvgIconWidget(
                                                            iconPath: AppIcons
                                                                .stopWatch),
                                                      ),
                                                    ),
                                                    12.width,
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(500),
                                                        color: const Color
                                                            .fromRGBO(
                                                            37, 37, 37, 0.55),
                                                      ),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          c.getListOfTracks(
                                                              needLoading:
                                                                  false);
                                                          Get.bottomSheet(
                                                            AddTracksToPlaylist(
                                                                playlistID: c
                                                                    .playlistByID
                                                                    .data!
                                                                    .id
                                                                    .toString()),
                                                            isScrollControlled:
                                                                true,
                                                            enableDrag: true,
                                                            enterBottomSheetDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                          );
                                                        },
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child:
                                                              showSvgIconWidget(
                                                                  iconPath:
                                                                      AppIcons
                                                                          .add),
                                                        ),
                                                      ),
                                                    ),
                                                    12.width,
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(500),
                                                        color: const Color
                                                            .fromRGBO(
                                                            37, 37, 37, 0.55),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: showSvgIconWidget(
                                                            iconPath: AppIcons
                                                                .downloadPlay),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                CircleAvatar(
                                                  radius: 25.0,
                                                  backgroundColor: kWhiteColor,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      audioPlayerController
                                                          .setPlaylist(c
                                                              .playlistByID
                                                              .data!
                                                              .tracks![0]
                                                              .trackAffirmations!
                                                              .file!);
                                                      recentTracksController
                                                          .addTrack(c
                                                              .playlistByID
                                                              .data!
                                                              .tracks![0]);
                                                    },
                                                    icon: Icon(
                                                      audioPlayerController
                                                              .isPlaying.value
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                      size: 30,
                                                    ),
                                                  ),
                                                )
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
                                                          color:
                                                              Colors.white60)),
                                            ),
                                            textInputAction: TextInputAction
                                                .done, // Set the action button to 'done'
                                            onFieldSubmitted: (String value) {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                LogUtil.v(
                                                    'User submitted: $value');
                                                c.setRenameValue(value: false);
                                                c.createOrUpdateNewPlaylist(
                                                    name: value.toString(),
                                                    playlistID: c
                                                        .playlistByID.data!.id
                                                        .toString(),
                                                    isEditing: true);
                                              }
                                            },
                                            validator:
                                                FormValidatorUtil.playlistName,
                                          ),
                                        ),
                                      )),
                                20.height,
                                customDivider(thickNess: 0.3),
                                22.height,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kMaxMargin),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                          padding:
                                              EdgeInsets.only(bottom: 70.0.h),
                                          shrinkWrap: true,
                                          itemCount: c.playlistByID.data!
                                              .tracks!.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var item = c.playlistByID.data!
                                                .tracks![index];
                                            return ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: SizedBox(
                                                height: 80,
                                                width: 60,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    // Image with overlay
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      child: Stack(
                                                        children: [
                                                          // Background Image
                                                          AppCachedImage(
                                                            imageUrl: c
                                                                .playlistByID
                                                                .data!
                                                                .tracks![index]
                                                                .trackAffirmations!
                                                                .file![index]
                                                                .adamVoiceUrl
                                                                .toString(),
                                                          ),
                                                          // Dark overlay
                                                          Container(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Play/Pause Button Overlay
                                                    Center(
                                                      child: Obx(() {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            audioPlayerController
                                                                .playPause(
                                                              c
                                                                  .playlistByID
                                                                  .data!
                                                                  .tracks![
                                                                      index]
                                                                  .trackAffirmations!
                                                                  .file![index]
                                                                  .antoniVoiceUrl
                                                                  .toString(),
                                                            );
                                                          },
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .black26,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white30,
                                                                  width: 1),
                                                            ),
                                                            child: Icon(
                                                              audioPlayerController
                                                                      .isPlaying
                                                                      .value
                                                                  ? Icons
                                                                      .pause_rounded
                                                                  : Icons
                                                                      .play_arrow_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    // Loading indicator
                                                    // Obx(() {
                                                    //   if (!audioPlayerController
                                                    //       .isPlaying.value)
                                                    //     return const SizedBox
                                                    //         .shrink();
                                                    //   return Container(
                                                    //     color: Colors.black26,
                                                    //     child: const Center(
                                                    //       child: SizedBox(
                                                    //         width: 24,
                                                    //         height: 24,
                                                    //         child:
                                                    //             CircularProgressIndicator(
                                                    //           strokeWidth: 2,
                                                    //           color:
                                                    //               Colors.white,
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   );
                                                    // }),
                                                  ],
                                                ),
                                              ),
                                              title: Text(
                                                item.order.toString(),
                                                style: customTextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.4,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                              subtitle: Text(
                                                item.order.toString(),
                                                style: customTextStyle(
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.4,
                                                  color: descriptionColor,
                                                ),
                                              ),
                                              trailing: Obx(
                                                () => c.isEdit.value == true
                                                    ? IconButton(
                                                        onPressed: () async {
                                                          LogUtil.v(
                                                              'track deleting.....');
                                                          await c
                                                              .removeTracksToPlaylist(
                                                            id: c.playlistByID
                                                                .data!.id!
                                                                .toString(),
                                                            tID: item.id!
                                                                .toString(),
                                                            index: index,
                                                          );
                                                        },
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: showSvgIconWidget(
                                                            iconPath: AppIcons
                                                                .deleteBin),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              const MusicOptionsPage());
                                                        },
                                                        child: const Icon(
                                                          Icons.more_vert,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  return AudioPlayerBar(
                                    title: 'Affirmation 1',
                                    subtitle: '100 Affirmation',
                                    isPlaying:
                                        audioPlayerController.isPlaying.value,
                                    onPlayPause: () {
                                      audioPlayerController.playPause(
                                          'https://manifest.digitalupgraders.com/files/tracks/Free_Test_Data_1MB_MP3.mp3');
                                    },
                                    thumbnailUrl:
                                        "https://manifest.digitalupgraders.com/files/tracks/Free_Test_Data_1MB_MP3.mp3",
                                  );
                                })
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: kSize.height * 0.30,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    height: kSize.height * 0.40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        child: Image.network(
                                          c.playlistByID.data!.image.toString(),
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.darken,
                                          color: Colors.black45,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.white70,
                                              child: Center(
                                                child: Icon(Icons.error,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            );
                                          },
                                        )),
                                  ),
                                ),
                                if (c.isRename == false) 16.height,
                                Obx(() => c.isRename == false
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${c.playlistByID.data!.name}',
                                              style: customTextStyle(
                                                  letterSpacing: 0.4,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: kWhiteColor),
                                            ),
                                            if (c.isEdit.value == true)
                                              CupertinoButton(
                                                  onPressed: () {
                                                    c.setRenameValue(
                                                        value: true);
                                                  },
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
                                                          color:
                                                              Colors.white60)),
                                            ),
                                            textInputAction: TextInputAction
                                                .done, // Set the action button to 'done'
                                            onFieldSubmitted: (String value) {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                LogUtil.v(
                                                    'User submitted: $value');
                                                c.setRenameValue(value: false);
                                                c.createOrUpdateNewPlaylist(
                                                    name: value.toString(),
                                                    playlistID: c
                                                        .playlistByID.data!.id
                                                        .toString(),
                                                    isEditing: true);
                                              }
                                            },
                                            validator:
                                                FormValidatorUtil.playlistName,
                                          ),
                                        ),
                                      )),
                                Gap(kSize.height * 0.16),
                                Obx(() {
                                  return c.isEdit.value
                                      ? Column(
                                          children: [
                                            Text(
                                              'Click on the add button to add new\n track to the playlist',
                                              style: customTextStyle(
                                                  fontSize: 16.0,
                                                  color: descriptionColor,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.4),
                                              textAlign: TextAlign.center,
                                            ),
                                            24.height,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: lightGreyColor,
                                                        width: 1.0),
                                                  ),
                                                  child: Center(
                                                      child: CupertinoButton(
                                                    padding: EdgeInsets.zero,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    onPressed: () {
                                                      Get.bottomSheet(
                                                        AddTracksToPlaylist(
                                                            playlistID: c
                                                                .playlistByID
                                                                .data!
                                                                .id
                                                                .toString()),
                                                        isScrollControlled:
                                                            true,
                                                        enableDrag: true,
                                                        enterBottomSheetDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                      );
                                                    },
                                                    child: const Icon(Icons.add,
                                                        color: Colors.white),
                                                  )),
                                                ),
                                                10.width,
                                                Text(
                                                  'Add',
                                                  style: customTextStyle(
                                                      color: kWhiteColor,
                                                      fontSize: 20.0,
                                                      letterSpacing: 0.4,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container();
                                }),
                              ],
                            ),
                    );
                  }),
        ));
  }
}
