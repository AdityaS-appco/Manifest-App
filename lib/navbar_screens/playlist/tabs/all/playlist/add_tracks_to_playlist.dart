import 'package:manifest/controllers/explore_controller.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class AddTracksToPlaylist extends StatefulWidget {
  final String? playlistID;
  const AddTracksToPlaylist({this.playlistID, super.key});

  @override
  State<AddTracksToPlaylist> createState() => _AddTracksToPlaylistState();
}

class _AddTracksToPlaylistState extends State<AddTracksToPlaylist> {
  @override
  Widget build(BuildContext context) {
    PlaylistTabController c2 = Get.find<PlaylistTabController>();
    return GetBuilder<ExploreController>(
        init: ExploreController(),
        builder: (c) {
          return Container(
            height: kSize.height * 0.90,
            width: kSize.width,
            decoration: const BoxDecoration(
              color: Color(0xff1d2125),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  27.height,
                  Center(
                    child: Text(
                      'Add tracks to playlist',
                      style: secondaryWhiteTextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          showSvgIconWidget(iconPath: AppIcons.search),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              style: primaryWhiteTextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle: primaryWhiteTextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white38),
                                hintText: 'What do you want to listen to?',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Filter Tags
                  12.height,
                  Obx(
                    () => SizedBox(
                      height: 70,
                      child: Wrap(
                        spacing: 8.0,
                        children: c.SecondfilterCategories.asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          String category = entry.value;
                          return GestureDetector(
                            onTap: () {
                              c.selectedFilter.value = index;
                              c.setSelectedFilter(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 00,
                                bottom: 12,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: c.selectedFilter.value == index
                                    ? Colors.white38
                                    : const Color.fromRGBO(235, 235, 245, 0.16),
                                border: Border.all(
                                  color: c.selectedFilter.value == index
                                      ? kWhiteColor
                                      : Colors.white24,
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Text(
                                category,
                                style: customTextStyle(
                                  fontSize: 13.0,
                                  color: kWhiteColor.withOpacity(0.90),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  12.height,
                  Expanded(
                    child: Obx(
                      () => c2.isLoading.value || c2.tracksList.data == null
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.grey.shade700,
                              strokeWidth: 2.0,
                            ))
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              shrinkWrap: true,
                              itemCount: c2.tracksList.data!.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var item = c2.tracksList.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 60.h,
                                                width: 60.w,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7.0),
                                                        child: Image.network(
                                                          item.image.toString(),
                                                          fit: BoxFit.cover,
                                                          colorBlendMode:
                                                              BlendMode.darken,
                                                          color: Colors.black45,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Container(
                                                              color:
                                                                  inActiveSliderBgColor,
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                    Icons.error,
                                                                    color: Colors
                                                                        .white60),
                                                              ),
                                                            );
                                                          },
                                                        )),
                                                    Center(
                                                        child: Icon(
                                                      index == 1
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                      color: kWhiteColor,
                                                      size: 34.0,
                                                    ))
                                                  ],
                                                )),
                                            12.width,
                                            Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${item.name} id: (${item.id})',
                                                    maxLines: 2,
                                                    style:
                                                        secondaryWhiteTextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  Text(
                                                    '${item.affirmationsCount} affirmations • duration',
                                                    style: customTextStyle(
                                                        color: lightGreyColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Checkbox(
                                        fillColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                                (Set<WidgetState> states) {
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return checkButton;
                                          }
                                          return Colors.transparent;
                                        }),
                                        checkColor: appBackgroundColor,
                                        value: c2.selectedTrackIds
                                            .contains(item.id),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == true) {
                                              c2.selectedTrackIds.add(item.id!);
                                            } else {
                                              c2.selectedTrackIds
                                                  .remove(item.id!);
                                            }
                                            // LogUtil.v('selectedIndex: ${c2.selectedTrackIds}');
                                            String? listOFList;
                                            listOFList =
                                                c2.selectedTrackIds.join(' ,');
                                            // LogUtil.v('listOFList: $listOFList');
                                          });
                                        },
                                      ),
                                      // ListTile(
                                      //     contentPadding: const EdgeInsets.all(0.0),
                                      //     onTap: () {},
                                      //     leading: SizedBox(
                                      //         height: 60,
                                      //         width: 60,
                                      //         child: Stack(
                                      //           fit: StackFit.expand,
                                      //           children: [
                                      //             ClipRRect(
                                      //                 borderRadius: BorderRadius.circular(7.0),
                                      //                 child: Image.network(
                                      //                   item.imageUrl,
                                      //                   fit: BoxFit.cover,
                                      //                   colorBlendMode: BlendMode.darken,
                                      //                   color: Colors.black45,
                                      //                 )),
                                      //             Center(
                                      //                 child: Icon(
                                      //               index == 1 ? Icons.pause : Icons.play_arrow,
                                      //               color: kWhiteColor,
                                      //               size: 34.0,
                                      //             ))
                                      //           ],
                                      //         )),
                                      //     title: Text(
                                      //       'MP3 $index',
                                      //       style: secondaryWhiteTextStyle(),
                                      //     ),
                                      //     subtitle: Text(
                                      //       '03:20',
                                      //       style: customTextStyle(color: lightGreyColor),
                                      //     ),
                                      //     trailing: IconButton(
                                      //         onPressed: () {},
                                      //         icon: Icon(
                                      //           Icons.circle_outlined,
                                      //           color: greyColor,
                                      //         )),
                                      // ),
                                    ],
                                  ),
                                );
                              }),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
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
              //close button
              Positioned(
                top: 10.0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14.0),
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
                  ),
                ),
              ),
              //Add Button
              Positioned(
                bottom: 0.0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kSize.width * 0.35, vertical: 5),
                    child: kGradientPrimaryColorButton(
                        onPressed: () {
                          c2.addTracksToPlaylist(
                              playlistID: widget.playlistID.toString());
                        },
                        text: 'Add'),
                  ),
                ),
              ),
            ]), //Padding
          );
        });
  }
}
