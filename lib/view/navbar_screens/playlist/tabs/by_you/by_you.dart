import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:manifest/features/playlist/by_you/models/local_recording.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/voice_recorder_bottom_sheet.dart';
import 'package:manifest/helper/icons_and_images_path.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/playlist_tab_model/by_you/recorded_list_model.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/by_you/edit_by_you/by_you_edit_options.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/by_you/recorded_affirmations_in_by_you_by_id.dart';
import 'package:manifest/features/playlist/by_you/widgets/audio_player/audio_player_screen.dart';

class ByYouMainPage extends StatelessWidget {
  const ByYouMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    int recordingsIndex = 1;
    PlaylistTabController c = Get.find<PlaylistTabController>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: false,
      //   title: Text(
      //     'By You',
      //     style: appBarTitleTextStyle(color: kWhiteColor),
      //   ),
      //   leading: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //     child: IconButton(
      //       onPressed: () {
      //         Get.back();
      //       },
      //       icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //       child: showSvgIconWidget(iconPath: AppIcons.uploadCircle),
      //     )
      //   ],
      // ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.0.h),
        child: FloatingActionButton(
            onPressed: () {
              // * open voice recording bottomsheet
              Get.bottomSheet(
                // * @author: alok singh
                VoiceRecorderBottomSheet(
                    isCreatingByYou: true,
                    onRecordingStopped: (file, duration) {
                      // * add the recording to the list
                      c.recordingsList.add(LocalRecording(
                        id: recordingsIndex + 1,
                        name: 'Recorded File ${recordingsIndex + 1}',
                        description: 'Recorded File ${recordingsIndex++}',
                        duration: duration,
                        file: file,
                      ));
                      LogUtil.v('Recorded file path: ${file.path}');
                    },
                    recordingIndex: recordingsIndex,
                    onBottomSheetClosed: () {}),
                barrierColor: Colors.black.withOpacity(0.8),
                // VoiceRecordBottomSheet(
                //   recordingsIndex: recordingsIndex,
                //   isCreatingByYou: true,
                // ),
                isScrollControlled: true,
                enableDrag: true,
                enterBottomSheetDuration: const Duration(
                  milliseconds: 500,
                ),
              );
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            backgroundColor: Colors.white38,
            child: SvgPicture.asset(AppIcons.newMice)),
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Obx(
          () => c.isLoading.value
              ? Center(child: dotsWaveLoading())
              : c.recordedList.data == null
                  ? Center(
                      child: Text(
                        AppStrings.selectTheMicroPhoneIconToBegin,
                        style: customTextStyle(
                            fontSize: 16.0,
                            color: Colors.white38,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: c.recordedList.data?.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      recordingsIndex = index + 1;
                                      var item = c.recordedList.data![index];
                                      return _recordingTile(
                                          item: item,
                                          index: index,
                                          onTap: () {
                                            Get.to(() =>
                                                const RecordedAffirmations());
                                            // c.getListOfRecordedVoicesByID(
                                            //   idOfList: item.id.toString(),
                                            // );
                                          });
                                    }),
                                40.height,
                              ],
                            ),
                          ),

                          // Todo: change it for previous implementation
                          // * @author: alok singh
                          // * @description: this is the list of recordings
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => 16.height,
                                itemCount: c.recordingsList.length ?? 0,
                                itemBuilder: (context, index) => Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => AudioPlayerScreen(
                                          audioFile:
                                              c.recordingsList[index].file!,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Recorded File ${index + 1}',
                                      style: customTextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white38,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  GestureDetector _recordingTile({
    required RecordingsListModelData item,
    required int index,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: AssetImage(AppImages.recordingRed),
                      fit: BoxFit.cover)),
            ),
            const Gap(16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.description}',
                  style: secondaryWhiteTextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16),
                ),
                Text(
                  '${item.affirmationsCount} affirmation ${item.totalDuration}',
                  style: customTextStyle(
                      color: descriptionLightColor, fontSize: 12),
                )
              ],
            )),
            GestureDetector(
              onTap: () {
                Get.to(() => ByYouOptions(
                      currentID: item.id.toString(),
                      byYouName: '${item.description} ${index + 1}',
                      totalDurationOrAffirmation:
                          '${item.affirmationsCount} affirmation | No duration',
                    ));
              },
              child: Icon(
                size: 20,
                Icons.more_vert,
                color: descriptionLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
