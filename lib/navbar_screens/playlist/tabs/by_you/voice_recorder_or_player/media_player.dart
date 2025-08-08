import 'package:manifest/controllers/audio_controller.dart';
import 'package:manifest/helper/import.dart';

class ByYouMediaPlayer extends StatelessWidget {
  final String? recordingUrl;
  const ByYouMediaPlayer({this.recordingUrl,super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(
      init: AudioController(),
      builder: (c) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [Colors.redAccent.withOpacity(0.6), Colors.redAccent.withOpacity(0.2)],
            ),
          ),
          child: Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Record',
                style: customTextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor,
                    letterSpacing: 0.4,
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.0),
                ),
              ),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //     child: IconButton(
              //         onPressed: () {
              //           Get.to(ByYouOptions());
              //         },
              //         icon: Icon(
              //           Icons.queue_music_outlined,
              //           color: kWhiteColor,
              //           size: 20.0,
              //         )),
              //   )
              // ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                Icon(
                  Icons.mic,
                  color: Colors.grey.withOpacity(0.9),
                  size: 250.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // showSvgIconWidget(iconPath: AppIcons.stopWatchGrey),
                      // showSvgIconWidget(iconPath: AppIcons.loop),
                      Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: lightGreyColor, width: 2.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () async {
                                c.audioFile = recordingUrl.toString();
                                c.isPlaying.value ? c.stopAudio() : c.playAudio();
                                // setState(() {
                                //
                                // });
                              },
                              icon: Icon(
                                  c.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow, color: Colors.black,size: 40),
                            ),
                          ),
                        ),
                      ),
                      // Container(),
                      // showSvgIconWidget(iconPath: AppIcons.filter),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
