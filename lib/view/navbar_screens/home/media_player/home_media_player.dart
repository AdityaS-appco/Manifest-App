import 'package:manifest/controllers/home_media_player_controller.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/home_model.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import '../../../../helper/icons_and_images_path.dart';
import 'package:just_audio/just_audio.dart';

class HomeMediaPlayer extends StatefulWidget {
  final PlayList playlist;

  const HomeMediaPlayer(this.playlist, {super.key});

  @override
  State<HomeMediaPlayer> createState() => _HomeMediaPlayerState();
}

class _HomeMediaPlayerState extends State<HomeMediaPlayer> {
  int previousPageIndex = 0;
  final HomeMediaPlayerController c = Get.put(HomeMediaPlayerController());

  @override
  void initState() {
    super.initState();
    // audioController.setupAudioPlayer(widget.playlist);
    c.setupAudioPlayer1(widget.playlist);
    c.setCurrentAffirmation(widget.playlist.affirmations!.first);
  }

  @override
  dispose() {
    c.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> affirmationText = widget.playlist.affirmations!
        .map((affirmation) => affirmation.description)
        .toList();
    // List<int?> ids = widget.playlist.affirmations!.map((affirmation) => affirmation.id).toList();
    List<Widget> pages = affirmationText.map((description) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            description!,
            textAlign: TextAlign.center,
            style: customTextStyle(
                color: kWhiteColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2),
          ),
        ),
      );
    }).toList();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: blackColor,
              image: DecorationImage(
                image: NetworkImage(DummyData.dummyData.last.imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken),
              ),
            ),
          ),
          Stack(
            children: [
              widget.playlist.affirmations!.isEmpty
                  ? Center(child: dotsWaveLoading(color: Colors.white60))
                  : SizedBox(
                      height: kSize.height,
                      width: kSize.width,
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        controller: c.pageController,
                        children: pages,
                        onPageChanged: (int pageIndex) {
                          if (pageIndex > previousPageIndex) {
                            c.next();
                          } else if (pageIndex < previousPageIndex) {
                            c.previous();
                          }
                          previousPageIndex = pageIndex;
                          c.setCurrentAffirmation(
                              widget.playlist.affirmations![pageIndex]);
                          // LogUtil.v('aaa: $ids');
                        },
                      ),
                    ),
              //top app bar
              Positioned(
                top: 0,
                child: SafeArea(
                  top: true,
                  child: SizedBox(
                    width: kSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 22.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.playlist.affirmations!.first
                                      .subCategoryName ??
                                  '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appBarTitleTextStyle(
                                  color: kWhiteColor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            4.height,
                            Text(
                              'by Manifest',
                              style: customTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: descriptionColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 55,
                          width: 55,
                          child: showSvgIconWidget(
                              iconPath: AppIcons.affirmationLIst,
                              onTap: () {
                                // Get.bottomSheet(
                                //   AffirmationListSheet(widget.playlist),
                                //   isScrollControlled: true,
                                //   enableDrag: true,
                                //   // enterBottomSheetDuration: const Duration(milliseconds: 200),
                                //   // exitBottomSheetDuration: const Duration(milliseconds: 200),
                                // );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // 10.height,
              //       Text(
              //          '05 | 200x',
              //          style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: descriptionColor),
              //        ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: showSvgIconWidget(
                            iconPath: AppIcons.stopWatchGrey,
                            onTap: () {
                              // Get.bottomSheet(
                              //   const MediaPlayerSetTimerSheet(),
                              //   isScrollControlled: true,
                              //   enableDrag: true,
                              //   enterBottomSheetDuration:
                              //       const Duration(milliseconds: 500),
                              //   exitBottomSheetDuration:
                              //       const Duration(milliseconds: 500),
                              //   // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
                              // );
                            }),
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: showSvgIconWidget(
                          iconPath: AppIcons.loop,
                          onTap: () {
                            //Get.to(()=> AffirmationScreen());
                          },
                        ),
                      ),
                      StreamBuilder<Duration?>(
                        stream: c.player.positionStream,
                        builder: (context, snapshot) {
                          final Duration? duration = snapshot.data;
                          final double progressValue = duration != null &&
                                  duration.inMilliseconds > 0 &&
                                  c.player.duration != null
                              ? duration.inMilliseconds /
                                  c.player.duration!.inMilliseconds
                              : 0.0;
                          return SizedBox(
                            width: 64,
                            height: 64,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: CircularProgressIndicator(
                                    value: progressValue,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(194, 194, 194, 0.5),
                                    ),
                                    backgroundColor: const Color.fromRGBO(
                                        127, 127, 127, 0.2),
                                  ),
                                ),
                                Center(
                                  child: StreamBuilder<PlayerState>(
                                    stream: c.player.playerStateStream,
                                    builder: (context, state) {
                                      final processingState =
                                          state.data?.processingState;
                                      final playing = state.data?.playing;
                                      if (processingState ==
                                              ProcessingState.loading ||
                                          processingState ==
                                              ProcessingState.buffering) {
                                        return const SizedBox(
                                          width: 52,
                                          height: 52,
                                          child:
                                              FastCircularProgressIndicator(),
                                        );
                                      } else if (playing != true) {
                                        return GestureDetector(
                                          onTap: c.play,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            width: 52,
                                            height: 52,
                                            child: const Icon(
                                              Icons.play_arrow,
                                              color: Colors.black,
                                              size: 40,
                                            ),
                                          ),
                                        );
                                      } else if (processingState !=
                                          ProcessingState.completed) {
                                        return GestureDetector(
                                          onTap: c.pause,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            width: 52,
                                            height: 52,
                                            child: const Icon(
                                              Icons.pause,
                                              color: Colors.black,
                                              size: 40,
                                            ),
                                          ),
                                        );
                                      } else {
                                        // c.nextPage(); // Increment page index when audio is completed
                                        return GestureDetector(
                                          onTap: () async {
                                            // c.playAgain();
                                            c.pageController.jumpToPage(0);
                                            await c.player.seek(Duration.zero,
                                                index:
                                                    0); // Seek to the beginning of the first audio in the playlist
                                            await c.player.play();
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            width: 52,
                                            height: 52,
                                            child: const Icon(
                                              Icons.replay,
                                              color: Colors.black,
                                              size: 40,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Obx(() => c.isEdit.value == false
                            ? showSvgIconWidget(
                                iconPath: AppIcons.whiteHeart,
                                onTap: () {
                                  c.setEditValue(value: true);
                                  LogUtil.v(
                                      'bbb: ${c.currentAffirmation.value.id}');
                                  c.affirmationController.playlistTabController
                                      .addAffirmationToFavorite(
                                          affirmationID: c
                                              .currentAffirmation.value.id
                                              .toString());
                                },
                              )
                            : showSvgIconWidget(
                                iconPath: AppIcons.favoriteOutline,
                                onTap: () {
                                  c.setEditValue(value: false);
                                  LogUtil.v(
                                      'bbb: ${c.currentAffirmation.value.id}');
                                  c.affirmationController.playlistTabController
                                      .addAffirmationToFavorite(
                                          affirmationID: c
                                              .currentAffirmation.value.id
                                              .toString());
                                },
                              )),
                        // c.currentAffirmation.value.isFavorite == true
                        //     ? showSvgIconWidget(
                        //   iconPath: AppIcons.whiteHeart,
                        //   onTap: () {
                        //     LogUtil.v('bbb: ${c.currentAffirmation.value.id}');
                        //     c.affirmationController.addToFavorite(affirmationID: c.currentAffirmation.value.id);
                        //   })
                        //     : showSvgIconWidget(
                        //     iconPath: AppIcons.favouriteGreyOutline,
                        //     onTap: () {
                        //       LogUtil.v('bbb: ${c.currentAffirmation.value.id}');
                        //       c.affirmationController.addToFavorite(affirmationID: c.currentAffirmation.value.id);
                        //     })
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: showSvgIconWidget(
                            iconPath: AppIcons.filter,
                            onTap: () {
                              // Get.bottomSheet(
                              //   AudioSettings(c.currentAffirmation()),
                              //   isScrollControlled: true,
                              //   isDismissible: true,
                              //   enterBottomSheetDuration:
                              //       const Duration(milliseconds: 200),
                              //   exitBottomSheetDuration:
                              //       const Duration(milliseconds: 200),
                              // );
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
