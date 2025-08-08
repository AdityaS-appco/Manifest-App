import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/core/shared/widgets/content_card.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/scene_settings_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/dynamic_color_scaffold.dart';
import 'package:manifest/core/shared/widgets/premium_banner.dart';
import 'package:manifest/core/shared/widgets/scrollable_tag_list.dart';
import 'package:manifest/features/create_account/creating_account_screen.dart';
import 'package:manifest/features/notification/views/notifications_list_screen.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/features/playlist/playlist_type.enum.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/home/widgets/home_header_button.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/playlist/favorite_tracks_playlist/favorite_track_page.dart';
import 'package:manifest/helper/icons_and_images_path.dart';
import 'package:manifest/view/navbar_screens/home/models/home_data_model_by_alok.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/gift_bottomsheet.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/my_collection_page.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/playlist/favorite_affirmations_playlist/favorite_playlist.dart';

import '../../../controllers/home_controller_two.dart';
import '../../../controllers/recent_played.dart';

class HomePageByAlok extends GetView<HomeTwoController> {
  const HomePageByAlok({super.key});

  @override
  Widget build(BuildContext context) {
    // ExplorerDetailController explorerDetailController =
    //     Get.put(ExplorerDetailController());
    final theme = Get.find<ThemeController>();
    final recentTracksController = Get.put(RecentTracksController());

    /// * when screen is rendered, display dialog
    controller.themeController.resetToDefaultColors();
    // Future.delayed(const Duration(seconds: 5), () => controller.showDialog());

    /// ! Do not remove: use the dynamic color scaffold reusable widget.
    return Obx(
      () {
        final sceneImage = controller.themeController.currentSceneImage.value;
        return DynamicColorScaffold(
          isLoading: controller.isProfileLoading,
          colorExtractor: controller.colorExtractor,
          imageUrl: sceneImage.isNotEmpty
              ? sceneImage
              : ImageConstants.defaultSceneImagePath,
          imageHeight: 473.h,
          transparentSpaceForImageVisibilityHeight: 248.h,
          extraSpaceAtTopOfPlaylistHeader: 150.h,
          headerPadding: EdgeInsets.symmetric(horizontal: 20.r),
          playlistHeaderChildren: [_homePageTitle()],
          contentPadding: EdgeInsets.zero,
          contentChildren: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
              child: Row(
                children: [
                  HomeHeaderButton(
                    title: AppStrings.myFavorite,
                    iconPath: IconAllConstants.newHeartRounded,
                    onTap: () {
                      Get.bottomSheet(_buildBottomSheet());
                    },
                  ),
                  17.width,
                  HomeHeaderButton(
                    title: AppStrings.myCollection,
                    iconPath: IconAllConstants.newLayersThree02,
                    onTap: () {
                      NavigationUtil.toWithDelay(
                        navigateTo: () => const MyCollectionPage(),
                      );
                    },
                  ),
                ],
              ),
            ),
            32.height,

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0.r,
              ),
              child: const PremiumBanner(),
            ),
            40.height,

            // Content sections
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                final data = controller.homeDataModel.value.data![index];
                if (data.content != null && data.content!.isNotEmpty) {
                  return 49.height;
                }
                return 0.height;
              },
              itemCount: controller.homeDataModel.value.data?.length ?? 0,
              itemBuilder: (context, index) {
                final data = controller.homeDataModel.value.data![index];
                if (data.content != null && data.content!.isNotEmpty) {
                  return _homePageSection(
                    data: data,
                    textColor: controller.themeController.gradientOneText,
                    onSeeAll: () async {
                      // await explorerDetailController.fetchPlaylists(controller
                      //         .homeDataModel
                      //         .value
                      //         .data![index]
                      //         .content[index]
                      //         .id
                      //         .toString() ??
                      //     "");
                      // NavigationUtil.toWithDelay(
                      //     navigateTo: SeeAllPage(title: "Tracks"));
                      // NavigationUtil.toWithDelay(
                      //     navigateTo: SeeAllPage(
                      //   title: data.title ?? "",
                      // ));
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            40.height,
          ],

          /// * manifest full logo
          leading: Transform.translate(
            offset: const Offset(70, 0),
            child: Transform.scale(
              scale: 2.5,
              child: SvgPicture.asset(
                "assets/logo/manifest_full_logo.svg",
              ),
            ),
          ),

          /// * appbar actions
          actions: [
            TransparentSvgCircleButton(
              AppIcons.homePaint,
              onPressed: () {
                AppBottomSheet.show(
                  const SceneSettingsBottomsheet(),
                );
              },
              iconSize: 20,
              padding: const EdgeInsets.all(10),
            ),
            TransparentSvgCircleButton(
              AppIcons.homeNotification,
              onPressed: () => NavigationUtil.toWithDelay(
                navigateTo: () => const NotificationsListScreen(),
              ),
              iconSize: 30,
            ),
            TransparentSvgCircleButton(
              AppIcons.homeGift,
              onPressed: () {
                AppBottomSheet.show(
                  const GiftBottomSheet(),
                );
              },
              iconSize: 20,
            ),
            10.width,
          ],
        );
      },
    );
  }

  Widget _homePageSection({
    required HomeData data,
    required Color textColor,
    VoidCallback? onSeeAll,
  }) {
    // final List<String> tags = [
    //   'All',
    //   'Confidence',
    //   'Beauty',
    //   'Stress',
    //   'Happiness',
    // ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: _homePageSectionHeader(
            data.title?.capitalize ?? "",
            textColor,
            data.subtitle,
            onSeeAll: onSeeAll,
            showLeadingIcon: data.key == "forYou",
          ),
        ),

        20.height,

        /// todo: if the title is tailored for you
        if (data.tagList.isNotEmpty) ...[
          ScrollableTagList(
            tags: data.tagList,
            onTagSelected: (selectedTag) {
              // todo: Handle tag selection
            },
          ),
          16.height,
        ],

        SizedBox(
          height: 253.h,
          child: data.content.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: data.content.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      16.width,
                  itemBuilder: (BuildContext context, int index) {
                    return _homePageSectionCard(
                      data: data.content[index],
                      cardType: _getCardType(data.key),
                    );
                  },
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  // ! @author: alok singh
  // * alok's design for home page section card
  Widget _homePageSectionCard({
    required Content data,
    required ContentCardType cardType,
  }) {
    return ContentCard(
      image: data.image,
      title: data.name ?? '',
      subtitle: "${data.type!.capitalize} $dotChar ${data.authorName}",
      isLocked: data.isPremium,
      isPlaylist: data.isPlaylist,
      duration: data.durationInSecondsString,
      cardType: cardType,
      id: data.id,
      playlistType: PlaylistType.admin,
    );
  }

  ContentCardType _getCardType(String? key) {
    if (key?.toLowerCase() == 'featured') {
      return ContentCardType.rectangle;
    } else {
      return ContentCardType.square;
    }
  }

  Widget _homePageSectionHeader(
    String title,
    Color textColor,
    String? subtitle, {
    VoidCallback? onSeeAll,
    bool showLeadingIcon = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (showLeadingIcon) ...[
              SvgPicture.asset(
                IconAllConstants.tailoredForYouStar,
                height: 20.r,
                width: 20.r,
              ),
              4.width,
            ],
            Text(
              title,
              style: primaryWhiteHelveticaRoundedBoldTextStyle(
                fontSize: 20.0,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                "See All",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        /// * subtitle
        if (subtitle != null && subtitle != '') ...[
          8.height,
          Text(
            subtitle,
            style: secondaryWhiteTextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w400,
            ),
          ),
        ]

        /// * tabbar for Tailored for you section
      ],
    );
  }

  Widget _homePageTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: customTextStyle(color: lightGreyColor, fontSize: 20.0),
            children: <TextSpan>[
              TextSpan(
                text: getGreeting(),
                style: Get.appTextTheme.homeGreetingText,
              ),
              TextSpan(
                text:
                    ' ${controller.profile.name?.split(" ").first.capitalize ?? ''} ${getGreetingIcon()}',
                style: Get.appTextTheme.homeGreetingText
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// **Bottom Sheet UI**
Widget _buildBottomSheet() {
  return BlurContainer(
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "My Favorite",
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: AppFonts.helvetica.name,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("Affirmations",
                  onTap: () => NavigationUtil.toWithDelay(
                      navigateTo: () => const FavoriteAffirmationPlaylist())),
              _buildButton("Tracks",
                  onTap: () => NavigationUtil.toWithDelay(
                      navigateTo: () => const FavoriteTracksPage())),
            ],
          ),
        ],
      ),
    ),
  );
}

/// **Button Widget**
Widget _buildButton(String text, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap, // Call the callback function when tapped
    child: Container(
      width: 120, // Set a fixed width for both buttons
      padding: const EdgeInsets.symmetric(
          vertical: 14), // Adjust padding for consistent height
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2), // White with opacity 0.2
        border: Border.all(color: Colors.white), // White border
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontFamily: AppFonts.helvetica.name,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
