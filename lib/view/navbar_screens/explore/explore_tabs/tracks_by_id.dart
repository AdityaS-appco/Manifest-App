import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/controllers/audio_controller.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/view/navbar_screens/explore/explore_tabs/tracks_by_id_controller.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/divider_widget.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/controllers/explore_tab/explore_categories_controller.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../helper/icons_and_images_path.dart';

class TracksByID extends GetView<TracksByIdController> {
  @override
  Widget build(BuildContext context) {
    ExploreCategoriesController c = Get.find<ExploreCategoriesController>();
    AudioController audioController = AudioController();
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.grayToGray),
      child: Obx(() {
        return controller.isLoading.value || (controller.track.value == null)
            ? Center(child: dotsWaveLoading())
            : Scaffold(
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
                  // actions: [
                  //  Row(children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         // Get.to(()=> MyCollectionOptionsScreen());
                  //       },
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(right: 18.0),
                  //         child: Icon(
                  //           Icons.more_horiz,
                  //           color: kWhiteColor,
                  //         ),
                  //       ),)
                  //   ],)
                  // ],
                ),
                // bottomSheet: Material(
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.zero,
                //   ),
                //   child: Container(
                //     height: 68,
                //     color: Colors.grey.shade700,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //       child: ListTile(
                //         contentPadding: EdgeInsets.zero,
                //         leading: SizedBox(
                //           height: 44,
                //           width: 44,
                //           child: ClipRRect(
                //               borderRadius: BorderRadius.circular(10.0),
                //               child: Image.network(
                //                 DummyData.dummyData.first.imageUrl,
                //                 fit: BoxFit.cover,
                //                 errorBuilder: (context, error, stackTrace) {
                //                   return Container(
                //                     color: Colors.white70,
                //                     child: Center(child: Icon(Icons.error,color: Colors.grey.shade600),),
                //                   );
                //                 },)),
                //         ),
                //         title: Text(
                //           'MP3 1',
                //           style: customTextStyle(
                //               fontWeight: FontWeight.w400,
                //               fontSize: 16.0,
                //               letterSpacing: 0.4,
                //               color: kWhiteColor
                //           ),
                //         ),
                //         subtitle: Text('Artist Name', style: customTextStyle(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 12.0,
                //             letterSpacing: 0.4,
                //             color: descriptionColor
                //         ),),
                //
                //         // GestureDetector(
                //         //   onTap: () {
                //         //     LogUtil.v('eeee');
                //         //   },
                //         //   child: Container(
                //         //     decoration: BoxDecoration(
                //         //       shape: BoxShape.circle,
                //         //       color: kWhiteColor, // Change color as needed
                //         //     ),
                //         //     padding: const EdgeInsets.all(10),
                //         //     child: Icon(
                //         //       Icons.pause,
                //         //       color: blackColor,
                //         //       size: 25,
                //         //     ),
                //         //   ),
                //         // ),
                //         trailing: GetBuilder<AudioController>(
                //             init: AudioController(),
                //             builder: (audioCont) {
                //               return StreamBuilder<Duration?>(
                //                 stream: audioCont.player.positionStream,
                //                 builder: (context, snapshot) {
                //                   final Duration? duration = snapshot.data;
                //                   final double progressValue = duration != null && duration.inMilliseconds > 0 && audioCont.player.duration != null
                //                       ? duration.inMilliseconds / audioCont.player.duration!.inMilliseconds
                //                       : 0.0;
                //                   return SizedBox(
                //                     width: 44.w,
                //                     height: 44.h,
                //                     child: Stack(
                //                       children: [
                //                         SizedBox(
                //                           width: 44.w,
                //                           height: 44.h,
                //                           child: CircularProgressIndicator(
                //                             value: progressValue,
                //                             valueColor: const AlwaysStoppedAnimation<Color>(
                //                               Color.fromRGBO(194, 194, 194, 0.5),
                //                             ),
                //                             backgroundColor: const Color.fromRGBO(127, 127, 127, 0.2),
                //                           ),
                //                         ),
                //                         Center(
                //                           child: StreamBuilder<PlayerState>(
                //                               stream: audioCont.player.playerStateStream,
                //                               builder: (context, state) {
                //                                 final processingState = state.data?.processingState;
                //                                 final playing = state.data?.playing;
                //                                 if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                //                                   return Container(
                //                                     decoration: const BoxDecoration(
                //                                       shape: BoxShape.circle,
                //                                       color: Colors.white,
                //                                     ),
                //                                     width: 48.w,
                //                                     height: 48.h,
                //                                     child: const CircularProgressIndicator(backgroundColor: Colors.black),
                //                                   );
                //                                 } else if (playing != true) {
                //                                   return GestureDetector(
                //                                     onTap: audioCont.play,
                //                                     child: Container(
                //                                       decoration: const BoxDecoration(
                //                                         shape: BoxShape.circle,
                //                                         color: Colors.white,
                //                                       ),
                //                                       width: 40.w,
                //                                       height: 40.h,
                //                                       child: const Icon(
                //                                         Icons.play_arrow,
                //                                         color: Colors.black,
                //                                         size: 24,
                //                                       ),
                //                                     ),
                //                                   );
                //                                 } else if (processingState != ProcessingState.completed) {
                //                                   return GestureDetector(
                //                                     onTap: audioCont.pause,
                //                                     child: Container(
                //                                       decoration: const BoxDecoration(
                //                                         shape: BoxShape.circle,
                //                                         color: Colors.white,
                //                                       ),
                //                                       width: 40.w,
                //                                       height: 40.h,
                //                                       child: const Icon(
                //                                         Icons.pause,
                //                                         color: Colors.black,
                //                                         size: 24,
                //                                       ),
                //                                     ),
                //                                   );
                //                                 } else {
                //                                   return GestureDetector(
                //                                     onTap: () => audioCont.player.seek(Duration.zero),
                //                                     child: Container(
                //                                       decoration: const BoxDecoration(
                //                                         shape: BoxShape.circle,
                //                                         color: Colors.white,
                //                                       ),
                //                                       width: 40.w,
                //                                       height: 40.h,
                //                                       child: const Icon(
                //                                         Icons.replay,
                //                                         color: Colors.black,
                //                                         size: 24,
                //                                       ),
                //                                     ),
                //                                   );
                //                                 }
                //                               }),
                //                         ),
                //                       ],
                //                     ),
                //                   );
                //                 },
                //               );
                //             }
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                body: controller.track.value != null
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
                                  controller.track.value?.image.toString() ??
                                      '',
                                  fit: BoxFit.cover,
                                  colorBlendMode: BlendMode.darken,
                                  color: Colors.black45,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.white70,
                                      child: Center(
                                          child: Icon(Icons.error,
                                              color: Colors.grey.shade600)),
                                    );
                                  },
                                )),
                          ),
                          22.height,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => Text(
                                        controller.track.value?.name ??
                                            'Untitled',
                                        style: customTextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700,
                                            color: kWhiteColor),
                                      ),
                                    ),
                                    // 4.width,
                                    // Obx(() => c.isEdit.value == true ? showSvgIconWidget(iconPath: AppIcons.edit) : Container()),
                                  ],
                                ),
                                Text(
                                  '${controller.track.value?.affirmationsCount.toString() ?? 0} affirmations | ${controller.track.value?.totalAffirmationsDuration.toString() ?? '00:00'}',
                                  style: customTextStyle(
                                      fontSize: 13.0,
                                      color: descriptionColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                10.height,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: const Color.fromRGBO(
                                                37, 37, 37, 0.55),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: showSvgIconWidget(
                                                iconPath: AppIcons.stopWatch),
                                          ),
                                        ),
                                        12.width,
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: const Color.fromRGBO(
                                                37, 37, 37, 0.55),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: showSvgIconWidget(
                                                iconPath: AppIcons.musicReplay),
                                          ),
                                        ),
                                        12.width,
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: const Color.fromRGBO(
                                                37, 37, 37, 0.55),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: showSvgIconWidget(
                                                iconPath:
                                                    AppIcons.favoriteOutline),
                                          ),
                                        ),
                                        12.width,
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: const Color.fromRGBO(
                                                37, 37, 37, 0.55),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: showSvgIconWidget(
                                                iconPath:
                                                    AppIcons.downloadPlay),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Obx(() => audioController
                                                .isPlayLoading.value ==
                                            true
                                        ? const CircleAvatar(
                                            radius: 25.0,
                                            backgroundColor: Colors.white,
                                            child: CircularProgressIndicator(
                                              color: Colors.black54,
                                              strokeWidth: 0.8,
                                            ),
                                          )
                                        : audioController.isPlaying.value ==
                                                false
                                            ? CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: kWhiteColor,
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (audioController
                                                            .isPlayListLoadDone
                                                            .value ==
                                                        false) {
                                                      List<String> subForm =
                                                          controller
                                                              .track
                                                              .value!
                                                              .affirmations!
                                                              .map((item) => item
                                                                  .subForm
                                                                  .toString())
                                                              .toList();
                                                      // Parse the JSON string
                                                      List<dynamic> items =
                                                          subForm
                                                              .map((item) =>
                                                                  json.decode(
                                                                      item))
                                                              .toList();
                                                      List<String> audios = [];
                                                      for (var group in items) {
                                                        if (group.isNotEmpty &&
                                                            group[0].containsKey(
                                                                'appendAudio')) {
                                                          audios.add(group[0]
                                                              ['appendAudio']);
                                                        }
                                                      }
                                                      LogUtil.v(
                                                          'audio list $audios');
                                                      audioController
                                                          .setupAudioPlayerPlaylist(
                                                              playlist: audios);
                                                    } else {
                                                      audioController
                                                          .playPlaylist();
                                                    }
                                                  },
                                                  icon: Icon(Icons.play_arrow,
                                                      color: blackColor,
                                                      size: 35),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: kWhiteColor,
                                                child: IconButton(
                                                  onPressed: () {
                                                    audioController
                                                        .pausePlaylist();
                                                  },
                                                  icon: Icon(Icons.pause,
                                                      color: blackColor,
                                                      size: 35),
                                                ),
                                              ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          10.height,
                          customDivider(thickNess: 0.3),
                          10.height,
                          ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              shrinkWrap: true,
                              itemCount:
                                  controller.track.value!.affirmations!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  color: Color.fromRGBO(235, 235, 245, 0.16),
                                  indent: 40,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                String formattedIndex =
                                    (index + 1).toString().padLeft(2, '0');
                                var item = controller
                                    .track.value!.affirmations![index];
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
                                      item.description.toString(),
                                      style: customTextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: lightGreyColor,
                                          letterSpacing: 0.4),
                                    ),
                                    subtitle: Text(
                                      item.affirmationsDuration.toString(),
                                      style: customTextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w400,
                                          color: descriptionColor,
                                          letterSpacing: 0.4),
                                    ),
                                    trailing: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () async {
                                          LogUtil.v(
                                              'aaa ${item.subForm.toString()}');
                                          // Example JSON string
                                          String jsonString =
                                              item.subForm.toString();
                                          // Parse the JSON string
                                          List<dynamic> items =
                                              json.decode(jsonString);
                                          // Get the first mp3 file (logic can be adjusted as needed)
                                          String mp3File =
                                              items[0]['appendAudio'];
                                          // Print warning with the MP3 file included
                                          LogUtil.v('a $mp3File');
                                          audioController.audioFile =
                                              mp3File.toString();
                                          audioController.isPlaying.value
                                              ? audioController.pauseAudio()
                                              : audioController.playAudio();
                                          audioController.currentIndex.value =
                                              index;
                                        },
                                        child: Icon(
                                            audioController.isPlaying.value &&
                                                    audioController.currentIndex
                                                            .value ==
                                                        index
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 25)));
                              }),
                          68.height,
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: kSize.height * 0.40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: AppCachedImage(
                                  imageUrl: controller.track.value?.image
                                          .toString() ??
                                      '',
                                )),
                          ),
                          20.height,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Obx(
                                  () => Text(
                                    '${controller.track.value?.name}',
                                    style: customTextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        color: kWhiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(kSize.height * 0.06),
                          Text(
                            'track is empty',
                            style: customTextStyle(
                                fontSize: 16.0, color: lightGreyColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              );
      }),
    );
  }
}
