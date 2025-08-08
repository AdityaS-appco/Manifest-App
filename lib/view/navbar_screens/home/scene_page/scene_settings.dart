import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/helper/icons_and_images_path.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/home/scene_page/choose_scene_page.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

class SceneSettings extends StatelessWidget {
  const SceneSettings({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HomeController());
    return BlurContainer(
      child: GetBuilder<HomeTwoController>(
          init: HomeTwoController(),
          builder: (c) {
            return Container(
              height: kSize.height * 0.80,
              width: kSize.width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(140, 140, 140, 10),
                    offset: Offset(0, 50),
                    spreadRadius: 0, // horizontal and vertical offsets
                    blurRadius: 100.0,
                  ),
                ],
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(37, 37, 37, 0.82),
                      Color.fromRGBO(37, 37, 37, 0.82),
                      // Color.fromRGBO(140, 140, 140, 10),
                    ]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                    vertical: kDefaultPadding / 3),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 10),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(122, 120, 128, 0.32),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.sceneVolume,
                                    style: customTextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      showSvgIconWidget(
                                          iconPath: AppIcons.volumeDown),
                                      Expanded(
                                        child: Obx(
                                          () => Slider(
                                            value: c.volume.value.toDouble(),
                                            min: 0.0,
                                            max: 100.0,
                                            activeColor: primaryColor,
                                            inactiveColor: Colors.grey.shade700,
                                            onChanged: (double newValue) {
                                              c.volume.value = newValue.round();
                                            },
                                          ),
                                        ),
                                      ),
                                      showSvgIconWidget(
                                          iconPath: AppIcons.volumeUp),
                                    ],
                                  ),
                                ],
                              ).paddingSymmetric(vertical: 14),
                            ),
                          ).paddingOnly(top: kSize.height * 0.08),
                          32.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.music_note,
                                    color: kWhiteColor,
                                  ),
                                  10.width,
                                  Text(
                                    AppStrings.playSoundsOutside,
                                    style: secondaryWhiteTextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Obx(() => CupertinoSwitch(
                                    activeColor: primaryColor,
                                    thumbColor: kWhiteColor,
                                    value: c.isMusicOn.value,
                                    onChanged: (value) => c.toggleMusic(),
                                  )),
                            ],
                          ),
                          32.height,
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Icon(
                          //           Icons.video_call_outlined,
                          //           color: kWhiteColor,
                          //         ),
                          //         10.width,
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               AppStrings.makeThemeDefault,
                          //               style: secondaryWhiteTextStyle(fontWeight: FontWeight.w500),
                          //             ),
                          //             Text(
                          //               AppStrings.whenChangingSoundScape,
                          //               style: primaryWhiteTextStyle(color: greyColor),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //     Obx(() => CupertinoSwitch(
                          //       activeColor: primaryColor,
                          //       thumbColor: kWhiteColor,

                          //       value: c.isVideoOn.value,
                          //       onChanged: (value) => c.toggleVideo(),
                          //     )),
                          //   ],
                          // ),
                          // 64.height,
                          // create theme selection section here
                          Column(
                            children: [
                              Row(
                                children: [
                                  showSvgIconWidget(
                                      iconPath: AppIcons.homePaint),
                                  10.width,
                                  Text(AppStrings.theme,
                                      style: secondaryWhiteTextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              24.height,
                              Obx(
                                () => SizedBox(
                                  height: 42,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: c.filterCategories.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          c.selectedFilter.value = index;
                                          c.dummyData.shuffle();
                                          c.update();
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 10),
                                          decoration: BoxDecoration(
                                            gradient: c.selectedFilter.value ==
                                                    index
                                                ? const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                        Color.fromRGBO(
                                                            162, 141, 246, 1),
                                                        Color.fromRGBO(
                                                            91, 74, 159, 1),
                                                      ])
                                                : const LinearGradient(colors: [
                                                    Color.fromRGBO(
                                                        121, 118, 128, 0.24),
                                                    Color.fromRGBO(
                                                        121, 118, 128, 0.24),
                                                  ]),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: Text(
                                            c.filterCategories[index].tr,
                                            style: customTextStyle(
                                                fontSize: 15.0,
                                                color: c.selectedFilter.value ==
                                                        index
                                                    ? Colors.white
                                                    : const Color.fromRGBO(
                                                        235, 235, 245, 0.6),
                                                fontWeight: FontWeight.w400),
                                          ).paddingSymmetric(horizontal: 12),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              24.height,
                              Obx(
                                () => SizedBox(
                                  height: kSize.height * 0.28,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: c.dummyData.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                            ChooseScenePage(
                                                selectedImage: DummyData
                                                    .dummyData[index].imageUrl),
                                            isScrollControlled: true,
                                            enableDrag: false,
                                            enterBottomSheetDuration:
                                                const Duration(
                                                    milliseconds: 200),
                                          );
                                        },
                                        child: Container(
                                          width: kSize.width * 0.30,
                                          height: kSize.height,
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: AppCachedImage(
                                            imageUrl: DummyData
                                                .dummyData[index].imageUrl,
                                            border: Get.find<ThemeController>()
                                                        .currentSceneImage
                                                        .value ==
                                                    DummyData.dummyData[index]
                                                        .imageUrl
                                                ? Border.all(
                                                    color: AppColors.light,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(194, 194, 194, 0.5),
                                Color.fromRGBO(194, 194, 194, 0.5),
                              ],
                              begin: Alignment.center,
                              end: Alignment.center,
                            ),
                            shape: BoxShape.circle),
                        // backgroundColor: const Color.fromRGBO(127, 127, 127, 0.4),
                        child: Icon(
                          Icons.close,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 36,
                      height: 5,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(194, 194, 194, 0.5),
                            Color.fromRGBO(194, 194, 194, 0.5),
                          ],
                          begin: Alignment.center,
                          end: Alignment.center,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
