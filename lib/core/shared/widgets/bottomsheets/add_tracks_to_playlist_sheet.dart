import 'package:manifest/core/shared/controllers/add_tracks_to_playlist_controller.dart';
import 'package:manifest/core/shared/widgets/custom_search_widget.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/flexible_wrap_grid.dart';
import 'package:manifest/core/shared/widgets/chips/selectable_chip.dart';
import 'package:manifest/helper/import.dart';

class AddTracksToPlaylistSheet extends StatelessWidget {
  final String playlistId;
  final VoidCallback? onButtonTap;

  const AddTracksToPlaylistSheet({
    Key? key,
    required this.playlistId,
    this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTracksToPlaylistController());

    return Obx(
      () => CustomBottomSheet(
        title: 'Add Tracks to Playlist',
        hasBackButton: false,
        primaryButtonText: 'Add ${controller.selectedTrackIds.length} tracks',
        onPrimaryButtonPressed: () {
          if (onButtonTap != null) {
            onButtonTap!();
          } else {
            controller.addTracksToPlaylist(playlistId);
          }
        },
        horizontalPadding: 20.r,
        contentPadding: EdgeInsets.zero,
        body: SizedBox(
          height: kSize.height * 0.90,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomSearchWidget(
                  hintText: 'What do you want to listen to?',
                  onSearchChanged: controller.onSearchChanged,
                ),
              ),
              24.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: FlexibleWrapGrid<String>(
                    padding: EdgeInsets.zero,
                    items: const ["All", "Tracks", "Albums"],
                    itemBuilder: (context, item, index) {
                      return SelectableChip(
                        label: item,
                        isSelected: item == "All",
                        selectedColor: AppColors.light,
                        unselectedColor: AppColors.light.withOpacity(0.05),
                        selectedTextColor: AppColors.dark,
                        unselectedBorderColor: AppColors.light.withOpacity(0.1),
                        horizontalPadding: 16.r,
                        verticalPadding: 6.r,
                        onTap: () {},
                      );
                    }),
              ),
              24.height,
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          padding: EdgeInsets.only(bottom: 160.h),
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.tracks.length,
                          itemBuilder: (context, index) {
                            final track = controller.tracks[index];
                            return Obx(
                              () => AppListTile.selectableWithTypeAndDuration(
                                artworkUrl: track['artworkUrl'],
                                title: track['title'],
                                type: track['type'],
                                duration: track['duration'],
                                isSelected: controller.selectedTrackIds
                                    .contains(track['id']),
                                onTap: () => controller
                                    .toggleTrackSelection(track['id']),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
