import 'package:manifest/core/services/playlist_service.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/home/media_player/affirmation_options/audio_settings/create_new_playlist_home_affirmation.dart';

class AddToPlayList extends StatefulWidget {
  final int trackId;
  const AddToPlayList(this.trackId, {super.key});

  @override
  State<AddToPlayList> createState() => _AddToPlayListState();
}

class _AddToPlayListState extends State<AddToPlayList> {
  int? selectedRadio;

  /// * Initialize playlist service
  final playlistService = Get.find<PlaylistService>();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    selectedRadio = 0;

    // playlistService.onInit();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    // HomeMediaPlayerController c = Get.find<HomeMediaPlayerController>();

    return Container(
      height: kSize.height * 0.86,
      width: kSize.width,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(140, 140, 140, 1),
            offset: Offset(0, 50), // horizontal and vertical offsets
            blurRadius: 100.0,
          ),
        ],
        color: Color.fromRGBO(37, 37, 37, 10),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(119, 116, 128, 0.18),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    )),
                child: Column(
                  children: [
                    10.height,
                    //Container
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 36,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(194, 194, 194, 0.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    4.height,
                    //Close button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromRGBO(127, 127, 127, 0.4),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: kWhiteColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    //Text
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add to playlist',
                            style: secondaryWhiteTextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              20.height,

              /// * Create new playlist
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        const CreateNewPlayList(),
                        isScrollControlled: true,
                        enableDrag: false,
                        isDismissible: false,
                        enterBottomSheetDuration:
                            const Duration(milliseconds: 200),
                        exitBottomSheetDuration:
                            const Duration(milliseconds: 200),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline_sharp,
                            color: descriptionLightColor),
                        5.width,
                        Text('Create new playlist',
                            style: primaryWhiteTextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  )),
              Gap(34.h),
              Expanded(
                child: Obx(
                  () => ListView.separated(
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: Divider(
                            color: AppColors.grey.withOpacity(0.3),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: playlistService.playlists.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var playlist = playlistService.playlists[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 4.0),
                          onTap: () {},
                          leading: SizedBox(
                              height: 36.h,
                              width: 36.h,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      playlist.image.toString(),
                                      fit: BoxFit.cover,
                                      colorBlendMode: BlendMode.darken,
                                      color: Colors.black45,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                            color: inActiveSliderBgColor);
                                      },
                                    ),
                                  ) // Displaying a blank container if items.image is null
                                ],
                              )),
                          title: Text(
                            '${playlist.name}',
                            style: secondaryWhiteTextStyle(
                              fontSize: 17,
                              color: selectedRadio != playlist.id
                                  ? kWhiteColor.withOpacity(0.7)
                                  : null,
                            ),
                          ),
                          trailing: Radio(
                            value:
                                playlist.id, // the value of this radio button
                            groupValue: selectedRadio,
                            activeColor: Colors.greenAccent,
                            onChanged: (val) {
                              setSelectedRadio(val!);
                              // playlistService
                              //     .setSelectedPlaylist(value: val.toInt());
                            },
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    /// * add track to playlist
                    if (selectedRadio != null) {
                      final response =
                          await playlistService.addTracksToPlaylist(
                        playlistId: selectedRadio.toString(),
                        trackIds: [widget.trackId.toString()],
                      );

                      /// * close bottom sheet
                      Get.back();

                      if (response) {
                        /// * show success message
                        ToastUtil.success('Track added to playlist');
                      } else {
                        /// * show error message
                        ToastUtil.error('Something went wrong');
                      }
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffA28DF6),
                          Color(0xff5B4A9F)
                        ], // Change colors as needed
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Done',
                        style: customTextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: kWhiteColor),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
