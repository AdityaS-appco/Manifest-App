import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:manifest/controllers/affirmation_controller.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/create_content_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/custom_search_widget.dart';
import 'package:manifest/core/utils/media_util.dart';
import 'package:manifest/features/playlist/by_you/views/by_you_by_alok.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/playlist/all_playLists_main_screen.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/download/download_main_page.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';

class PlaylistPage extends GetView<PlaylistTabController> {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: GetBuilder<AffirmationController>(
          init: AffirmationController(),
          builder: (c) {
            return DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Scaffold(
                body: Container(
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          toolbarHeight: kSize.height * 0.18,
                          elevation: 0,
                          surfaceTintColor: Colors.white,
                          centerTitle: false,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () {
                                      return Text(
                                        _getTitle,
                                        style: Get.appTextTheme.pageTitle
                                            .copyWith(height: 1.21),
                                      );
                                    },
                                  ),
                                  if (controller.currentTabIndex.value == 0)
                                    SvgCircleButton(
                                      enabledColor: Colors.transparent,
                                      borderColor:
                                          AppColors.light.withOpacity(0.2),
                                      IconAllConstants.plus,
                                      iconColor:
                                          AppColors.light.withOpacity(0.8),

                                      /// * create playlist OR upload mp3 (when in by you tab)
                                      onPressed: () {
                                        final image = Rxn<File>();
                                        AppBottomSheet.show(
                                          Obx(
                                            () {
                                              return CreateContentBottomsheet
                                                  .playlist(
                                                nameController:
                                                    controller.newPlaylistName,
                                                onCreatePressed: () => controller
                                                    .createOrUpdateNewPlaylist(
                                                  image: image.value,
                                                ),
                                                imageUrl: image.value?.path,
                                                onImageEditPressed: () async {
                                                  image.value = await MediaUtil
                                                      .pickAndCropImage(
                                                    imageSource:
                                                        ImageSource.gallery,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    )
                                ],
                              ),
                              24.height,
                              const CustomSearchWidget(),
                            ],
                          ),
                          pinned: true,
                          floating: true,
                          forceElevated: innerBoxIsScrolled,
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(60.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 60,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                alignment: Alignment.topLeft,
                                child: TabBar(
                                  controller: controller.tabController,
                                  onTap: (index) {
                                    c.setCurrentTab(index);
                                  },
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelStyle: Get.appTextTheme.tabMediumActive,
                                  unselectedLabelStyle:
                                      Get.appTextTheme.tabMediumInactive,
                                  indicatorColor: Colors.white,
                                  dividerHeight: 0,
                                  isScrollable: true,
                                  tabAlignment: TabAlignment.start,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  tabs: [
                                    Tab(
                                      text: AppStrings.all,
                                    ),
                                    Tab(text: AppStrings.byYou),
                                    Tab(text: AppStrings.downloads),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: controller.tabController,
                      children: const <Widget>[
                        AllPlayListTabPage(),
                        ByYouByAlok(),
                        DownloadMainPage(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  String get _getTitle {
    return switch (controller.currentTabIndex.value) {
      0 => AppStrings.myPlaylist,
      1 => AppStrings.byYou,
      2 => AppStrings.downloads,
      _ => AppStrings.myPlaylist,
    };
  }
}
