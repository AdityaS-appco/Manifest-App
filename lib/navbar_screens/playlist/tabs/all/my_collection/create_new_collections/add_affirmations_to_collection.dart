import 'package:manifest/controllers/explore_controller.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/helper/import.dart';

import '../my_collection_page_controller.dart';

class AddAffirmationsToCollections extends StatefulWidget {
  int? createdCollectionID;
  AddAffirmationsToCollections({this.createdCollectionID, super.key});

  @override
  State<AddAffirmationsToCollections> createState() =>
      _AddAffirmationsToCollectionsState();
}

class _AddAffirmationsToCollectionsState
    extends State<AddAffirmationsToCollections> {
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
                      'Add affirmation to collection',
                      style: secondaryWhiteTextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  10.height,
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: customSearchWidget(),
                  // ),
                  //Filter Tags
                  //12.height,
                  // Obx(
                  //   () => SizedBox(
                  //     height: 70,
                  //     child: Wrap(
                  //       spacing: 8.0,
                  //       children: c.SecondfilterCategories.asMap().entries.map((entry) {
                  //         int index = entry.key;
                  //         String category = entry.value;
                  //         return GestureDetector(
                  //           onTap: () {
                  //             c.selectedFilter.value = index;
                  //             c.setSelectedFilter(index);
                  //           },
                  //           child: Container(
                  //             margin: const EdgeInsets.only(
                  //               left: 00,
                  //               bottom: 12,
                  //             ),
                  //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  //             decoration: BoxDecoration(
                  //               color: c.selectedFilter.value == index ? Colors.white38 : const Color.fromRGBO(235, 235, 245, 0.16),
                  //               border: Border.all(
                  //                 color: c.selectedFilter.value == index ? kWhiteColor : Colors.white24,
                  //               ),
                  //               borderRadius: BorderRadius.circular(50.0),
                  //             ),
                  //             child: Text(
                  //               category,
                  //               style: customTextStyle(
                  //                 fontSize: 13.0,
                  //                 color: kWhiteColor.withOpacity(0.90),
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                  const Gap(10),
                  Expanded(
                    child: Obx(
                      () => c2.isLoading.value ||
                              c2.affirmationList.data == null
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white30,
                              strokeWidth: 4.0,
                            ))
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              shrinkWrap: true,
                              itemCount: c2.affirmationList.data!.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var item = c2.affirmationList.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            122, 120, 128, 0.36),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: kSize.width * 0.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12.0,
                                                    top: 12.0,
                                                    left: 9.0),
                                                child: Text(
                                                  '${item.description}',
                                                  maxLines: 2,
                                                  style:
                                                      secondaryWhiteTextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Checkbox(
                                          fillColor: WidgetStateProperty
                                              .resolveWith<Color>(
                                                  (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.selected)) {
                                              return checkButton;
                                            }
                                            return Colors.transparent;
                                          }),
                                          checkColor: appBackgroundColor,
                                          value: c2.selectedAffirmationIDs
                                              .contains(item.id),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                c2.selectedAffirmationIDs
                                                    .add(item.id!);
                                              } else {
                                                c2.selectedAffirmationIDs
                                                    .remove(item.id!);
                                              }
                                              // LogUtil.v('selectedIndex: ${c2.selectedTrackIds}');
                                              String? listOFList;
                                              listOFList = c2
                                                  .selectedAffirmationIDs
                                                  .join(' ,');
                                              LogUtil.v(
                                                  'listOFList: $listOFList');
                                            });
                                          },
                                        ),
                                      ],
                                    ),
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
                        onPressed: () async {
                          await c2.addAffirmationsToCollection(
                              collectionID:
                                  widget.createdCollectionID.toString());
                          await c2.getCollectionByID(
                              collectionID:
                                  widget.createdCollectionID.toString());
                          await c2.getMyCollections();
                          Get.close(2);
                          // Refresh the collection list
                          Get.find<MyCollectionPageController>().onInit();
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
