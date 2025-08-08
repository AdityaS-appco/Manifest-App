import 'package:manifest/controllers/download/download_controller.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/player_setting_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/helper/import.dart';

class DownloadMainPage extends GetView<DownloadMainPageController> {
  const DownloadMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: !Get.find<PlaylistTabController>()
                            .showSearchResults
                            .value
                        ? controller.downloads.length
                        : controller.filteredDownloads.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final item = !Get.find<PlaylistTabController>()
                              .showSearchResults
                              .value
                          ? controller.downloads[index]
                          : controller.filteredDownloads[index];
                      return AppListTile.download(
                        title: item.title.toString(),
                        duration: item.description,
                        progress: 0.5.obs,
                        isDownloadInProgress: index == 2 || index > 5,
                        onTap: () {},
                        onMoreTap: () {
                          AppBottomSheet.show(
                            PlayerSettingBottomsheet(
                              artworkUrl: item.imageUrl,
                              title: item.title,
                              subtitle: item.duration,
                              isArtworkEditable: true,
                              options: [
                                PlayerSettingOption(
                                  title: 'Play Now',
                                  iconPath: IconAllConstants.play,
                                  onTap: () {},
                                ),
                                PlayerSettingOption(
                                  title: 'Share',
                                  iconPath: IconAllConstants.share01,
                                  onTap: () {
                                    // AppBottomSheet.show(ShareTrackBottomsheet(
                                    //   imageUrl: item.imageUrl,
                                    //   trackName: item.title,
                                    //   shareLink:
                                    //       "https://manifest.com/download",
                                    // ));
                                  },
                                ),
                                PlayerSettingOption(
                                  title: 'Download',
                                  iconPath: IconAllConstants.download02,
                                  onTap: () {},
                                ),
                                PlayerSettingOption(
                                  title: 'Add to Favorite',
                                  iconPath:
                                      IconAllConstants.heartRoundedOutlined,
                                  onTap: () {},
                                ),
                                PlayerSettingOption(
                                  title: 'Rename Audio',
                                  iconPath: IconAllConstants.edit03,
                                  onTap: () {},
                                ),
                                PlayerSettingOption(
                                  title: 'Delete Audio',
                                  iconColor: AppColors.error,
                                  iconPath: IconAllConstants.trash03,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    })),
                Gap(kSize.height * 0.12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
