import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/controllers/audio_recorder_controller.dart';
import 'package:manifest/helper/import.dart';

import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/core/utils.dart';

import '../../../../../../helper/constant.dart';
import '../../../../../../helper/icons_and_images_path.dart';

class VoiceRecordBottomSheet extends StatelessWidget {
  int? recordingsIndex;
  int? idOfByYou;
  bool? isCreatingByYou;
  VoiceRecordBottomSheet(
      {Key? key, this.recordingsIndex, this.isCreatingByYou, this.idOfByYou})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlaylistTabController playlistTabCont = Get.find<PlaylistTabController>();
    return GetBuilder<AudioRecorderController>(
        init: AudioRecorderController(),
        builder: (c) {
          return Container(
            width: kSize.width,
            decoration: const BoxDecoration(
              color: Color(0xff1d2125),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                Center(
                  // alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: 36,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(127, 127, 127, 0.4),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(127, 127, 127, 0.4),
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: Center(
                            child: Icon(
                              size: 16.0,
                              Icons.close,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'My Recording',
                            style: customTextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 28.0,
                                letterSpacing: 0.4,
                                color: kWhiteColor),
                          ),
                        ),
                        Text(
                          c.recordDuration == 0 ? '' : '${c.recordDuration}',
                          style: customTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17.0,
                              letterSpacing: 0.4,
                              color: descriptionColor),
                        ),
                      ],
                    ),
                    36.height,
                    // c.recordingStarted == false
                    //     ? SizedBox(
                    //         width: Get.width,
                    //         child: Image.asset(AppImages.soundWave,
                    //             fit: BoxFit.cover),
                    //       )
                    //     : SizedBox(
                    //         width: Get.width,
                    //         child: Lottie.asset('assets/voiceAnimation.json',
                    //             width: double.maxFinite),
                    //       ),
                    36.height,
                    c.recordingStarted == false
                        ? GestureDetector(
                            onTap: () async {
                              c.startRecording();
                            },
                            child: Center(
                              child: Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.mic_outlined,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              c.stopRecording();
                              LogUtil.i('audio file: ${c.audioFile}');
                              switch (isCreatingByYou!) {
                                case true:
                                  playlistTabCont.createOrUpdateByYou(
                                      filePath: c.audioFile,
                                      recordingIndex: recordingsIndex!);
                                  break;
                                case false:
                                  LogUtil.i(
                                      'test pass with these values:\n filePath: ${c.audioFile},\n recordingIndex: ${recordingsIndex!.toString()}\n byYouID: $idOfByYou');
                                  playlistTabCont.addAffirmationInByYou(
                                      filePath: c.audioFile.toString(),
                                      recordingIndex: recordingsIndex!,
                                      idOfByYou: idOfByYou.toString());
                                  break;
                              }
                            },
                            child: Center(
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Center(
                                  child: Icon(
                                    Icons.stop,
                                    color: Colors.red,
                                    size: 35.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    10.height,
                  ],
                ),
              ]), //Stack
            ), //Padding
          );
        }); //Container
  }
}
