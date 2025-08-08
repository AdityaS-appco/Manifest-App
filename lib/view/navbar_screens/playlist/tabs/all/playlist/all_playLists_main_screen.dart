import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/loading_wrapper.dart';
import 'package:manifest/core/shared/widgets/flexible_wrap_grid.dart';
import 'package:manifest/core/shared/widgets/chips/selectable_chip.dart';
import 'package:manifest/features/explore/views/playlist_details_screen.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/playlist/favorite_affirmations_playlist/favorite_playlist.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/my_collection_page.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/playlist/favorite_tracks_playlist/favorite_track_page.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/playlist/my_playlists/my_playlists_main_page.dart';

class AllPlayListTabPage extends StatelessWidget {
  const AllPlayListTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaylistTabController controller = Get.put(PlaylistTabController());

    return LoadingWrapper(
      isInitialLoading: controller.isLoading,
      isLoading: controller.isLoading,
      onRefresh: () => controller.getMyPlaylistData(),
      isRefreshing: controller.isRefreshingPlaylistDataRx,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.height,

            FlexibleWrapGrid<String>(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16, right: 16).r,
                items: const ["All", "Tracks", "Playlists", "Collections"],
                itemBuilder: (context, item, index) {
                  return SelectableChip(
                    label: item,
                    isSelected: item == "All",
                    selectedColor: AppColors.light,
                    unselectedColor: AppColors.light.withOpacity(0.05),
                    selectedTextColor: AppColors.dark,
                    unselectedBorderColor: AppColors.light.withOpacity(0.1),
                    horizontalPadding: 16,
                    selectedTextStyle: Get.appTextTheme.pillActiveTabTextMedium,
                    textStyle: Get.appTextTheme.pillInactiveTabTextMedium,
                    verticalPadding: 6,
                    onTap: () {},
                  );
                }),
            13.height,

            /// * if search query is not empty and 1st tab is active
            if (!controller.showSearchResults.value &&
                controller.currentTabIndex.value == 0) ...[
              Column(
                children: [
                  Obx(
                    () => AppListTile.gradientIcon(
                      icon: IconAllConstants.heartRounded,
                      title: AppStrings.favoriteAffirmations,
                      subtitle:
                          '${controller.favoriteAffirmationsMeta.affirmationCountMeta.toString()} affirmations $dotChar ${formatDurationInSeconds(controller.favoriteAffirmationsMeta.durationInSecondsMeta)}',
                      gradientColors: AppColors.pastelLinearGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      onTap: () {
                        Get.to(() => const FavoriteAffirmationPlaylist());
                      },
                    ),
                  ),
                  Obx(
                    () => AppListTile.gradientIcon(
                      icon: IconAllConstants.musicNote01,
                      title: AppStrings.favoriteTracks,
                      subtitle:
                          '${controller.favoriteTracksMeta.affirmationCountMeta.toString()} ${AppStrings.track} $dotChar ${formatDurationInSeconds(controller.favoriteTracksMeta.durationInSecondsMeta)}',
                      onTap: () {
                        Get.to(() => const FavoriteTracksPage());
                      },
                      gradientColors: AppColors.blueLinearGradient,
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  Obx(
                    () => AppListTile.gradientIcon(
                      icon: IconAllConstants.bookmark,
                      title: AppStrings.myCollection,
                      subtitle:
                          '${controller.myCollectionsMeta.collectionCountMeta.toString()} ${AppStrings.collections}',
                      onTap: () {
                        Get.to(() => const MyCollectionPage());
                      },
                      gradientColors: AppColors.pinkLinearGradient,
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  Obx(
                    () => AppListTile.gradientIcon(
                      icon: IconAllConstants.layersThree02,
                      title: "Favorite Playlists",
                      subtitle:
                          '${controller.favoritePlaylistsMeta.playlistCountMeta.toString()} ${AppStrings.playlists}',
                      onTap: () {
                        Get.to(() => const UserPlaylistPage());
                      },
                      gradientColors: AppColors.customLinearGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
            ],

            Obx(
              () => ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: controller.playlistContent.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = controller.playlistContent[index];
                  return Material(
                    color: Colors.transparent,
                    child: AppListTile.playlistWithCreatorName(
                      title: item.name?.capitalize ?? '',
                      creatorName:
                          '${item.tracksCount ?? 0} ${AppStrings.track}',
                      artworkUrl: item.image?.imageName ?? "",
                      onTap: () {
                        Get.to(
                          () => const PlaylistDetailsScreen(),
                          arguments: {
                            ArgumentConstants.playlistId: item.id,
                            ArgumentConstants.playlistType: item.createdBy,
                          },
                        );
                      },
                      onMoreTap: () {
                        // Handle more options
                      },
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.r,
                        vertical: 11.r,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: kSize.height * 0.08,
            ),
          ],
        ),
      ),
    );
  }

  String formatDurationInSeconds(int seconds) {
    if (seconds < 60) {
      return '$seconds sec';
    }
    return '${seconds ~/ 60} min';
  }
}
