import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:manifest/controllers/audio_controller.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/view/widgets/divider_widget.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../../../helper/icons_and_images_path.dart';


class FavoriteTracksPlaylist extends StatelessWidget {
  const FavoriteTracksPlaylist({super.key,});

  @override
  Widget build(BuildContext context) {
    PlaylistTabController c = Get.find<PlaylistTabController>();
    return GetBuilder<AudioController>(
      init: AudioController(),
      builder: (audioController) {
        return Container(
            decoration: BoxDecoration(
              gradient: AppGradients.grayToGray,
            ),
            child: Obx(() => c.isTrackByIdLoading.value
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
                    size: 16.0,
                  ),
                ),
                actions: const [],
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
              //               child: Image.network(DummyData.dummyData.first.imageUrl, fit: BoxFit.cover,)),
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
              //         trailing: GestureDetector(
              //           onTap: () {
              //             // Add your onTap logic here
              //           },
              //           child: Container(
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: kWhiteColor, // Change color as needed
              //             ),
              //             padding: const EdgeInsets.all(10),
              //             child: Icon(
              //               Icons.pause,
              //               color: blackColor,
              //               size: 25,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              body: c.getTracksByID.data!.name!.isNotEmpty
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
                        child: Image.asset(
                          c.getTracksByID.data!.image.toString(),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.darken,
                          color: Colors.black45,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.white70,
                              child: Center(child: Icon(Icons.error,color: Colors.grey.shade600),),
                            );
                          },
                        )
                    ),
                  ),
                  22.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.getTracksByID.data!.name.toString(),
                          style: customTextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: kWhiteColor),
                        ),
                        4.height,
                        Text(
                          '${c.getTracksByID.data!.affirmationsCount.toString()} affirmations | ${c.getTracksByID.data!.totalAffirmationsDuration.toString()}',
                          style: customTextStyle(
                              fontSize: 13.0,
                              color: descriptionColor,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        10.height,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: const Color.fromRGBO(37, 37, 37, 0.55),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: showSvgIconWidget(iconPath: AppIcons.stopWatch),
                                  ),
                                ),
                                12.width,
                                Obx(()=> Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: audioController.isLoop.value == false ? const Color.fromRGBO(37, 37, 37, 0.55) : const Color.fromRGBO(169,169,169, 0.55),
                                  ),
                                  child: CupertinoButton(
                                    onPressed: () {
                                      if(audioController.isLoop.value == false){
                                        audioController.setLoop(true);
                                        LogUtil.v('set loop true');
                                      }
                                      else{
                                        LogUtil.v('set loop false');
                                        audioController.setLoop(false);
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    child: showSvgIconWidget(iconPath: AppIcons.musicReplay),
                                  ),
                                )),
                                12.width,
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: const Color.fromRGBO(37, 37, 37, 0.55),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: showSvgIconWidget(iconPath: AppIcons.add),
                                  ),
                                ),
                                12.width,
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: const Color.fromRGBO(37, 37, 37, 0.55),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: showSvgIconWidget(iconPath: AppIcons.downloadPlay),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => audioController.isPlayLoading.value == true
                                ? const CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.white,
                              child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 0.8,),)
                                : audioController.isPlaying.value == false
                                ? CircleAvatar(
                              radius: 25.0,
                              backgroundColor: kWhiteColor,
                              child: IconButton(
                                onPressed: () {
                                  if(audioController.isPlayListLoadDone.value == false){
                                    List<String> subForm = c.getTracksByID.data!.affirmations!.map((item) => item.subForm.toString()).toList();
                                    // Parse the JSON string
                                    List<dynamic> items = subForm.map((item) => json.decode(item)).toList();
                                    List<String> audios = [];
                                    for (var group in items) {
                                      if (group.isNotEmpty && group[0].containsKey('appendAudio')) {
                                        audios.add(group[0]['appendAudio']);
                                      }
                                    }
                                    audioController.setupAudioPlayerPlaylist(playlist: audios);
                                  }else{
                                    audioController.playPlaylist();
                                  }
                                },
                                icon: Icon(Icons.play_arrow, color: blackColor, size: 35),
                              ),
                            )
                                : CircleAvatar(
                              radius: 25.0,
                              backgroundColor: kWhiteColor,
                              child: IconButton(
                                onPressed: () {
                                  audioController.pausePlaylist();
                                },
                                icon: Icon(Icons.pause, color: blackColor, size: 35),
                              ),
                            )
                            ),
                            Obx(()=>audioController.isPlaying.value == false
                             ? CircleAvatar(
                              radius: 25.0,
                              backgroundColor: kWhiteColor,
                              child: IconButton(
                                onPressed: () {
                                  List<String> subForm = c.getTracksByID.data!.affirmations!.map((item) => item.subForm.toString()).toList();
                                  // Parse the JSON string
                                  List<dynamic> items = subForm.map((item) => json.decode(item)).toList();
                                  List<String> audios = [];
                                  for (var group in items) {
                                    if (group.isNotEmpty && group[0].containsKey('appendAudio')) {
                                      audios.add(group[0]['appendAudio']);
                                    }
                                  }
                                  LogUtil.v('audio list $audios');
                                  audioController.setupAudioPlayerPlaylist(playlist: audios);
                                  audioController.playPlaylist();
                                },
                                icon: Icon(Icons.play_arrow, color: blackColor, size: 35),
                              ),
                             )
                             : CircleAvatar(
                              radius: 25.0,
                              backgroundColor: kWhiteColor,
                              child: IconButton(
                                onPressed: () {
                                  audioController.pausePlaylist();
                                },
                                icon: Icon(
                                    Icons.pause,
                                    color: blackColor, size: 35),
                              ),
                             ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  20.height,
                  customDivider(thickNess: 0.3),
                  22.height,
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: kMaxMargin),
                      child: Obx(() => c.isTrackByIdLoading.value
                        ? c.getTracksByID.data == null || c.getTracksByID.data!.affirmations!.isNotEmpty ?  Center(child: Text('no data',style: customTextStyle(fontSize: 11,color: Colors.white)),) : Center(child: dotsWaveLoading(color: Colors.white70),)
                        : ListView.separated(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          shrinkWrap: true,
                          itemCount: c.getTracksByID.data!.affirmations!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              color: Color.fromRGBO(235, 235, 245, 0.16),
                              indent: 40,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            String formattedIndex = (index + 1).toString().padLeft(2, '0');
                            var item = c.getTracksByID.data!.affirmations![index];
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
                                  '${item.description}',
                                  style: secondaryWhiteTextStyle(),
                                ),
                                subtitle: Text(
                                  '${item.affirmationsDuration}',
                                  style: customTextStyle(color: lightGreyColor),
                                ),
                                trailing: Obx(() => c.isEdit.value == false
                                  ? CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      LogUtil.v('aaa ${item.subForm.toString()}');
                                      // Example JSON string
                                      String jsonString = item.subForm.toString();
                                      // Parse the JSON string
                                      List<dynamic> items = json.decode(jsonString);
                                      // Get the first mp3 file (logic can be adjusted as needed)
                                      String mp3File = items[0]['appendAudio'];
                                      // Print warning with the MP3 file included
                                      LogUtil.v('a $mp3File');
                                      audioController.audioFile = mp3File.toString();
                                      audioController.isPlaying.value ? audioController.pauseAudio() : audioController.playAudio();
                                      audioController.currentIndex.value = index;
                                    },
                                    child: Icon(
                                        audioController.isPlaying.value && audioController.currentIndex.value == index
                                            ? Icons.pause
                                            : Icons.play_arrow, color: Colors.white,size: 25)
                                )
                                  : CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      c.addAffirmationToFavorite(affirmationID: item.id.toString());
                                    },
                                    child: showSvgIconWidget(iconPath: AppIcons.deleteDownload)
                                )
                                )
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.bottomSheet(
                              //       const PlayListMusicBottomSheet(),
                              //       isScrollControlled: true,
                              //       enableDrag: true,
                              //       enterBottomSheetDuration: const Duration(milliseconds: 500),
                              //     );
                              //   },
                              //   child: const Icon(
                              //     Icons.more_vert,
                              //     color: Colors.white,
                              //   ),
                              // ),
                            );
                          }) )
                  ),
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
                        child: Image.network(
                          c.getTracksByID.data!.image.toString(),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.darken,
                          color: Colors.black45,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.white70,
                              child: Center(child: Icon(Icons.error,color: Colors.grey.shade600),),
                            );
                          },
                        )
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Obx(()=> Text(
                          '${c.getTracksByID.data!.name}',
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
                    style: customTextStyle(fontSize: 16.0, color: lightGreyColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),)
        );
      }
    );
  }
}
