import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/by_you/voice_recorder_or_player/media_player.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class EditRecordedAffirmations extends StatelessWidget {
  const EditRecordedAffirmations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Record Affirmation',
          style: customTextStyle(
              color: kWhiteColor,
              letterSpacing: 0.4,
              fontSize: 17.0,
              fontWeight: FontWeight.w700),
        ),
        leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close, color: Colors.white),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
                onPressed: () {},
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
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.bottomSheet(
      //       barrierColor: Colors.black.withOpacity(0.8),
      //       const VoiceRecordBottomSheet(),
      //       isScrollControlled: true,
      //       enableDrag: true,
      //       enterBottomSheetDuration: const Duration(milliseconds: 500),
      //     );
      //   },
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      //   backgroundColor: Colors.white38,
      //   child: SvgPicture.asset(AppIcons.newMice)
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              22.height,
              Align(
                alignment: Alignment.center,
                child: Text(
                  '6 affirmations | 03:20',
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
                  itemCount: DummyData.dummyData.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const ByYouMediaPlayer(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Recording ${index + 1}',
                                      style: customTextStyle(
                                          color: kWhiteColor,
                                          fontSize: 17.0,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '12 affirmation 10:30',
                                      style: customTextStyle(
                                          color: descriptionColor,
                                          fontSize: 12.0,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )),
                                Row(
                                  children: [
                                    showSvgIconWidget(
                                        iconPath: AppIcons.deleteBin),
                                    10.width,
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
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
    );
  }
}
