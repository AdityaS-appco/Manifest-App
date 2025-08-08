import 'dart:math';
import 'package:manifest/controllers/explore_controller.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/home/media_player/affirmation_options/audio_settings/soundscape_detail.dart';

class AddMoreSoundScape extends StatelessWidget {
  const AddMoreSoundScape({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ExploreController(),
        builder: (c) {
          return Container(
            height: kSize.height * 0.86,
            width: double.infinity,
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Soundscapes',
                                style:
                                    primaryWhiteHelveticaRoundedRegularTextStyle(
                                        color: kWhiteColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700)),
                            5.height,
                            Text('Listen to the melody of this blue planet',
                                style:
                                    primaryWhiteHelveticaRoundedRegularTextStyle(
                                        color: descriptionLightColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      // 20.height,
                      //Tags Row
                      Obx(
                        () => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          height: 42,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: c.filterCategories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  c.selectedFilter.value = index;
                                  c.setSelectedFilter(index);
                                  c.update();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: c.selectedFilter.value == index
                                        ? null
                                        : Colors.grey.shade800.withOpacity(0.3),
                                    gradient: c.selectedFilter.value == index
                                        ? const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color.fromRGBO(162, 141, 246, 1),
                                              Color.fromRGBO(91, 74, 159, 1)
                                            ], // Adjust gradient colors as needed
                                          )
                                        : null,
                                  ),
                                  child: Text(
                                    c.filterCategories[index],
                                    style: customTextStyle(
                                        fontSize: 15.0,
                                        color: c.selectedFilter.value == index
                                            ? kWhiteColor
                                            : kWhiteColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      Obx(() {
                        return Padding(
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: c.dummyData.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              var item = DummyData.dummyData[index];
                              Color randomColor = Color(
                                      (Random().nextDouble() * 0xFFFFFF)
                                          .toInt())
                                  .withOpacity(0.2);
                              return GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    const SoundScapeDetail(),
                                    isScrollControlled: true,
                                    enableDrag: true,
                                    enterBottomSheetDuration:
                                        const Duration(milliseconds: 200),
                                  );
                                },
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: randomColor,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 110,
                                            height: 110,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image:
                                                    NetworkImage(item.imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          10.height,
                                          Text(
                                            item.title,
                                            style: secondaryWhiteTextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(127, 127, 127, 0.4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 1.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: kWhiteColor,
                          size: 16,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 36,
                      height: 5,
                      decoration: BoxDecoration(
                        color: mediumGrey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
