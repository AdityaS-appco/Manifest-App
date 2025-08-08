import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/features/playlist/by_you/widgets/audio_player/audio_player_screen.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/by_you/edit_by_you/edit_affirmations_in_by_you.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/by_you/voice_recorder_or_player/voice_record_sheet.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../helper/icons_and_images_path.dart';

class RecordedAffirmations extends StatelessWidget {
  const RecordedAffirmations({super.key});

  @override
  Widget build(BuildContext context) {
    int recordingsIndex = 1;
    PlaylistTabController c = Get.find<PlaylistTabController>();
    return Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
            backgroundColor: appBackgroundColor,
            elevation: 0,
            centerTitle: false,
            leading: Obx(
              () => c.isEdit.value == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          c.setEditValue(value: false);
                        },
                        child: const Icon(Icons.close, color: Colors.white),
                      ))
                  : CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                        c.setEditValue(value: false);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white54,
                        size: 18.0,
                      )),
            ),
            title: Text(
              'Record Affirmation',
              style: customTextStyle(
                  color: kWhiteColor,
                  letterSpacing: 0.4,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700),
            ),
            actions: [
              Obx(() => c.isEdit.value == true
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kWhiteColor,
                            minimumSize: const Size(30.0, 35.0),
                          ),
                          child: Text(
                            'Save',
                            style: customTextStyle(
                                color: blackColor,
                                fontSize: 13.0,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          )),
                    )
                  : Container())
            ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                barrierColor: Colors.black.withOpacity(0.8),
                VoiceRecordBottomSheet(
                    recordingsIndex: recordingsIndex,
                    isCreatingByYou: false,
                    idOfByYou: c.recordedListByID.data!.data!.id),
                isScrollControlled: true,
                enableDrag: true,
                enterBottomSheetDuration: const Duration(milliseconds: 500),
              );
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            backgroundColor: Colors.white38,
            child: SvgPicture.asset(AppIcons.newMice)),
        body: Obx(
          () => c.isLoading.value
              ? Center(child: dotsWaveLoading())
              : c.recordedListByID.data!.data!.affirmations!.isEmpty
                  ? Center(
                      child: Text(
                        "Click on the mic to start \n recording your affirmations.",
                        style: customTextStyle(
                            fontSize: 16.0,
                            color: Colors.white38,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            22.height,
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${c.recordedListByID.data!.affirmationsCount} affirmations | No duration',
                                style: customTextStyle(
                                  fontSize: 15.0,
                                  color: descriptionColor,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                            22.height,
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: c.recordedListByID.data!.data!
                                    .affirmations!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  recordingsIndex = index + 1;
                                  var item = c.recordedListByID.data!.data!
                                      .affirmations![index];
                                  return GestureDetector(
                                    onTap: () {
                                      // Get.to(() => ByYouMediaPlayer(recordingUrl: item.file.toString()),);
                                      // Todo: change it for previous implementation
                                      // * @author: Alok Singh
                                      // * @description: open audio player screen
                                      Get.to(
                                        () => AudioPlayerScreen(
                                          audioUrl: item.file.toString(),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 16),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 36,
                                                width: 36,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: const Center(
                                                  child: Icon(Icons.play_arrow),
                                                ),
                                              ),
                                              16.width,
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${item.description}',
                                                    style: customTextStyle(
                                                        color: kWhiteColor,
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.4,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '${item.fileDuration}',
                                                    style: customTextStyle(
                                                        color: descriptionColor,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.4,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              )),
                                              Obx(
                                                () => c.isEdit.value == true
                                                    ? Row(
                                                        children: [
                                                          CupertinoButton(
                                                              onPressed: () {
                                                                LogUtil.v(
                                                                    'byYouAffirmationID: ${item.id.toString()}\n ,byYouID: ${c.recordedListByID.data!.data!.id.toString()}');
                                                                c.removeAffirmationOrByYou(
                                                                    byYouAffirmationID:
                                                                        item.id
                                                                            .toString(),
                                                                    byYouID: c
                                                                        .recordedListByID
                                                                        .data!
                                                                        .data!
                                                                        .id
                                                                        .toString(),
                                                                    isByYou:
                                                                        false);
                                                              },
                                                              child: showSvgIconWidget(
                                                                  iconPath: AppIcons
                                                                      .deleteBin)),
                                                          10.width,
                                                          GestureDetector(
                                                            onTap: () {
                                                              c.setIsMenuValue(
                                                                  value: true);
                                                              Get.to(() =>
                                                                  EditAffirmationOptions(
                                                                    currentID: item
                                                                        .id
                                                                        .toString(),
                                                                    byYouName: item
                                                                        .description
                                                                        .toString(),
                                                                    totalDurationOrAffirmation: item
                                                                        .fileDuration
                                                                        .toString(),
                                                                    byYouCurrentID: c
                                                                        .recordedListByID
                                                                        .data!
                                                                        .data!
                                                                        .id
                                                                        .toString(),
                                                                  ));
                                                            },
                                                            child: const Icon(
                                                              Icons.menu,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
        ));
  }
}
